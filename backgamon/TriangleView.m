//
//  TriangleView.m
//  backgamon
//
//  Created by maxeler on 1/20/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "TriangleView.h"
#import "MaxColor.h"

@implementation TriangleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.showBackgroundView = NO;
        self.circles = [NSMutableArray new];
        
        self.clipsToBounds = NO;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectedView = [[TraingleSelected alloc] initWithFrame:self.bounds];
        self.selectedView.lineColor = [UIColor clearColor];
        self.selectedView.borderColor = [UIColor clearColor];
        self.selectedView.clipsToBounds = YES;
        
        [self addSubview:self.selectedView];
        
        CGRect frame = self.bounds;
        frame.origin.y += 0.2 *
        frame.size.height;
        self.backgroundView = [[TraingleSelected alloc] initWithFrame:frame];
        self.backgroundView.alpha = 0;
        self.backgroundView.clipsToBounds = YES;
        
        [self.selectedView addSubview:self.backgroundView];
        
        CGSize size = frame.size;
        
        CGPoint center = CGPointMake(size.width / 2, 0);
        CGPoint bottomLeft = CGPointMake(0, size.height - 0);
        CGPoint bottomRight = CGPointMake(size.width - 0, size.height - 0);
        
        CGFloat r = 10;
        CGFloat a = size.width;
        CGFloat b = hypotf(center.x - bottomLeft.x, center.y - bottomLeft.y);
        CGFloat s = (2*b+a)/2;
        CGFloat radius = sqrt((s-a)*(s-b)*(s-b)/s);
        CGFloat scale = radius / size.height;
        CGPoint innerCircleTouchPoint = CGPointMake(bottomLeft.x + (center.x - bottomLeft.x) * scale, bottomLeft.y + (center.y - bottomLeft.y) * scale);
        CGPoint innerCircleTouchPoint2 = CGPointMake(bottomRight.x + (center.x - bottomRight.x) * scale, bottomRight.y + (center.y - bottomRight.y) * scale);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, bottomLeft.y + 0);
        CGPathAddLineToPoint(path, NULL, 0, innerCircleTouchPoint.y-innerCircleTouchPoint.x);
        CGPathAddArcToPoint(path, NULL, innerCircleTouchPoint.x, innerCircleTouchPoint.y - innerCircleTouchPoint.x, innerCircleTouchPoint.x, innerCircleTouchPoint.y, innerCircleTouchPoint.x);
        CGPathAddLineToPoint(path, NULL, innerCircleTouchPoint.x, innerCircleTouchPoint.y);
        CGPathAddArcToPoint(path, NULL, center.x, center.y, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y, r);
        CGPathAddArcToPoint(path, NULL, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), (a-innerCircleTouchPoint2.x));
        CGPathAddLineToPoint(path, NULL, a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x));
        CGPathAddLineToPoint(path, NULL, a, bottomRight.y + 0);
        CGPathCloseSubpath(path);
        
        UIBezierPath *trianglePath = [UIBezierPath bezierPathWithCGPath:path];
        CGPathRelease(path);
        
        CAShapeLayer *triangleMaskLayer = [CAShapeLayer layer];
        [triangleMaskLayer setPath:trianglePath.CGPath];
        
        self.layer.mask = triangleMaskLayer;
        
        self.bottomColor = [UIColor translucentColorFromColor:[UIColor brownColor] withAlpha:0.75];
        self.shadingColor = self.bottomColor;
        self.shadingWidth = 4;
    }
    
    return self;
}

- (void)showBackgrooundView:(BOOL)show animated:(BOOL)animated;
{
    self.showBackgroundView = show;
    
    void(^animation)(void) = ^{
        if (show) {
            self.backgroundView.frame = self.bounds;
            self.backgroundView.alpha = 1;
        } else {
            CGRect frame = self.bounds;
            frame.origin.y += 0.2 * frame.size.height;
            self.backgroundView.frame = frame;
            self.backgroundView.alpha = 0;
        }
    };
    
    if(animated) {
        [UIView animateWithDuration:0.4 animations:animation];
    } else {
        animation();
    }
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
    
    CGContextSetStrokeColorWithColor(context, self.shadingColor.CGColor);
    CGContextSetLineWidth(context, self.shadingWidth/2);
    
    CGContextMoveToPoint(context, 0, innerCircleTouchPoint.y-innerCircleTouchPoint.x);
    CGContextAddArcToPoint(context, innerCircleTouchPoint.x, innerCircleTouchPoint.y - innerCircleTouchPoint.x, innerCircleTouchPoint.x, innerCircleTouchPoint.y, innerCircleTouchPoint.x);
    CGContextAddLineToPoint(context, innerCircleTouchPoint.x, innerCircleTouchPoint.y);
    
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, self.shadingWidth);

    CGContextMoveToPoint(context, innerCircleTouchPoint.x, innerCircleTouchPoint.y);
    CGContextAddArcToPoint(context, a/2, (size.height-radius)*2, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y, radius);
    CGContextAddLineToPoint(context, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y);
    
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, self.shadingWidth/2);
    
    CGContextMoveToPoint(context, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y);
    CGContextAddArcToPoint(context, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), (a-innerCircleTouchPoint2.x));
    CGContextAddLineToPoint(context, a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x));
    
    CGContextStrokePath(context);
}

@end
