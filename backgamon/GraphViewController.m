//
//  GraphViewController.m
//  backgamon
//
//  Created by maxeler on 1/23/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"
#import "HistoryView.h"
#import "MaxColor.h"

@interface GraphViewController ()

@property UIImageView *background;

@property UIView *historyView;
@property NSMutableArray<UILabel *> *historyRootsViews;
@property NSMutableArray *historyRoots;

@property UIView *graphView;

@property UILabel *rootView;
@property NSMutableArray<UILabel *> *childrenViews;

@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"Graph";
    
    self.background = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.background.image = [UIImage imageNamed:@"felt"];
    [self.view addSubview:self.background];
    
    self.graphView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.3, 0, self.view.frame.size.width *0.7, self.view.frame.size.height-94)];
    self.graphView.backgroundColor = [UIColor translucentCloudsColor];
    [self.view addSubview:self.graphView];
    
    self.root[@"value"] = [self getValueForRoot:self.root][@"value"];
    self.children = [self getChildrenForRoot:self.root];
    
    self.historyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width *0.3, self.view.frame.size.height-94)];
    [self.view addSubview:self.historyView];
    
    self.historyRoots = [NSMutableArray arrayWithArray:@[self.root]];
    
    self.historyRootsViews = [NSMutableArray new];
    for(NSInteger i = 0; i < [self.root[@"depth"] intValue]; i++) {
        UILabel *view = [[UILabel alloc] init];
        view.clipsToBounds = YES;
        view.userInteractionEnabled = YES;
        view.textAlignment = NSTextAlignmentCenter;
        [self.historyView addSubview:view];
        view.backgroundColor = [UIColor blueColor];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(historyViewTaped:)];
        [view addGestureRecognizer:tapRecognizer];
        view.tag=i;
        
        [self.historyRootsViews addObject:view];
    }
    
    self.rootView = [[UILabel alloc] init];
    self.rootView.clipsToBounds = YES;
    self.rootView.userInteractionEnabled = YES;
    self.rootView.textAlignment = NSTextAlignmentCenter;
    self.rootView.numberOfLines = 0;
    self.rootView.backgroundColor = [UIColor redColor];
    [self.graphView addSubview:self.rootView];
    
    self.childrenViews = [NSMutableArray new];
    for(NSInteger i = 0; i < 36; i++) {
        UILabel *view = [[UILabel alloc] init];
        view.clipsToBounds = YES;
        view.userInteractionEnabled = YES;
        view.textAlignment = NSTextAlignmentCenter;
        view.adjustsFontSizeToFitWidth=YES;
        view.minimumScaleFactor=0.01;
        [self.graphView addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(childrenViewTaped:)];
        [view addGestureRecognizer:tapRecognizer];
        view.tag=i;
        
        [self.childrenViews addObject:view];
    }
}

- (void)viewWillLayoutSubviews;
{
    [super viewWillLayoutSubviews];
    
    [self layoutCircleAnimated:NO];
}

