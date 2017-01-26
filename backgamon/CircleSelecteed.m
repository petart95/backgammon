//
//  CircleSelecteed.m
//  backgamon
//
//  Created by maxeler on 1/20/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "CircleSelecteed.h"
#import "MaxColor.h"

@implementation CircleSelecteed

- (void)drawRect:(CGRect)rect
{
    // Setup view
    CGFloat r1,g1,b1,a1,r2,g2,b2,a2;
    
    [self.innerColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [self.outerColor getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    
    CGFloat colorComponents[] = {
        r1,g1,b1,a1,   // First color:  R, G, B, ALPHA (currently opaque black)
        r2,g2,b2,a2};  // Second color: R, G, B, ALPHA (currently transparent black)
    CGFloat locations[] = {0, 1}; // {0, 1) -> from center to outer edges, {1, 0} -> from outer edges to center
    CGFloat radius = MIN((self.bounds.size.height / 2), (self.bounds.size.width / 2));
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    // Prepare a context and create a color space
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create gradient object from our color space, color components and locations
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, locations, 2);
    
    // Draw a gradient
    CGContextDrawRadialGradient(context, gradient, center, 0.0, center, radius, 0);
    CGContextRestoreGState(context);
    
    // Release objects
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    if(r2+g2+b2 > 2) {
        CGContextSetLineWidth(context, 1.5);
    } else {
        CGContextSetLineWidth(context, 0.5);
    }
    
    radius *= 0.97;
    
    CGContextMoveToPoint(context, center.x - radius, center.y);
    CGContextAddArcToPoint(context, center.x - radius, center.y - radius, center.x, center.y - radius, radius);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, center.x + radius, center.y);
    CGContextAddArcToPoint(context, center.x + radius, center.y + radius, center.x, center.y + radius, radius);
    CGContextStrokePath(context);
}

@end
