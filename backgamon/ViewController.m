//
//  ViewController.m
//  backgamon
//
//  Created by maxeler on 1/20/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "ViewController.h"
#import "MaxColor.h"
#import "Board.h"
#import "GraphViewController.h"
#import "UINavigationController+ShowViewController.h"

@interface ViewController () <BoardWon>

@property Board *board;

@property UIImageView *background;

@property UIImageView *left;
@property UIImageView *right;

@property UIImageView *top;
@property UIImageView *bottom;

@property UIImageView *end;
@property UIView *middle;
@property UIImageView *rightEnd;

@property CGFloat borderWidth;

@property NSMutableArray* wins;

@end

#define RED 0
#define WHITE 1

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.bounds.size.height-74;
    
    self.borderWidth = 24;
    
    CGFloat offset = 15;
    
    self.background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.background.image = [UIImage imageNamed:@"felt"];
    [self.view addSubview:self.background];
    
    CGFloat size = floor((width - 2*self.borderWidth -2*offset)/14.5);
    
    CGFloat border = size/2 - self.borderWidth;
    
    UIColor *borderColor = [UIColor translucentColorFromColor:[UIColor brownColor] withAlpha:0.75];
    
    self.rightEnd = [[UIImageView alloc] initWithFrame:CGRectMake(size*7 + offset, 0, size*7 + border + 3*self.borderWidth, height)];
    self.rightEnd.image = [UIImage imageNamed:@"three_texture2"];
    [self.view addSubview:self.rightEnd];
    
    self.left = [[UIImageView alloc] initWithFrame:CGRectMake(offset, 0, size*6 + 2*self.borderWidth, height)];
    self.left.image = [UIImage imageNamed:@"three_texture2"];
    self.left.layer.borderColor = [borderColor CGColor];
    self.left.layer.borderWidth = self.borderWidth;
    [self.view addSubview:self.left];
    
    self.right = [[UIImageView alloc] initWithFrame:CGRectMake(size*7 + offset, 0, size*6 + 2*self.borderWidth, height)];
    self.right.layer.borderColor = [borderColor CGColor];
    self.right.layer.borderWidth = self.borderWidth;
    [self.view addSubview:self.right];
    
    self.top = [[UIImageView alloc] initWithFrame:CGRectMake(1+size*6+offset+self.borderWidth, height/5 -size/2, size, size)];
    self.top.image = [UIImage imageNamed:@"hindge"];
    [self.view addSubview:self.top];
    
    self.bottom = [[UIImageView alloc] initWithFrame:CGRectMake(1+size*6+offset+self.borderWidth, height/5*4 - size/2, size, size)];
    self.bottom.image = [UIImage imageNamed:@"hindge"];
    [self.view addSubview:self.bottom];
    
    self.end = [[UIImageView alloc] initWithFrame:CGRectMake(size*13 + offset + 2*self.borderWidth, 0, size+border+self.borderWidth, height)];
    [self addUpperBorder:UIRectEdgeTop color:borderColor thickness:self.borderWidth toView:self.end];
    [self addUpperBorder:UIRectEdgeBottom color:borderColor thickness:self.borderWidth toView:self.end];
    [self addUpperBorder:UIRectEdgeLeft color:borderColor thickness:border toView:self.end];
    [self addUpperBorder:UIRectEdgeRight color:borderColor thickness:self.borderWidth toView:self.end];
    [self.view addSubview:self.end];
    
    CGFloat triangleHeight = (height - 2*self.borderWidth) * 0.45*0.75;
    self.middle = [[UIView alloc] initWithFrame:CGRectMake(size*13 + offset + 2*self.borderWidth + border, triangleHeight + self.borderWidth, size, height - 2*triangleHeight-2*self.borderWidth)];
    self.middle.backgroundColor = borderColor;
    [self.view addSubview:self.middle];
    
    self.board = [[Board alloc] initWithFrame:CGRectMake(self.borderWidth + offset, self.borderWidth, width-2*self.borderWidth-2*offset, height-2*self.borderWidth)];
    self.board.useRedBot = self.redBotDif !=0;
    self.board.useWhiteBot = self.whiteBotDif != 0;
    self.board.redBotDeapth = self.redBotDif;
    self.board.delegate = self;
    self.board.whiteBotDeapth = self.whiteBotDif;
    self.board.clipsToBounds = NO;
    
    if(self.board.redBotDeapth == 0) self.board.redBotDeapth++;
    if(self.board.whiteBotDeapth == 0) self.board.whiteBotDeapth++;
    
    [self.view addSubview:self.board];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Graph" style:UIBarButtonItemStylePlain target:self action:@selector(showGraphView)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    self.wins = [[NSMutableArray alloc] initWithArray:@[@(0), @(0)]];
    
    //shading
    CGSize cgsize = CGSizeMake(size, triangleHeight/0.75);
    CGPoint center = CGPointMake(cgsize.width / 2, 0);
    CGPoint bottomLeft = CGPointMake(0, cgsize.height - 0);
    CGPoint bottomRight = CGPointMake(cgsize.width - 0, cgsize.height - 0);
    
    CGFloat a = cgsize.width;
    CGFloat b = hypotf(center.x - bottomLeft.x, center.y - bottomLeft.y);
    CGFloat s = (2*b+a)/2;
    CGFloat radius = sqrt((s-a)*(s-b)*(s-b)/s);
    CGFloat scale = radius / cgsize.height;
    CGPoint innerCircleTouchPoint = CGPointMake(bottomLeft.x + (center.x - bottomLeft.x) * scale, bottomLeft.y + (center.y - bottomLeft.y) * scale);
    
    CGFloat thickness = 4;
    
    CALayer *layerLL = [CALayer layer];
    layerLL.frame = CGRectMake(self.borderWidth-thickness/2, self.borderWidth+radius+innerCircleTouchPoint.x,
                               thickness/2, height-2*(self.borderWidth+radius+innerCircleTouchPoint.x));
    layerLL.backgroundColor = borderColor.CGColor;
    [self.left.layer addSublayer:layerLL];
    
    CALayer *layerLR = [CALayer layer];
    layerLR.frame = CGRectMake(size*6+self.borderWidth, self.borderWidth+radius+innerCircleTouchPoint.x,
                               thickness, height-2*(self.borderWidth+radius+innerCircleTouchPoint.x));
    layerLR.backgroundColor = borderColor.CGColor;
    [self.left.layer addSublayer:layerLR];
    
    
    CALayer *layerRL = [CALayer layer];
    layerRL.frame = CGRectMake(self.borderWidth-thickness/2, self.borderWidth+radius+innerCircleTouchPoint.x,
                               thickness/2, height-2*(self.borderWidth+radius+innerCircleTouchPoint.x));
    layerRL.backgroundColor = borderColor.CGColor;
    [self.right.layer addSublayer:layerRL];
    
    CALayer *layerRR = [CALayer layer];
    layerRR.frame = CGRectMake(size*6+self.borderWidth, self.borderWidth+radius+innerCircleTouchPoint.x,
                               thickness, height-2*(self.borderWidth+radius+innerCircleTouchPoint.x));
    layerRR.backgroundColor = borderColor.CGColor;
    [self.right.layer addSublayer:layerRR];
    
    //[self redirectLogToDocuments];
}

