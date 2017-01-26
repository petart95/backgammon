/**
 *  @header MaxelerNavigationBar.h
 *
 *  @brief MaxelerNavigationBar header file
 *         in MaxelerComponents project.
 *
 *  @discussion Subclass of UINavigationBar with custom options.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import <UIKit/UIKit.h>

/**
 *  @class MaxelerNavigationBar
 *
 *  @brief The MaxelerNavigationBar class
 *
 *  @discussion This class was designed and implemented to have
 *              maxBlue background.
 *
 *  @superclass  Super Class: UINavigationBar
 *
 *  @see MaxelerNavigationController
 */
@interface MaxelerNavigationBar : UINavigationBar

/**
 *  @brief The background color of the navigation bar.
 */
@property UIColor *backgroundColor;

/**
 *  @brief The text color of the navigation bar.
 */
@property UIColor *textColor;

/**
 *  @brief Indicates whether or not the status bar should be white.
 */
@property BOOL isStatusBarColorWhite;

@end
