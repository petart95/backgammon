//
//  Board.m
//  backgamon
//
//  Created by maxeler on 1/22/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "Board.h"
#import "CircleView.h"
#import "MaxColor.h"
#import "DieView.h"
#import "Bot.h"
#import "RectangleView.h"

#define RED 0
#define WHITE 1

@interface Board ()

@property NSMutableArray<DieView *> *dices;

//@property UIView *containerView;
@property CGFloat numberOfParts;

@property NSMutableArray<RectangleView *>* finishedViews;

@end

@implementation Board

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if(self) {
        self.board = [NSMutableArray new];
        self.diceNumbers = [NSMutableArray new];
        self.player = [self randomNumberBetween:0 maxNumber:1];
        
        NSArray *numberOfCircles = @[@0, @0, @0, @0, @0, @5,
                                     @0, @3, @0, @0, @0, @0,
                                     @5, @0, @0, @0, @0, @0,
                                     @0, @0, @0, @0, @0, @2];
        
        self.numberOfParts = 14.5;
        
        NSInteger numberOfTriangles = [numberOfCircles count];
        CGFloat width = floor((self.frame.size.width)/self.numberOfParts);
        CGFloat height = self.bounds.size.height;
        
        for(NSUInteger i = 0; i < numberOfTriangles; i++) {
            TriangleView *triangle;
            if( i < numberOfTriangles / 2) {
                NSUInteger pos = numberOfTriangles / 2 - 1 - i + (i < 6 ? 1 : 0);
                CGFloat w = floor(width * (pos + 1)) - floor(width * pos);
                /*if(pos == 5 || pos == 11)
                    w = self.frame.size.width/numberOfParts*(pos+1) - floor(width * pos);*/
                triangle = [[TriangleView alloc] initWithFrame:
                            CGRectMake(floor(width * pos), 0.55 * height,
                                       w, 0.45 * height)];
            } else {
                NSUInteger pos = i - numberOfTriangles / 2 + (i>=18 ? 1 : 0);
                CGFloat w = floor(width * (pos + 1)) - floor(width * pos);
                /*if(pos == 5 || pos == 11)
                    w = ceil(self.frame.size.width/numberOfParts*(pos+1)) - floor(width * pos);*/
                triangle = [[TriangleView alloc] initWithFrame:
                            CGRectMake(floor(width * pos), 0,
                                       w, 0.45 * height)];
                //triangle.shadingColor = [UIColor clearColor];
                triangle.transform = CGAffineTransformRotate(triangle.transform, M_PI);
            }
            if(i % 2==0) {
                triangle.selectedView.backgroundColor = [UIColor translucentColorFromColor:[UIColor colorWithHexString:@"#C19A6B"] withAlpha:0.8];
            } else {
                triangle.selectedView.backgroundColor = [UIColor translucentColorFromColor:[UIColor colorWithHexString:@"#8B4513"] withAlpha:0.8];
            }
            
            for(NSUInteger j = 0; j < [numberOfCircles[i] integerValue]; j++) {
                CircleView *circle = [CircleView createWhiteCircleWithPerent:triangle];
                circle.delegate = self;
                [self addSubview:circle];
                [triangle.circles addObject:circle];
            }
            
            for(NSUInteger j = 0; j < [numberOfCircles[numberOfTriangles - i - 1] intValue]; j++) {
                CircleView *circle = [CircleView createRedCircleWithPerent:triangle];
                circle.delegate = self;
                [self addSubview:circle];
                [triangle.circles addObject:circle];
            }
            
            [self addSubview:triangle];
            [self sendSubviewToBack:triangle];
            [self.board addObject:triangle];
        }

        CGFloat size = 100;
        CGFloat offset = 15;
        CGFloat x = self.frame.size.width*10/self.numberOfParts;
        CGFloat y = self.frame.size.height/2 - size/2;
        
        
        self.dices = [[NSMutableArray alloc] initWithArray:@[
             [[DieView alloc] initWithFrame:CGRectMake(x - size - offset,  y, size, size)],
             [[DieView alloc] initWithFrame:CGRectMake(x + 20, y,size, size)]]];
        
        [self.dices[0] showDieNumber:1];
        [self.dices[1] showDieNumber:4];
        
        [self addSubview:self.dices[0]];
        [self addSubview:self.dices[1]];
        
        self.eaten = [NSMutableArray arrayWithArray:@[[NSMutableArray new], [NSMutableArray new]]];
        self.finished = [NSMutableArray arrayWithArray:@[[NSMutableArray new], [NSMutableArray new]]];
        self.finishedViews = [NSMutableArray new];
        
        width = floor((self.frame.size.width)/self.numberOfParts);
        height = self.frame.size.height * 0.45 * 0.75;
        
        [self.finishedViews addObject:[[RectangleView alloc]  initWithFrame:CGRectMake(width*13.5, 0, width, height)]];
        [self.finishedViews addObject:[[RectangleView alloc]  initWithFrame:CGRectMake(width*13.5, self.frame.size.height - height, width, height)]];
        
        self.finishedViews[0].frame = CGRectMake(width*13.5, 0, width, height);
        self.finishedViews[1].frame = CGRectMake(width*13.5, self.frame.size.height - height, width, height);
        
        /*TriangleView *redt1 = [[TriangleView alloc] initWithFrame:self.finishedViews[0].frame];
        [self addSubview:redt1];
        TriangleView *redt2 = [[TriangleView alloc] initWithFrame:self.finishedViews[0].frame];
        redt2.transform = CGAffineTransformRotate(redt2.transform, M_PI);
        [self addSubview:redt2];
        
        TriangleView *white1 = [[TriangleView alloc] initWithFrame:self.finishedViews[1].frame];
        [self addSubview:white1];
        TriangleView *white2 = [[TriangleView alloc] initWithFrame:self.finishedViews[1].frame];
        white2.transform = CGAffineTransformRotate(white2.transform, M_PI);
        [self addSubview:white2];*/
        
        [self addSubview:self.finishedViews[0]];
        [self addSubview:self.finishedViews[1]];
        
        [self dicesDidLandOnNumbers:@[]];
    }
    
    return self;
}
#pragma mark - Layout