- (void)layoutCircleAnimated:(BOOL)animated;
{
    CGFloat duration = animated ? 1 : 0;
    
    NSUInteger numberOfParents = [self.historyRoots count];
    NSUInteger numberOfChildren = [self.children count];
    
    // reset
    for(NSInteger i = numberOfChildren; i < [self.childrenViews count]; i++) {
        CGRect frame = self.childrenViews[i].frame;
        frame.origin.x += frame.size.width/2;
        frame.origin.y += frame.size.height/2;
        frame.size.width = 0;
        frame.size.height = 0;
        [self resizeCircleView:self.childrenViews[i] toFrame:frame duration:duration];
    }
    
    for(NSInteger i = numberOfParents; i < [self.historyRootsViews count]; i++) {
        CGRect frame = self.historyRootsViews[i].frame;
        frame.origin.x += frame.size.width/2;
        frame.origin.y += frame.size.height/2;
        frame.size.width = 0;
        frame.size.height = 0;
        [self resizeCircleView:self.historyRootsViews[i] toFrame:frame duration:duration];
    }
    
    // root view
    CGFloat offset = 5;
    CGFloat sizeWidth = self.graphView.frame.size.width/6;
    CGFloat sizeHeight = self.graphView.frame.size.height/8;
    CGFloat size = MIN(sizeWidth, sizeHeight);
    CGFloat radius = size - 2*offset;
    
    [self resizeCircleView:self.rootView toFrame:CGRectMake(3*sizeWidth - radius, offset, 2*radius, 2*radius) duration:duration];
    
    self.rootView.text = [NSString stringWithFormat:@"%@\n%.2lf", self.root[@"type"], [self.root[@"value"] doubleValue]];
    
    // children views
    for(NSInteger i = 0; i<numberOfChildren; i++) {
        CGRect frame = CGRectMake((i%6 + 0.5) * sizeWidth - radius/2, (i/6 + 2.5) * sizeHeight - radius/2, radius, radius);
        [self resizeCircleView:self.childrenViews[i] toFrame:frame duration:duration];
        self.childrenViews[i].text = [NSString stringWithFormat:@"%.2lf", [self.children[i][@"value"] doubleValue]];
        
        if([self.children[i][@"value"] doubleValue] == [self.root[@"value"] doubleValue]) {
            self.childrenViews[i].layer.borderColor = [[UIColor redColor] CGColor];
            self.childrenViews[i].layer.borderWidth = 5;
        } else {
            self.childrenViews[i].layer.borderColor = [[UIColor clearColor] CGColor];
        }
    }
    
    // history views
    
    sizeWidth = self.historyView.frame.size.width;
    sizeHeight = self.historyView.frame.size.height / numberOfParents;
    size = MIN(sizeWidth, sizeHeight);
    radius = size - 2*offset;
    
    for(NSInteger i = 0; i < numberOfParents; i++) {
        CGRect frame = CGRectMake(sizeWidth/2 - radius/2, (i + 0.5) * sizeHeight - radius/2, radius, radius);
        [self resizeCircleView:self.historyRootsViews[i] toFrame:frame duration:duration];
        
        self.historyRootsViews[i].text = self.historyRoots[i][@"type"];
    }
}

- (void)resizeCircleView:(UIView *)circle toFrame:(CGRect)frame duration:(CGFloat)duration
{
    
    CGRect estimateFrame = frame;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [circle setFrame:estimateFrame];
    } completion:nil];
    
    CGFloat estimateCorner = estimateFrame.size.width / 2;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = @(circle.layer.cornerRadius);
    animation.toValue = @(estimateCorner);
    animation.duration = duration;
    [circle.layer setCornerRadius:estimateCorner];
    [circle.layer addAnimation:animation forKey:@"cornerRadius"];
}

#pragma mark - Gesture

-(void)historyViewTaped:(UITapGestureRecognizer*)sender;
{
    NSInteger index = sender.view.tag;
    
    NSLog(@"pre %@",self.root);
    
    self.root = self.historyRoots[index];
    self.children = [self getChildrenForRoot:self.root];
    
    NSInteger numberOfParents = [self.historyRoots count];
    for(NSInteger i = index + 1; i < numberOfParents; i++) {
        [self.historyRoots removeLastObject];
    }
    
    NSLog(@"pre %@",self.root);
    
    [self layoutCircleAnimated:YES];
}

-(void)childrenViewTaped:(UITapGestureRecognizer*)sender;
{
    NSInteger index = sender.view.tag;
    
    NSLog(@"pre %@",self.root);
    
    if([self.children[index][@"depth"] integerValue] == 0) return;
    
    self.root = self.children[index];
    self.children = [self getChildrenForRoot:self.root];
    
    [self.historyRoots addObject:self.root];
    
    NSLog(@"posle %@",self.root);
    
    [self layoutCircleAnimated:YES];
}

#pragma mark - Root

