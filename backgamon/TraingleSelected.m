//
//  TraingleSelected.m
//  backgamon
//
//  Created by maxeler on 1/20/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "TraingleSelected.h"
#import "MaxColor.h"

@implementation TraingleSelected

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.lineYOffset = 30;
        self.lineSpacing = 10;
        self.lineWidth = 5;
        self.lineColor = [UIColor sunFlowerColor];
        self.borderColor = [UIColor sunFlowerColor];
        self.borderWidth = 15;
        self.borderRadius = 10;
        
        self.backgroundColor = [UIColor clearColor];
        
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
        CGPathMoveToPoint(path, NULL, innerCircleTouchPoint.x, innerCircleTouchPoint.y);
        CGPathAddArcToPoint(path, NULL, center.x, center.y, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y, r);
        CGPathAddLineToPoint(path, NULL, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y);
        CGPathAddArcToPoint(path, NULL, a/2, (size.height-radius)*2, innerCircleTouchPoint.x, innerCircleTouchPoint.y, radius);
        CGPathCloseSubpath(path);
        
        UIBezierPath *trianglePath = [UIBezierPath bezierPathWithCGPath:path];
        CGPathRelease(path);
        
        CAShapeLayer *triangleMaskLayer = [CAShapeLayer layer];
        [triangleMaskLayer setPath:trianglePath.CGPath];
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.mask = triangleMaskLayer;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGSize size = self.frame.size;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    
    for(CGFloat i = -self.lineYOffset; i < size.height; i += self.lineSpacing) {
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
        CGContextMoveToPoint(context, 0, i);
        CGContextAddLineToPoint(context, size.width, i + self.lineYOffset);
        CGContextStrokePath(context);
    }
    
    CGPoint center = CGPointMake(size.width / 2, 0);
    CGPoint bottomLeft = CGPointMake(0, size.height - 0);
    CGPoint bottomRight = CGPointMake(size.width - 0, size.height - 0);
    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextSetLineWidth(context, self.borderWidth);
    
    CGFloat r = 10;
    CGFloat a = size.width;
    CGFloat b = hypotf(center.x - bottomLeft.x, center.y - bottomLeft.y);
    CGFloat s = (2*b+a)/2;
    CGFloat radius = sqrt((s-a)*(s-b)*(s-b)/s);
    CGFloat scale = radius / size.height;
    CGPoint innerCircleTouchPoint = CGPointMake(bottomLeft.x + (center.x - bottomLeft.x) * scale, bottomLeft.y + (center.y - bottomLeft.y) * scale);
    CGPoint innerCircleTouchPoint2 = CGPointMake(bottomRight.x + (center.x - bottomRight.x) * scale, bottomRight.y + (center.y - bottomRight.y) * scale);
    
    CGContextMoveToPoint(context, innerCircleTouchPoint.x, innerCircleTouchPoint.y);
    CGContextAddArcToPoint(context, center.x, center.y, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y, r);
    CGContextAddLineToPoint(context, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y);
    CGContextAddArcToPoint(context, a/2, (size.height-radius)*2, innerCircleTouchPoint.x, innerCircleTouchPoint.y, radius);
    CGContextAddLineToPoint(context, innerCircleTouchPoint.x, innerCircleTouchPoint.y);
    CGContextStrokePath(context);
    
    //CGContextRelease(context);
}


@end