- (void)layoutCirclesAnimated:(BOOL)animated;
{
    void(^animation)(void) = ^{
        CGSize size = self.board[0].frame.size;
        
        CGFloat edgeOffset = 3;
        
        CGFloat a = size.width;
        CGFloat b = hypotf(size.width/2, size.height);
        CGFloat s = (2*b+a)/2;
        CGFloat radius = 2*sqrt((s-a)*(s-b)*(s-b)/s) - 2*edgeOffset;
        
        for(TriangleView *triangle in self.board) {
            NSUInteger numberOfCircles = [triangle.circles count];
            
            // triangle
            CGFloat centerX = triangle.center.x;
            CGFloat height = triangle.frame.size.height * 0.70;
            
            // circle
            CGFloat offset = radius * numberOfCircles < height ? radius : (height - radius) / (numberOfCircles - 1);
            CGFloat y = edgeOffset;
            
            if(triangle.frame.origin.y != 0) {
                y = triangle.frame.origin.y + triangle.frame.size.height - radius - edgeOffset;
                offset *= -1;
            }
            
            CGRect frame = CGRectMake(centerX - radius/2, y, radius, radius);
            
            for(CircleView *circle in triangle.circles) {
                circle.frame = frame;
                frame.origin.y += offset;
            }
        }
        
        CGFloat borderWidth = 24;
        CGFloat width = floor((self.frame.size.width)/self.numberOfParts);
        CGFloat y = (self.frame.size.height +2*borderWidth) / 5 - borderWidth - [self.eaten[WHITE] count] *radius/2;
        CGRect frame = CGRectMake(6.5*width - radius/2, y, radius, radius);
        
        for(CircleView *circle in self.eaten[WHITE]) {
            circle.frame = frame;
            frame.origin.y += radius;
        }
        
        y = (self.frame.size.height +2*borderWidth) / 5 * 4 - borderWidth - radius + [self.eaten[RED] count] *radius/2;
        frame = CGRectMake(6.5*width - radius/2, y, radius, radius);
        
        for(CircleView *circle in self.eaten[RED]) {
            circle.frame = frame;
            frame.origin.y -= radius;
        }
        
        // triangle
        CGFloat centerX = 14*width;
        CGFloat height = self.frame.size.height * 0.45 * 0.75;
        
        // circle
        NSUInteger numberOfCircles = [self.finished[RED] count];
        CGFloat offset = radius * numberOfCircles < height ? radius : (height - 2*edgeOffset - radius) / (numberOfCircles - 1);
        y = edgeOffset;
        
        frame = CGRectMake(centerX - radius/2, y, radius, radius);
        
        for(CircleView *circle in self.finished[RED]) {
            circle.frame = frame;
            frame.origin.y += offset;
        }
        
        // circle
        numberOfCircles = [self.finished[WHITE] count];
        offset = radius * numberOfCircles < height ? radius : (height - 2*edgeOffset - radius) / (numberOfCircles - 1);
        y = self.frame.size.height - radius - edgeOffset;
        
        frame = CGRectMake(centerX - radius/2, y, radius, radius);
        
        for(CircleView *circle in self.finished[WHITE]) {
            circle.frame = frame;
            frame.origin.y -= offset;
        }
    };
    
    if(animated){
        [UIView animateWithDuration:0.4 animations:animation];
    } else {
        animation();
    }
}

