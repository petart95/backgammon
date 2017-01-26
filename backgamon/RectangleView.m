//
//  RectangleView.m
//  backgamon
//
//  Created by maxeler on 1/26/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "RectangleView.h"
#import "MaxColor.h"

@implementation RectangleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.bottomColor = [UIColor translucentColorFromColor:[UIColor brownColor] withAlpha:0.75];
        self.backgroundColor = [UIColor clearColor];
        
        self.showBackgroundView = NO;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectedView = [[RectangleSelected alloc] initWithFrame:self.bounds];
        self.selectedView.lineColor = [UIColor clearColor];
        self.selectedView.borderColor = [UIColor translucentColorFromColor:[UIColor brownColor] withAlpha:0.6];
        self.selectedView.borderWidth = 8;
        self.selectedView.clipsToBounds = YES;
        self.selectedView.backgroundColor = [UIColor translucentColorFromColor:[UIColor brownColor] withAlpha:0.6];
        
        [self addSubview:self.selectedView];
        
        self.backgroundView = [[RectangleSelected alloc] initWithFrame:self.bounds];
        self.backgroundView.alpha = 0;
        self.backgroundView.clipsToBounds = YES;
        
        [self.selectedView addSubview:self.backgroundView];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGSize size = self.frame.size;
    
    CGPoint center = CGPointMake(size.width / 2, 0);
    CGPoint bottomLeft = CGPointMake(0, size.height - 0);
    CGPoint bottomRight = CGPointMake(size.width - 0, size.height - 0);
    
    CGFloat a = size.width;
    CGFloat b = hypotf(center.x - bottomLeft.x, center.y - bottomLeft.y);
    CGFloat s = (2*b+a)/2;
    CGFloat radius = sqrt((s-a)*(s-b)*(s-b)/s);
    CGFloat scale = radius / size.height;
    CGPoint innerCircleTouchPoint = CGPointMake(bottomLeft.x + (center.x - bottomLeft.x) * scale, bottomLeft.y + (center.y - bottomLeft.y) * scale);
    CGPoint innerCircleTouchPoint2 = CGPointMake(bottomRight.x + (center.x - bottomRight.x) * scale, bottomRight.y + (center.y - bottomRight.y) * scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.bottomColor.CGColor);
    
    CGContextMoveToPoint(context, 0, bottomLeft.y + 0);
    CGContextAddLineToPoint(context, 0, innerCircleTouchPoint.y-innerCircleTouchPoint.x);
    CGContextAddArcToPoint(context, innerCircleTouchPoint.x, innerCircleTouchPoint.y - innerCircleTouchPoint.x, innerCircleTouchPoint.x, innerCircleTouchPoint.y, innerCircleTouchPoint.x);
    CGContextAddLineToPoint(context, innerCircleTouchPoint.x, innerCircleTouchPoint.y);
    CGContextAddArcToPoint(context, a/2, (size.height-radius)*2, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y, radius);
    CGContextAddArcToPoint(context, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), (a-innerCircleTouchPoint2.x));
    CGContextAddLineToPoint(context, a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x));
    CGContextAddLineToPoint(context, a, bottomRight.y + 0);
    CGContextFillPath(context);
    
    
    center = CGPointMake(size.width / 2, size.height);
    CGPoint topLeft = CGPointMake(0, 0);
    CGPoint topRight = CGPointMake(size.width - 0, 0);
    
    CGPoint innerCircleTouchPoint3 = CGPointMake(topLeft.x + (center.x - topLeft.x) * scale, topLeft.y + (center.y - topLeft.y) * scale);
    CGPoint innerCircleTouchPoint4 = CGPointMake(topRight.x + (center.x - topRight.x) * scale, topRight.y + (center.y - topRight.y) * scale);
    
    CGContextSetFillColorWithColor(context, self.bottomColor.CGColor);
    
    CGContextMoveToPoint(context, 0, topLeft.y + 0);
    CGContextAddLineToPoint(context, 0, innerCircleTouchPoint3.y+innerCircleTouchPoint3.x);
    CGContextAddArcToPoint(context, innerCircleTouchPoint3.x, innerCircleTouchPoint3.y + innerCircleTouchPoint3.x, innerCircleTouchPoint3.x, innerCircleTouchPoint3.y, innerCircleTouchPoint3.x);
    CGContextAddLineToPoint(context, innerCircleTouchPoint3.x, innerCircleTouchPoint3.y);
    CGContextAddArcToPoint(context, a/2, -(size.height-radius), innerCircleTouchPoint4.x, innerCircleTouchPoint4.y, radius);
    CGContextAddArcToPoint(context, innerCircleTouchPoint4.x, innerCircleTouchPoint4.y + (a-innerCircleTouchPoint4.x), a, innerCircleTouchPoint4.y + (a-innerCircleTouchPoint4.x), (a-innerCircleTouchPoint4.x));
    CGContextAddLineToPoint(context, a, innerCircleTouchPoint4.y + (a-innerCircleTouchPoint4.x));
    CGContextAddLineToPoint(context, a, topRight.y + 0);
    CGContextFillPath(context);
    
    
}

- (void)showBackgrooundView:(BOOL)show animated:(BOOL)animated;
{
    self.showBackgroundView = show;
    
    void(^animation)(void) = ^{
        if (show) {
            self.backgroundView.alpha = 1;
        } else {
            self.backgroundView.alpha = 0;
        }
    };
    
    if(animated) {
        [UIView animateWithDuration:0.4 animations:animation];
    } else {
        animation();
    }
}

@end
