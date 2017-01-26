/**
 *  @header MaxelerAppDelegate.h
 *
 *  @brief MaxelerAppDelegate header file
 *         in MaxelerComponents project.
 *
 *  @discussion Subclass of UIResponder <UIApplicationDelegate>
 *              responsible for starting the app without the storyboard.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import <UIKit/UIKit.h>

/**
 *  @class MaxelerAppDelegate
 *
 *  @brief The AppDelegate class used for navigation controllers.
 *
 *  @discussion This class is used instead of AppDelegate when there is no storyboard
 *              and instead uses a navigation controller as the root view controller.
 *
 *  @superclass  Super Class: UIResponder <UIApplicationDelegate>
 */
@interface MaxelerAppDelegate : UIResponder <UIApplicationDelegate>

/**
 *  @brief The window to use when presenting a navigation controller.
 *
 *  @discussion This property contains the window used to
 *              present the app’s visual content on the device’s main screen.
 */
@property (strong, nonatomic) UIWindow *window;

/**
 *  @brief Specifies the class of navigation controller to be used.
 *
 *  @discussion The standard implementation of this function returns [UINavigationController class].
 *              To use custom navigation controller override this function.
 *
 *  @code
 *      + (Class)navigationControllerClass;
 *      {
 *          return [CustomNavigationController class];
 *      }
 *  @endcode
 *
 *  @return Class The class of the navigation controller to be used.
 */
+ (Class)navigationControllerClass;

@end