- (void)layoutSubviews;
{
    [super layoutSubviews];
    
    [self layoutCirclesAnimated:NO];
}

#pragma mark - Game logic

- (void)dicesDidLandOnNumbers:(NSMutableArray *)numbers;
{
    self.diceNumbers = numbers;
    
    BOOL canPlay = NO;
    
    static BOOL playAgain = NO;
    static NSInteger numberOfDubles = 0;
    if([numbers count] == 2) {
        playAgain = [numbers[0] isEqual:numbers[1]];
        numberOfDubles++;
        
        if(numberOfDubles == 3) {
            while([self.diceNumbers[0] isEqual:self.diceNumbers[1]]) {
                self.diceNumbers[0] = @([self randomNumberBetween:1 maxNumber:6]);
                self.diceNumbers[1] = @([self randomNumberBetween:1 maxNumber:6]);
            }
            
            [self.dices[0] showDieNumber:[self.diceNumbers[0] integerValue]];
            [self.dices[1] showDieNumber:[self.diceNumbers[1] integerValue]];
            
            numberOfDubles = 0;
        }
    } else {
        numberOfDubles = 0;
    }
    
    if([self.eaten[self.player] count] == 0) {
        for(TriangleView *triangle in self.board) {
            if([triangle.circles count] == 0) continue;
            
            if([[self posibleMovesForCircle:[triangle.circles lastObject]] count] != 0) {
                [[triangle.circles lastObject] showBackgrooundView:YES animated:YES];
                canPlay = YES;
            } else {
                [[triangle.circles lastObject] showBackgrooundView:NO animated:YES];
            }
        }
    } else {
        if([[self posibleMovesForCircle:[self.eaten[self.player] lastObject]] count] != 0) {
            [[self.eaten[self.player] lastObject] showBackgrooundView:YES animated:YES];
            canPlay = YES;
        } else {
            [[self.eaten[self.player] lastObject] showBackgrooundView:NO animated:YES];
        }
    }
    
    if(!canPlay) {
        if([self.finished[WHITE] count] == 15) {
            for(int i=0;i<6;i++) {
                if([self.board[i].circles count] != 0) {
                    [self.delegate player:WHITE won:3];
                    return;
                }
            }
            for(int i=6;i<18;i++) {
                if([self.board[i].circles count] != 0) {
                    [self.delegate player:WHITE won:2];
                    return;
                }
            }
            for(int i=18;i<24;i++) {
                if([self.board[i].circles count] != 0) {
                    [self.delegate player:WHITE won:1];
                    return;
                }
            }
        }
        
        if([self.finished[RED] count] == 15) {
            for(int i=18;i<24;i++) {
                if([self.board[i].circles count] != 0) {
                    [self.delegate player:RED won:3];
                    return;
                }
            }
            for(int i=6;i<18;i++) {
                if([self.board[i].circles count] != 0) {
                    [self.delegate player:RED won:2];
                    return;
                }
            }
            for(int i=0;i<6;i++) {
                if([self.board[i].circles count] != 0) {
                    [self.delegate player:RED won:1];
                    return;
                }
            }
        }
        
        self.dices[0].dimView.backgroundColor = [UIColor clearColor];
        self.dices[1].dimView.backgroundColor = [UIColor clearColor];
        
        self.diceNumbers = [NSMutableArray arrayWithArray:@[@(1),@(4)]];
        
        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeImage1:) userInfo:nil repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval:0.14 target:self selector:@selector(changeImage2:) userInfo:nil repeats:YES];
        
        [self runSpinAnimationOnView:self.dices[0] duration:1 rotations:4 repeat:0];
        [self runSpinAnimationOnView:self.dices[1] duration:1 rotations:4 repeat:0];
        
        
        self.player = playAgain ? self.player : !self.player;
    } else {
        if((self.player == RED && self.useRedBot) ||
           (self.player == WHITE && self.useWhiteBot)) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSMutableArray *board = [NSMutableArray new];
                for(TriangleView *triangle in self.board) {
                    NSInteger val = [triangle.circles count];
                    
                    if(val !=0 && [[triangle.circles lastObject] isWhite]) val *= -1;
                    
                    [board addObject:@(val)];
                }
                [board addObject:@([self.eaten[0] count])];
                [board addObject:@([self.eaten[1] count])];
                [board addObject:@([self.finished[0] count])];
                [board addObject:@([self.finished[1] count])];
                
                if(self.player == RED) {
                    //NSLog(@"RED %lf", [Bot getValueForPlayer:self.player withBoard:board]);
                } else {
                    //NSLog(@"WHITE %lf", [Bot getValueForPlayer:self.player withBoard:board]);
                }
                NSMutableDictionary *move = [self getMoveForPlayer:self.player withBoard:board dices:[self.diceNumbers mutableCopy]];
                NSLog(@"%@", move);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self moveCircleFromTriangle:[move[@"from"] integerValue]
                                      toTriangle:[move[@"to"] integerValue]];
                });
            });
        }
    }
}


