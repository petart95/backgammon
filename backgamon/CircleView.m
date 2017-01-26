//
//  CircleView.m
//  backgamon
//
//  Created by maxeler on 1/20/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "CircleView.h"
#import "MaxColor.h"

@interface CircleView ()

@property CircleSelecteed *innerCircle;
@property CGPoint lastLocation;
@property CGPoint initLocation;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.showBackgroundView = NO;
        self.layer.cornerRadius = self.frame.size.height/2;
        self.clipsToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        
        self.innerCircle = [[CircleSelecteed alloc] initWithFrame:
                            CGRectMake(0.1*self.bounds.size.width, 0.1*self.bounds.size.width,
                                       0.8*self.bounds.size.width, 0.8*self.bounds.size.width)];
        self.innerCircle.layer.cornerRadius = self.innerCircle.frame.size.height/2;
        self.innerCircle.clipsToBounds = YES;
        self.innerCircle.backgroundColor = [UIColor whiteColor];
        self.innerCircle.layer.borderWidth = 0.5;
        self.innerCircle.layer.borderColor = [[UIColor blackColor] CGColor];
        [self addSubview:self.innerCircle];
        
        self.backgroundView = [[CircleSelecteed alloc] initWithFrame:self.bounds];
        self.backgroundView.innerColor = [UIColor clearColor];
        self.backgroundView.outerColor = [UIColor sunFlowerColor];
        self.backgroundView.alpha = 0;
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        
        UIPanGestureRecognizer *panRecognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(detectPan:)];
        self.gestureRecognizers = @[panRecognizer];
    }
    
    return self;
}

#pragma mark - Static

+ (CircleView *)createCircleWithPerent:(TriangleView *)parentView;
{
    CircleView *res = [[CircleView alloc] initWithFrame:CGRectZero];
    
    res.parentView = parentView;
    
    return res;
}

+ (CircleView *)createRedCircleWithPerent:(TriangleView *)parentView;
{
    CircleView *res = [CircleView createCircleWithPerent:parentView];
    
    res.backgroundColor = [UIColor pomegranateColor];
    
    return res;
}

+ (CircleView *)createWhiteCircleWithPerent:(TriangleView *)parentView;
{
    CircleView *res = [CircleView createCircleWithPerent:parentView];
    
    res.backgroundColor = [UIColor silverColor];
    
    return res;
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.frame.size.height/2;
    
    self.innerCircle.innerColor = [UIColor translucentColorFromColor:self.backgroundColor
                                                           withAlpha:0.6];
    self.innerCircle.outerColor = [UIColor translucentColorFromColor:self.backgroundColor
                                                           withAlpha:0.95];
    self.innerCircle.frame = CGRectMake(0.1*self.bounds.size.width, 0.1*self.bounds.size.width,
                                        0.8*self.bounds.size.width, 0.8*self.bounds.size.width);
    
    self.innerCircle.layer.cornerRadius = self.innerCircle.frame.size.height/2;
    
    self.backgroundView.frame = self.bounds;

    [self addSubview:self.backgroundView];
}

#pragma mark - Animation

- (void)showBackgrooundView:(BOOL)show animated:(BOOL)animated;
{
    self.showBackgroundView = show;
    
    void(^animation)(void) = ^{
        self.backgroundView.alpha = show ? 1 : 0;
    };
    
    if(animated) {
        [UIView animateWithDuration:0.4 animations:animation];
    } else {
        animation();
    }
}

#pragma mark - Helper functions

- (BOOL)isRed;
{
    return [self.backgroundColor isEqual:[UIColor pomegranateColor]];
}

- (BOOL)isWhite;
{
    return [self.backgroundColor isEqual:[UIColor silverColor]];
}

#pragma mark - Gestures

- (void) detectPan:(UIPanGestureRecognizer *) uiPanGestureRecognizer
{
    // if view isnot movable do not move it
    if(!self.showBackgroundView) return;
    
    // move view
    CGPoint translation = [uiPanGestureRecognizer translationInView:self.superview];
    self.center = CGPointMake(self.lastLocation.x + translation.x,
                              self.lastLocation.y + translation.y);
    
    if(uiPanGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        //All fingers are lifted.
        self.backgroundView.outerColor = [UIColor sunFlowerColor];
        [self.backgroundView setNeedsDisplay];
        
        [self.delegate circleDidEndMoving:self];
    } else {
        [self.delegate circleMoved:self];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!self.showBackgroundView) return;
    
    // Promote the touched view
    [self.superview bringSubviewToFront:self];

    // Remember original location
    self.initLocation = self.center;
    self.lastLocation = self.center;
    
    self.backgroundView.outerColor = [UIColor nephritsColor];
    [self.backgroundView setNeedsDisplay];
    
    [self.delegate circleDidStartMoving:self];
    
    [self becomeFirstResponder];
}

@end