- (NSMutableArray*)getChildrenForRoot:(NSMutableDictionary *)root;
{
    NSMutableArray *moves = [self getMovesForRoot:root];
    
    NSLog(@"%@", moves);
    
    NSMutableArray *children = [NSMutableArray new];
    
    if([moves count] == 0) {
        for(NSUInteger i = 1; i <= 6; i++) {
            for(NSUInteger j = 1; j <= 6; j++) {
                @autoreleasepool {
                    NSMutableArray *dices = [NSMutableArray arrayWithArray:@[@(i), @(j)]];
                    NSMutableDictionary *child = [NSMutableDictionary dictionaryWithDictionary:@{
                        @"dices" : dices,
                        @"board" : root[@"board"],
                        @"depth" : @([root[@"depth"] intValue] - 1),
                        @"first" : root[@"first"],
                        @"player" : @([root[@"playAgain"] boolValue] ? [root[@"player"] intValue] : ![root[@"player"] intValue]),
                        @"playAgain" : @([dices[0] isEqual:dices[1]])
                    }];
                    NSMutableDictionary *dic = [self getValueForRoot:child];
                    child[@"value"] = dic[@"value"];
                    child[@"type"] = dic[@"type"];
                    [children addObject:child];
                }
            }
        }
    }
    
    for(NSMutableDictionary *move in moves) {
        @autoreleasepool {
            NSMutableArray *dices = [root[@"dices"] mutableCopy];
            NSInteger index = [dices indexOfObject:move[@"dice"]];
            [dices removeObjectAtIndex:index];
            NSMutableDictionary *child = [NSMutableDictionary dictionaryWithDictionary:@{
                @"dices" : dices,
                @"board" : [Bot applayMove:move toBoard:root[@"board"]],
                @"depth" : @([root[@"depth"] intValue] - 1),
                @"first" : root[@"first"],
                @"player" : root[@"player"],
                @"playAgain" : root[@"playAgain"]
            }];
            NSMutableDictionary *dic = [self getValueForRoot:child];
            child[@"value"] = dic[@"value"];
            child[@"type"] = dic[@"type"];
            NSLog(@"value %@", child[@"value"]);
            [children addObject:child];
        }
    }
    
    return children;
}

- (NSMutableDictionary *)moveRoot:(NSMutableDictionary *)root toChild:(NSMutableDictionary *)child;
{
    child[@"board"] = root[@"board"];
    
    if([child objectForKey:@"move"] != nil) {
        NSMutableArray *dices = [root[@"dices"] mutableCopy];
        NSInteger index = [dices indexOfObject:child[@"move"][@"dice"]];
        [dices removeObjectAtIndex:index];
        
        child[@"dices"] = dices;
        child[@"board"] = [Bot applayMove:child[@"move"] toBoard:root[@"board"]];
    }
    
    child[@"depth"] = @([root[@"depth"] intValue] - 1);
    child[@"first"] = root[@"first"];
    
    
    if([child[@"dices"] count] == 0) {
        child[@"type"] = @"EXP";
        child[@"player"] = @([root[@"playAgain"] boolValue] ? [root[@"player"] intValue] : ![root[@"player"] intValue]);
        
    } else {
        child[@"player"] = root[@"player"];
        child[@"type"] = [child[@"player"] isEqual:child[@"first"]] ? @"MAX" : @"MIN";
        
        if([child[@"dices"] count] == 2) {
            child[@"playAgain"] = @([child[@"dices"][0] isEqual:child[@"dices"][1]]);
        } else {
            child[@"playAgain"] = root[@"playAgain"];
        }
    }
    
    return child;
}

- (NSMutableDictionary *)getValueForRoot:(NSMutableDictionary *)root;
{
    return [Bot getMoveForPlayer:[root[@"player"] intValue] withBoard:root[@"board"]
                    dices:root[@"dices"] first:[root[@"first"] intValue] depth:[root[@"depth"] intValue]
                    alpha:-100000 beta:100000 playAgain:[root[@"playAgain"] boolValue]];
}

- (NSMutableArray *)getMovesForRoot:(NSMutableDictionary *)root;
{
    return [Bot getPosibleMovesForPlayer:[root[@"player"] integerValue] withBoard:root[@"board"]
                                   dices:root[@"dices"]  first:[root[@"first"] intValue]];
}

@end