- (void)changeImage1:(NSTimer *)timer
{
    static int numberOfTicks = 5;
    numberOfTicks --;
    
    if(numberOfTicks > 0)
    {
        self.diceNumbers[0] = @([self randomNumberBetween:1 maxNumber:6]);
        [self.dices[0] showDieNumber:[self.diceNumbers[0] integerValue]];
    }
    else
    {
        numberOfTicks = 5;
        [timer invalidate]; //to stop and invalidate the timer.
        
        [NSThread sleepForTimeInterval:0.4f];
        [self dicesDidLandOnNumbers:self.diceNumbers];
    }
}

- (void)changeImage2:(NSTimer *)timer
{
    static int numberOfTicks = 7;
    numberOfTicks --;
    
    if(numberOfTicks > 0)
    {
        self.diceNumbers[1] = @([self randomNumberBetween:1 maxNumber:6]);
        [self.dices[1] showDieNumber:[self.diceNumbers[1] integerValue]];
    }
    else
    {
        numberOfTicks = 7;
        [timer invalidate]; //to stop and invalidate the timer.
    }
}

#pragma mark - CircleMoveDelegate

- (void)circleDidStartMoving:(CircleView *)circle;
{
    for(NSNumber *number in [self posibleMovesForCircle:circle]) {
        if([number integerValue] >=0 && [number integerValue] < 24) {
            [self.board[[number integerValue]] showBackgrooundView:YES animated:YES];
        } else if([number integerValue] < 0) {
            [self.finishedViews[WHITE] showBackgrooundView:YES animated:YES];
        } else {
            [self.finishedViews[RED] showBackgrooundView:YES animated:YES];
        }
    }
    
    [circle.parentView.circles removeLastObject];
    
    [self layoutCirclesAnimated:YES];
}

- (void)circleMoved:(CircleView *)circle;
{
    for(TriangleView *triangle in self.board) {
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frame = triangle.frame;
            frame.size.height *= 0.90;
            frame.origin.y += frame.origin.y == 0 ? 0 : frame.size.height * 0.1;
            
            if(CGRectContainsPoint(frame, circle.center)) {
                triangle.backgroundView.lineColor = [UIColor nephritsColor];
                triangle.backgroundView.borderColor = [UIColor nephritsColor];
            } else {
                triangle.backgroundView.lineColor = [UIColor sunFlowerColor];
                triangle.backgroundView.borderColor = [UIColor sunFlowerColor];
            }
            
            [triangle.backgroundView setNeedsDisplay];
        }];
    }
    
    for(RectangleView *view in self.finishedViews) {
        if(view.showBackgroundView) {
            [UIView animateWithDuration:0.4 animations:^{
                if(CGRectContainsPoint(view.frame, circle.center)) {
                    view.backgroundView.lineColor = [UIColor nephritsColor];
                    view.backgroundView.borderColor = [UIColor nephritsColor];
                } else {
                    view.backgroundView.lineColor = [UIColor sunFlowerColor];
                    view.backgroundView.borderColor = [UIColor sunFlowerColor];
                }
                
                [view.backgroundView setNeedsDisplay];
            }];
        }
    }
}

