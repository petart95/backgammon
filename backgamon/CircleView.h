//
//  CircleView.h
//  backgamon
//
//  Created by maxeler on 1/20/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleSelecteed.h"
#import "TriangleView.h"

@class CircleView;

@protocol CircleMoveDelegate <NSObject>

- (void)circleDidStartMoving:(CircleView *)circle;
- (void)circleMoved:(CircleView *)circle;
- (void)circleDidEndMoving:(CircleView *)circle;

@end

@interface CircleView : UIView

@property CircleSelecteed *backgroundView;

@property BOOL showBackgroundView;

@property TriangleView *parentView;

@property id<CircleMoveDelegate> delegate;

- (void)showBackgrooundView:(BOOL)show animated:(BOOL)animated;

+ (CircleView *)createCircleWithPerent:(TriangleView *)parentView;
+ (CircleView *)createRedCircleWithPerent:(TriangleView *)parentView;
+ (CircleView *)createWhiteCircleWithPerent:(TriangleView *)parentView;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (BOOL)isRed;
- (BOOL)isWhite;

@end