- (void)redirectLogToDocuments
{
    NSArray *allPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [allPaths objectAtIndex:0];
    NSString *pathForLog = [documentsDirectory stringByAppendingPathComponent:@"yourFile.txt"];
    
    freopen([pathForLog cStringUsingEncoding:NSASCIIStringEncoding],"w",stderr);
}

- (void)showGraphView;
{
    GraphViewController *graph = (GraphViewController *) [self.navigationController showViewControllerWithClass:[GraphViewController class] animated:YES];
    graph.root = [NSMutableDictionary dictionaryWithDictionary:@{
        @"board" : [self getBoardFromBoard:self.board],
        @"dices" : [self.board.diceNumbers mutableCopy],
        @"depth" : @(self.board.player == WHITE ? self.board.whiteBotDeapth : self.board.redBotDeapth),
        @"player" : @(self.board.player),
        @"first" : @(self.board.player),
        @"playAgain" : @(0),
        @"type" : @"MAX"
    }];
}

-(NSMutableArray*)getBoardFromBoard:(Board*)boardd
{
    NSMutableArray *board = [NSMutableArray new];
    for(TriangleView *triangle in boardd.board) {
        NSInteger val = [triangle.circles count];
        
        if(val !=0 && [[triangle.circles lastObject] isWhite]) val *= -1;
        
        [board addObject:@(val)];
    }
    [board addObject:@([boardd.eaten[0] count])];
    [board addObject:@([boardd.eaten[1] count])];
    [board addObject:@([boardd.finished[0] count])];
    [board addObject:@([boardd.finished[1] count])];
    
    return board;
}