- (void)circleDidEndMoving:(CircleView *)circle;
{
    for(TriangleView *triangle in self.board) {
        if(!triangle.showBackgroundView) continue;
        
        [triangle showBackgrooundView:NO animated:YES];
        
        CGRect frame = triangle.frame;
        frame.size.height *= 0.90;
        frame.origin.y += frame.origin.y == 0 ? 0 : frame.size.height * 0.10;
        
        if(CGRectContainsPoint(frame, circle.center)) {
            NSInteger index = self.player == RED ? -1 : 24;
            
            if(circle.parentView != nil) {
                index = [self.board indexOfObject:circle.parentView];
            } else {
                [self.eaten[self.player] removeObject:circle];
            }
            
            index = [self.board indexOfObject:triangle] - index;

            index = [self.diceNumbers indexOfObject:@(ABS(index))];
            [self.diceNumbers removeObjectAtIndex:index];
            self.dices[index].dimView.backgroundColor = [UIColor translucentSilverColor];
            
            circle.parentView = triangle;
            
            if([triangle.circles count] == 1 &&
               (([[triangle.circles lastObject] isRed] && self.player != RED) ||
                ([[triangle.circles lastObject] isWhite] && self.player != WHITE))) {
                   [triangle.circles lastObject].parentView = nil;
                   [self.eaten[!self.player] addObject:[triangle.circles lastObject]];
                   [triangle.circles removeAllObjects];
            }
        }
    }
    
    if(CGRectContainsPoint(self.finishedViews[RED].frame, circle.center) && self.finishedViews[RED].showBackgroundView) {
        NSInteger index = [self.board indexOfObject:circle.parentView];
        
        [circle.parentView.circles addObject:circle];
        
        for(NSNumber *number in [self posibleMovesForCircle:circle]) {
            if([number intValue] >= 24) {
                index = [number intValue]  - index;
                break;
            }
        }
        
        index = [self.diceNumbers indexOfObject:@(ABS(index))];
        [self.diceNumbers removeObjectAtIndex:index];
        self.dices[index].dimView.backgroundColor = [UIColor translucentSilverColor];
        
        [circle.parentView.circles removeLastObject];
        
        [self.finished[RED] addObject:circle];
        [circle showBackgrooundView:NO animated:YES];
        circle.parentView = nil;
    }
    
    if(CGRectContainsPoint(self.finishedViews[WHITE].frame, circle.center) && self.finishedViews[WHITE].showBackgroundView) {
        NSInteger index = [self.board indexOfObject:circle.parentView];
        
        [circle.parentView.circles addObject:circle];
        
        for(NSNumber *number in [self posibleMovesForCircle:circle]) {
            if([number intValue] < 0) {
                index = index - [number intValue];
                break;
            }
        }
        
        index = [self.diceNumbers indexOfObject:@(ABS(index))];
        [self.diceNumbers removeObjectAtIndex:index];
        self.dices[index].dimView.backgroundColor = [UIColor translucentSilverColor];
        
        [circle.parentView.circles removeLastObject];
        
        [self.finished[WHITE] addObject:circle];
        [circle showBackgrooundView:NO animated:YES];
        circle.parentView = nil;
    }
    
    [self.finishedViews[WHITE] showBackgrooundView:NO animated:YES];
    [self.finishedViews[RED] showBackgrooundView:NO animated:YES];
    
    [circle.parentView.circles addObject:circle];
    
    [self dicesDidLandOnNumbers:self.diceNumbers];
    
    [self layoutCirclesAnimated:YES];
}

