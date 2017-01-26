//
//  RectangleSelected.m
//  backgamon
//
//  Created by maxeler on 1/26/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "RectangleSelected.h"
#import "MaxColor.h"

@implementation RectangleSelected

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
        
        CGFloat a = size.width;
        CGFloat b = hypotf(center.x - bottomLeft.x, center.y - bottomLeft.y);
        CGFloat s = (2*b+a)/2;
        CGFloat radius = sqrt((s-a)*(s-b)*(s-b)/s);
        CGFloat scale = radius / size.height;
        CGPoint innerCircleTouchPoint = CGPointMake(bottomLeft.x + (center.x - bottomLeft.x) * scale, bottomLeft.y + (center.y - bottomLeft.y) * scale);
        CGPoint innerCircleTouchPoint2 = CGPointMake(bottomRight.x + (center.x - bottomRight.x) * scale, bottomRight.y + (center.y - bottomRight.y) * scale);
        
        center = CGPointMake(size.width / 2, size.height);
        CGPoint topLeft = CGPointMake(0, 0);
        CGPoint topRight = CGPointMake(size.width - 0, 0);
        
        CGPoint innerCircleTouchPoint3 = CGPointMake(topLeft.x + (center.x - topLeft.x) * scale, topLeft.y + (center.y - topLeft.y) * scale);
        CGPoint innerCircleTouchPoint4 = CGPointMake(topRight.x + (center.x - topRight.x) * scale, topRight.y + (center.y - topRight.y) * scale);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, innerCircleTouchPoint.y-innerCircleTouchPoint.x);
        CGPathAddArcToPoint(path, NULL, innerCircleTouchPoint.x, innerCircleTouchPoint.y - innerCircleTouchPoint.x, innerCircleTouchPoint.x, innerCircleTouchPoint.y, innerCircleTouchPoint.x);
        CGPathAddLineToPoint(path, NULL, innerCircleTouchPoint.x, innerCircleTouchPoint.y);
        CGPathAddArcToPoint(path, NULL, a/2, (size.height-radius)*2, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y, radius);
        CGPathAddLineToPoint(path, NULL, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y);
        CGPathAddArcToPoint(path, NULL, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), (a-innerCircleTouchPoint2.x));
        CGPathAddLineToPoint(path, NULL, a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x));
        CGPathAddLineToPoint(path, NULL, a, innerCircleTouchPoint4.y + (a-innerCircleTouchPoint4.x));
        CGPathAddArcToPoint(path, NULL, innerCircleTouchPoint4.x, innerCircleTouchPoint4.y + (a-innerCircleTouchPoint4.x), innerCircleTouchPoint4.x, innerCircleTouchPoint4.y, (a-innerCircleTouchPoint4.x));
        CGPathAddLineToPoint(path, NULL, innerCircleTouchPoint4.x, innerCircleTouchPoint4.y);
        CGPathAddArcToPoint(path, NULL, a/2, -(size.height-radius), innerCircleTouchPoint3.x, innerCircleTouchPoint3.y, radius);
        CGPathAddLineToPoint(path, NULL, innerCircleTouchPoint3.x, innerCircleTouchPoint3.y);
        CGPathAddArcToPoint(path, NULL, innerCircleTouchPoint3.x, innerCircleTouchPoint3.y + innerCircleTouchPoint3.x, 0, innerCircleTouchPoint3.y+innerCircleTouchPoint3.x, innerCircleTouchPoint3.x);
        CGPathAddLineToPoint(path, NULL, 0, innerCircleTouchPoint3.y+innerCircleTouchPoint3.x);
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
    
    CGFloat a = size.width;
    CGFloat b = hypotf(center.x - bottomLeft.x, center.y - bottomLeft.y);
    CGFloat s = (2*b+a)/2;
    CGFloat radius = sqrt((s-a)*(s-b)*(s-b)/s);
    CGFloat scale = radius / size.height;
    CGPoint innerCircleTouchPoint = CGPointMake(bottomLeft.x + (center.x - bottomLeft.x) * scale, bottomLeft.y + (center.y - bottomLeft.y) * scale);
    CGPoint innerCircleTouchPoint2 = CGPointMake(bottomRight.x + (center.x - bottomRight.x) * scale, bottomRight.y + (center.y - bottomRight.y) * scale);
    
    center = CGPointMake(size.width / 2, size.height);
    CGPoint topLeft = CGPointMake(0, 0);
    CGPoint topRight = CGPointMake(size.width - 0, 0);
    
    CGPoint innerCircleTouchPoint3 = CGPointMake(topLeft.x + (center.x - topLeft.x) * scale, topLeft.y + (center.y - topLeft.y) * scale);
    CGPoint innerCircleTouchPoint4 = CGPointMake(topRight.x + (center.x - topRight.x) * scale, topRight.y + (center.y - topRight.y) * scale);
    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextSetLineWidth(context, self.borderWidth);
    
    CGContextMoveToPoint(context, 0, innerCircleTouchPoint.y-innerCircleTouchPoint.x);
    CGContextAddArcToPoint(context, innerCircleTouchPoint.x, innerCircleTouchPoint.y - innerCircleTouchPoint.x, innerCircleTouchPoint.x, innerCircleTouchPoint.y, innerCircleTouchPoint.x);
    CGContextAddLineToPoint(context, innerCircleTouchPoint.x, innerCircleTouchPoint.y);
    CGContextAddArcToPoint(context, a/2, (size.height-radius)*2, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y, radius);
    CGContextAddLineToPoint(context, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y);
    CGContextAddArcToPoint(context, innerCircleTouchPoint2.x, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x), (a-innerCircleTouchPoint2.x));
    CGContextAddLineToPoint(context, a, innerCircleTouchPoint2.y - (a-innerCircleTouchPoint2.x));
    CGContextAddLineToPoint(context, a, innerCircleTouchPoint4.y + (a-innerCircleTouchPoint4.x));
    CGContextAddArcToPoint(context, innerCircleTouchPoint4.x, innerCircleTouchPoint4.y + (a-innerCircleTouchPoint4.x), innerCircleTouchPoint4.x, innerCircleTouchPoint4.y, (a-innerCircleTouchPoint4.x));
    CGContextAddLineToPoint(context, innerCircleTouchPoint4.x, innerCircleTouchPoint4.y);
    CGContextAddArcToPoint(context, a/2, -(size.height-radius), innerCircleTouchPoint3.x, innerCircleTouchPoint3.y, radius);
    CGContextAddLineToPoint(context, innerCircleTouchPoint3.x, innerCircleTouchPoint3.y);
    CGContextAddArcToPoint(context, innerCircleTouchPoint3.x, innerCircleTouchPoint3.y + innerCircleTouchPoint3.x, 0, innerCircleTouchPoint3.y+innerCircleTouchPoint3.x, innerCircleTouchPoint3.x);
    CGContextAddLineToPoint(context, 0, innerCircleTouchPoint3.y+innerCircleTouchPoint3.x);
    CGContextAddLineToPoint(context, 0, innerCircleTouchPoint.y-innerCircleTouchPoint.x);
    CGContextStrokePath(context);
}

@end