- (CALayer *)addUpperBorder:(UIRectEdge)edge color:(UIColor *)color thickness:(CGFloat)thickness toView:(UIView *)view
{
    CALayer *border = [CALayer layer];
    
    switch (edge) {
        case UIRectEdgeTop:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), thickness);
            break;
        case UIRectEdgeBottom:
            border.frame = CGRectMake(0, CGRectGetHeight(view.frame) - thickness, CGRectGetWidth(view.frame), thickness);
            break;
        case UIRectEdgeLeft:
            border.frame = CGRectMake(0, self.borderWidth, thickness, CGRectGetHeight(view.frame)-2*self.borderWidth);
            break;
        case UIRectEdgeRight:
            border.frame = CGRectMake(CGRectGetWidth(view.frame) - thickness, self.borderWidth, thickness, CGRectGetHeight(view.frame)-2*self.borderWidth);
            break;
        default:
            break;
    }
    
    border.backgroundColor = color.CGColor;
    
    [view.layer addSublayer:border];
    
    return border;
}

-(void)player:(NSUInteger)player won:(NSUInteger)won;
{
    self.wins[player] = @([self.wins[player] integerValue] + won);
    
    if([self.wins[player] integerValue] >= self.gameLength) {
        UIAlertController* alert =
        [UIAlertController alertControllerWithTitle:@"GAMEOVER"
                                            message:[NSString stringWithFormat:@"%@ player wins with %d/%ld", (player == RED ? @"RED" : @"WHITE"), [self.wins[player] integerValue], self.gameLength]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                         }];
        
        
        [alert addAction:okAction];
        [alert setPreferredAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertController* alert =
        [UIAlertController alertControllerWithTitle:@"Current state"
                                            message:[NSString stringWithFormat:@"RED Player %d/%ld\nWHITE Player %d/%ld", [self.wins[RED] integerValue], self.gameLength, [self.wins[WHITE] integerValue], self.gameLength]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Continue"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             NSArray *numberOfCircles = @[@0, @0, @0, @0, @0, @5,
                                                                                          @0, @3, @0, @0, @0, @0,
                                                                                          @5, @0, @0, @0, @0, @0,
                                                                                          @0, @0, @0, @0, @0, @2];
                                                             
                                                             [self.board removeFromSuperview];
                                                             
                                                             CGFloat width = self.view.frame.size.width;
                                                             CGFloat height = self.view.bounds.size.height;
                                                             
                                                             self.borderWidth = 24;
                                                             
                                                             CGFloat offset = 15;
                                                             
                                                             self.board = [[Board alloc] initWithFrame:CGRectMake(self.borderWidth + offset, self.borderWidth, width-2*self.borderWidth-2*offset, height-2*self.borderWidth)];
                                                             self.board.useRedBot = self.redBotDif !=0;
                                                             self.board.useWhiteBot = self.whiteBotDif != 0;
                                                             self.board.redBotDeapth = self.redBotDif;
                                                             self.board.delegate = self;
                                                             self.board.whiteBotDeapth = self.whiteBotDif;
                                                             
                                                             [self.view addSubview:self.board];
                                                         }];
        
        UIAlertAction* quitAction = [UIAlertAction actionWithTitle:@"Quit"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                         }];
        
        
        [alert addAction:okAction];
        [alert addAction:quitAction];
        [alert setPreferredAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
