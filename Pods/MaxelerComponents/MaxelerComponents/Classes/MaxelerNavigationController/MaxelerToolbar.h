/**
 *  @header MaxelerToolbar.h
 *
 *  @brief MaxelerToolbar header file
 *         in MaxelerComponents project.
 *
 *  @discussion Subclass of UIToolbar with custom options.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import <UIKit/UIKit.h>

@class SVGKFastImageView;

/**
 *  @class MaxelerToolbar
 *
 *  @brief The MaxelerToolbar class
 *
 *  @discussion This class was designed and implemented to have
 *              a custom Maxeler toolbar with maxeler logo and message.
 *
 *  @superclass  Super Class: UIToolbar
 *
 *  @see MaxelerNavigationController
 */
@interface MaxelerToolbar : UIToolbar

/**
 *  @bried Maxeler logo image
 */
@property SVGKFastImageView *logoImage;

/**
 *  @bried Text label
 */
@property UILabel *textLabel;

/**
 *  @brief The background color of the navigation bar.
 */
@property UIColor *backgroundColor;

/**
 *  @brief The text color of the navigation bar.
 */
@property UIColor *textColor;

/**
 *  @brief The toolbar height.
 */
@property CGFloat toolbarHeight;

/**
 *  @brief The logo height.
 */
@property CGFloat logoHeight;

/**
 *  @brief Site url to visit when taped.
 */
@property NSString *siteURL;

@end
