//
//  MaxColor.m
//  Correlation
//
//  Created by maxeler on 2/25/16.
//  Copyright © 2016 Maxeler Technologies. All rights reserved.
//

#import "MaxColor.h"

#define RGB_SIZE 255.0f

@implementation UIColor(MaxColor)

#pragma mark - Helper functions

+ (UIColor*) withFirstColors:(UIColor*)c1 selcod:(UIColor*)c2 withHeight:(int)height {
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    [c1 set];
    CGRect rectangleRect = CGRectMake(0, 0, 1, height/2);
    CGContextFillRect(context, rectangleRect);
    
    [c2 set];
    rectangleRect = CGRectMake(0, height/2, 1, height/2);
    CGContextFillRect(context, rectangleRect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}


+ (UIColor*) gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height {
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *) colorWithHex:(NSUInteger)hex {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / RGB_SIZE
                           green:((float)((hex & 0xFF00) >> 8)) / RGB_SIZE
                            blue:((float)(hex & 0xFF)) / RGB_SIZE
                           alpha:1];
}

+ (UIColor *) colorWithHexString:(NSString*)hexString {
    const char *constHexString = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger hex = strtol(constHexString + 1, NULL, 16);
    return [UIColor colorWithHex:hex];
}

+ (UIColor *) colorWithRedIntager:(NSUInteger)red greenIntager:(NSUInteger)green blueIntager:(NSUInteger)blue {
    return [UIColor colorWithRed:(red / RGB_SIZE)  green:(green / RGB_SIZE) blue:(blue / RGB_SIZE) alpha:1];
}

+ (UIColor *) colorWithRedIntager:(NSUInteger)red greenIntager:(NSUInteger)green blueIntager:(NSUInteger)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(red / RGB_SIZE)  green:(green / RGB_SIZE) blue:(blue / RGB_SIZE) alpha:alpha];
}

+ (UIColor *) translucentColorFromColor:(UIColor*)color withAlpha:(CGFloat)alpha {
    CGFloat red, green, blue;
    
    [color getRed: &red green: &green blue: &blue alpha: nil];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - Colors

+ (UIColor *) maxblueColor {
    return [UIColor colorWithRedIntager:21 greenIntager:65 blueIntager:145];
}

+ (UIColor *) cloudsColor {
    return [UIColor colorWithHexString:@"#ecf0f1"];
}

+ (UIColor *) alizarinColor {
    return [UIColor colorWithHexString:@"#e74c3c"];
}

+ (UIColor *) pomegranateColor {
    return [UIColor colorWithHexString:@"#c0392b"];
}

+ (UIColor *) emeraldColor {
    return [UIColor colorWithHexString:@"#2ecc71"];
}

+ (UIColor *) carrotColor {
    return [UIColor colorWithHexString:@"#e67e22"];
}

+ (UIColor *) nephritsColor {
    return [UIColor colorWithHexString:@"#27ae60"];
}

+ (UIColor *) wetasphAltColor {
    return [UIColor colorWithHexString:@"#34495e"];
}

+ (UIColor *) midnightBlueColor {
    return [UIColor colorWithHexString:@"#2c3e50"];
}

+ (UIColor *) wisteriaColor {
    return [UIColor colorWithHexString:@"#8e44ad"];
}

+ (UIColor *) amethystColor {
    return [UIColor colorWithHexString:@"#9b59b6"];
}

+ (UIColor *) sunFlowerColor {
    return [UIColor colorWithHexString:@"#f1c40f"];
}

+ (UIColor *) orangeFlatUIColor {
    return [UIColor colorWithHexString:@"#f39c12"];
}

+ (UIColor *) pumpkinColor {
    return [UIColor colorWithHexString:@"#d35400"];
}

+ (UIColor *) greenSeaColor {
    return [UIColor colorWithHexString:@"#16a085"];
}

+ (UIColor *) terquoisColor {
    return [UIColor colorWithHexString:@"#1dd2af"];
}

+ (UIColor *) peterRiverColor {
    return [UIColor colorWithHexString:@"#3498db"];
}

+ (UIColor *) belizeHoleColor {
    return [UIColor colorWithHexString:@"#2980b9"];
}

+ (UIColor *) silverColor {
    return [UIColor colorWithHexString:@"#bdc3c7"];
}

+ (UIColor *) concreteColor {
    return [UIColor colorWithHexString:@"#95a5a6"];
}

+ (UIColor *) asbestosColor {
    return [UIColor colorWithHexString:@"#7f8c8d"];
}

+ (UIColor *) translucentCloudsColor {
    return [UIColor translucentColorFromColor:[UIColor cloudsColor] withAlpha:0.5];
}

+ (UIColor *) translucentSilverColor {
    return [UIColor translucentColorFromColor:[UIColor silverColor] withAlpha:0.5];
}

+ (UIColor *) translucentAlizarinColor {
    return [UIColor translucentColorFromColor:[UIColor alizarinColor] withAlpha:0.5];
}

+ (UIColor *) translucentPomegranateColor {
    return [UIColor translucentColorFromColor:[UIColor pomegranateColor] withAlpha:0.5];
}

+ (UIColor *) translucentEmeraldColor {
    return [UIColor translucentColorFromColor:[UIColor emeraldColor] withAlpha:0.5];
}

+ (UIColor *) translucentNephritsColor {
    return [UIColor translucentColorFromColor:[UIColor nephritsColor] withAlpha:0.5];
}

+ (UIColor *) translucentCarrotColor {
    return [UIColor translucentColorFromColor:[UIColor carrotColor] withAlpha:0.5];
}

+ (UIColor *) translucentPumpkinColor {
    return [UIColor translucentColorFromColor:[UIColor pumpkinColor] withAlpha:0.5];
}

+ (UIColor *) translucentWetasphAltColor {
    return [UIColor translucentColorFromColor:[UIColor wetasphAltColor] withAlpha:0.5];
}

+ (UIColor *) translucentMidnightBlueColor {
    return [UIColor translucentColorFromColor:[UIColor midnightBlueColor] withAlpha:0.5];
}

+ (UIColor *) translucentWisteriaColor {
    return [UIColor translucentColorFromColor:[UIColor wisteriaColor] withAlpha:0.5];
}

+ (UIColor *) translucentAmethystColor {
    return [UIColor translucentColorFromColor:[UIColor amethystColor] withAlpha:0.5];
}

+ (UIColor *) translucentSunFlowerColor {
    return [UIColor translucentColorFromColor:[UIColor sunFlowerColor] withAlpha:0.5];
}

+ (UIColor *) translucentOrangeFlatUIColor {
    return [UIColor translucentColorFromColor:[UIColor orangeFlatUIColor] withAlpha:0.5];
}

+ (UIColor *) translucentGreenSeaColor {
    return [UIColor translucentColorFromColor:[UIColor greenSeaColor] withAlpha:0.5];
}

+ (UIColor *) translucentTerquoisColor {
    return [UIColor translucentColorFromColor:[UIColor terquoisColor] withAlpha:0.5];
}

+ (UIColor *) translucentPeterRiverColor {
    return [UIColor translucentColorFromColor:[UIColor peterRiverColor] withAlpha:0.5];
}

+ (UIColor *) translucentBelizeHoleColor {
    return [UIColor translucentColorFromColor:[UIColor greenSeaColor] withAlpha:0.5];
}

+ (UIColor *) translucentConcreteColor {
    return [UIColor translucentColorFromColor:[UIColor concreteColor] withAlpha:0.5];
}

+ (UIColor *) translucentAsbestosColor {
    return [UIColor translucentColorFromColor:[UIColor asbestosColor] withAlpha:0.5];
}


@end