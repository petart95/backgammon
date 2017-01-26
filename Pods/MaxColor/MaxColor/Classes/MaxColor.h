//
//  MaxColor.h
//  Correlation
//
//  Created by maxeler on 2/25/16.
//  Copyright © 2016 Maxeler Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(MaxColor)

/**
    @brief Returns color with given hexadecimal representaion
 
    @discussion This method accepts a NSUIntager and takes
                first two digits of its hexadecimal representation as red,
                second two as green and last two as blue color.
 
    @param hex The hexadecimal value for color.
 
    @return The UIColor object.
 
    @see colorWithHexString
 */
+ (UIColor*)colorWithHex:(NSUInteger)hex;

/**
    @brief Returns color with given hexadecimal string representaion
 
    @discussion This method accepts a NSString* and takes
                first two digits of its representation as red,
                second two as green and last two as blue color.
 
 
    @param hexString The string value for color.
 
    @return The UIColor object.
 
    @see colorWithHex
 */
+ (UIColor*)colorWithHexString:(NSString*)hexString;

/**
    @brief Creates and returns a color object using the specified opacity and RGB component values.
 
    @discussion The color object.
                The color information represented by this object
                is in the device RGB colorspace.
 
    @param red The red component of the color object, specified as a value from 0 to 255
    @param green The green component of the color object, specified as a value from 0 to 255
    @param blue The blue component of the color object, specified as a value from 0 to 255
 
    @return The UIColor object.
 */
+ (UIColor*)colorWithRedIntager:(NSUInteger)red greenIntager:(NSUInteger)green blueIntager:(NSUInteger)blue;

/**
    @brief Creates and returns a color object using the specified opacity and RGB component values.
 
    @discussion The color object.
                The color information represented by this object
                is in the device RGB colorspace.
 
    @param red The red component of the color object, specified as a value from 0 to 255
    @param green The green component of the color object, specified as a value from 0 to 255
    @param blue The blue component of the color object, specified as a value from 0 to 255
    @param alpha The opacity value of the color object, specified as a value from 0.0 to 1.0.
 
    @return The UIColor object.
 */
+ (UIColor*)colorWithRedIntager:(NSUInteger)red greenIntager:(NSUInteger)green blueIntager:(NSUInteger)blue alpha:(CGFloat)alpha;

/**
    @brief Returns MaxBlue color.
 
    @discussion Returns a color object whose rgb value is (21, 65, 145)
                and whose alpha value is 1.0.
 
    @return The UIColor object.
 */
+ (UIColor*)maxblueColor;

/**
    @brief Returns clouds color.
 
    @discussion Returns a color object whose rgb value is (236,240,241)
                and whose alpha value is 1.0.
 
    @return The UIColor object.
 */
+ (UIColor*)cloudsColor;

/**
    @brief Returns alizarin color.
 
    @discussion Returns a color object whose rgb value is (231,76,60)
                and whose alpha value is 1.0.
 
    @return The UIColor object.
 */
+ (UIColor*)alizarinColor;

/**
    @brief Returns emerald color.
 
    @discussion Returns a color object whose rgb value is (46,204,113)
                and whose alpha value is 1.0.
 
    @return The UIColor object.
 */
+ (UIColor*)emeraldColor;

/**
 @brief Returns carrot color.
 
 @discussion Returns a color object whose rgb value is (230,126,34)
 and whose alpha value is 1.0.
 
 @return The UIColor object.
 */
+ (UIColor *) carrotColor;

/**
 @brief Returns nephrits color.
 
 @discussion Returns a color object whose rgb value is (230,126,34)
 and whose alpha value is 1.0.
 
 @return The UIColor object.
 */
+ (UIColor *) nephritsColor;

/**
 @brief Returns translucent emerald color.
 
 @discussion Returns a color object whose rgb value is (46,204,113)
 and whose alpha value is 0.5.
 
 @return The UIColor object.
 */
//+ (UIColor *) translucentEmeraldColor;


+ (UIColor*) gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;
+ (UIColor*) withFirstColors:(UIColor*)c1 selcod:(UIColor*)c2 withHeight:(int)height;



+ (UIColor *) translucentColorFromColor:(UIColor*)color withAlpha:(CGFloat)alpha;

+ (UIColor *) wetasphAltColor;

+ (UIColor *) midnightBlueColor;

+ (UIColor *) wisteriaColor;

+ (UIColor *) amethystColor;

+ (UIColor *) pomegranateColor;

+ (UIColor *) sunFlowerColor;

+ (UIColor *) orangeFlatUIColor;

+ (UIColor *) pumpkinColor;

+ (UIColor *) greenSeaColor;

+ (UIColor *) terquoisColor;

+ (UIColor *) peterRiverColor;

+ (UIColor *) belizeHoleColor;

+ (UIColor *) silverColor;

+ (UIColor *) concreteColor;

+ (UIColor *) asbestosColor;

+ (UIColor *) translucentCloudsColor;

+ (UIColor *) translucentSilverColor;

+ (UIColor *) translucentAlizarinColor;

+ (UIColor *) translucentPomegranateColor;

+ (UIColor *) translucentEmeraldColor;

+ (UIColor *) translucentNephritsColor;

+ (UIColor *) translucentCarrotColor;

+ (UIColor *) translucentPumpkinColor;

+ (UIColor *) translucentWetasphAltColor;

+ (UIColor *) translucentMidnightBlueColor;

+ (UIColor *) translucentWisteriaColor;

+ (UIColor *) translucentAmethystColor;

+ (UIColor *) translucentSunFlowerColor;

+ (UIColor *) translucentOrangeFlatUIColor;

+ (UIColor *) translucentGreenSeaColor;

+ (UIColor *) translucentTerquoisColor;

+ (UIColor *) translucentPeterRiverColor;

+ (UIColor *) translucentBelizeHoleColor;

+ (UIColor *) translucentConcreteColor;

+ (UIColor *) translucentAsbestosColor;

@end