- (void)moveCircleFromTriangle:(NSInteger)from toTriangle:(NSInteger)to;
{
    CircleView *circle;
    if(from >=0 && from < 24) {
        circle = [self.board[from].circles lastObject];
    } else {
        circle = [self.eaten[self.player] lastObject];
    }
  
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.5f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [circle touchesBegan:nil withEvent:nil];
        });
        
        CGPoint center;
        
        if(to >=0 && to < 24) {
            CGFloat direction = (self.board[to].frame.origin.y == 0 ? 1 : -1);
            
            CGRect frame = self.board[to].frame;
            frame.size.height *= 0.90;
            frame.origin.y += frame.origin.y == 0 ? 0 : frame.size.height * 0.10;
            
            center = self.board[to].center;
            center.y -= (self.board[to].frame.size.height/2 - circle.frame.size.height/2) * direction;
            
            if([self.board[to].circles count] != 0) {
                center = [self.board[to].circles lastObject].center;
                center.y += circle.frame.size.height * direction;
            }
            
            while(!CGRectContainsPoint(frame, center)) {
                center.y -= 5*direction;
            }
        } else if(to>=24) {
            CGRect frame = self.finishedViews[RED].frame;
            
            if([self.finished[RED] count] != 0) {
                center = [self.finished[RED] lastObject].center;
                center.y += circle.frame.size.height;
            } else {
                center = CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + circle.frame.size.height/2);
            }
            
            while(!CGRectContainsPoint(frame, center)) {
                center.y -= 5;
            }
        } else {
            CGRect frame = self.finishedViews[WHITE].frame;
            
            if([self.finished[WHITE] count] != 0) {
                center = [self.finished[WHITE] lastObject].center;
                center.y -= circle.frame.size.height;
            } else {
                center = CGPointMake(frame.origin.x + frame.size.width/2, frame.origin.y + frame.size.height - circle.frame.size.height/2);
            }
            
            while(!CGRectContainsPoint(frame, center)) {
                center.y += 5;
            }
        }
        
        [NSThread sleepForTimeInterval:0.15f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.4 animations:^{
                circle.center = center;
                [self circleMoved:circle];
            }];
        });
        
        [NSThread sleepForTimeInterval:0.25f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self bringSubviewToFront:circle];
            circle.center = center;
            
            [self circleDidEndMoving:circle];
            
            circle.backgroundView.outerColor = [UIColor sunFlowerColor];
            [circle.backgroundView setNeedsDisplay];
        });
    });
}
    
#pragma mark - Helper functions

- (NSMutableArray *)posibleMovesForCircle:(CircleView *)circle;
{
    NSMutableArray *moves = [NSMutableArray new];
        
    if(([circle isRed]   && self.player != RED) ||
       ([circle isWhite] && self.player != WHITE)) {
        return moves;
    }
    
    NSInteger index = self.player == RED ? -1 : 24;
    
    if(circle.parentView != nil) {
        index = [self.board indexOfObject:circle.parentView];
    }
    
    NSInteger direction = self.player == RED ? 1 : -1;
    
    for(NSNumber *number in self.diceNumbers) {
        NSInteger i = direction * [number intValue] + index;
        if(i < [self.board count] && i >= 0 &&
           ([self.board[i].circles count] <= 1 ||
            ([[self.board[i].circles lastObject] isRed] && self.player == RED) ||
            ([[self.board[i].circles lastObject] isWhite] && self.player == WHITE))) {
               [moves addObject:@(i)];
        }
    }

    NSInteger numberOfRed = [self.finished[RED] count];
    for(NSInteger i=18;i<24;i++){
        if([self.board[i].circles count] != 0 && [[self.board[i].circles lastObject] isRed]) {
            numberOfRed += [self.board[i].circles count];
        }
    }
    
    if([circle isRed] && numberOfRed == 15) {
        for(NSNumber *number in self.diceNumbers) {
            NSInteger i = direction * [number intValue] + index;
            if(i >= 24) {
                [moves addObject:@(i)];
            }
        }
    }
        
    NSInteger numberOfWhite = [self.finished[WHITE] count];
    for(NSInteger i=0;i<6;i++){
        if([self.board[i].circles count] != 0 && [[self.board[i].circles lastObject] isWhite]) {
            numberOfWhite += [self.board[i].circles count];
        }
    }
    
    if([circle isWhite] && numberOfWhite == 15) {
        for(NSNumber *number in self.diceNumbers) {
            NSInteger i = direction * [number intValue] + index;
            if(i < 0) {
                [moves addObject:@(i)];
            }
        }
    }
    
    return moves;
}

- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random_uniform(max - min + 1);
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma  mark - Bot

- (NSMutableDictionary *)getMoveForPlayer:(NSInteger)player withBoard:(NSMutableArray *)board dices:(NSMutableArray *)dices;
{
    CGFloat alpha = -1000000;
    CGFloat beta = 1000000;
    
    if(player == RED) {
        return [Bot getMoveForPlayer:player withBoard:board dices:dices first:player depth:self.redBotDeapth alpha:alpha beta:beta playAgain:NO];
    } else {
        return [Bot getMoveForPlayer:player withBoard:board dices:dices first:player depth:self.whiteBotDeapth alpha:alpha beta:beta playAgain:NO];
    }
}


@end
