/**
 *  @header UINavigationController+ShowViewController.h
 *
 *  @brief UINavigationController+ShowViewController header file
 *         in MaxelerComponents project.
 *
 *  @discussion Adds option to show navigation controller with given class or name.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import <UIKit/UIKit.h>

@interface UINavigationController (ShowViewController)

/**
 *  @brief Shows ViewController with specified class.
 *
 *  @param class The view controller class.
 *  @param animated Specifies whether or not the transition should be animated.
 *
 *  @return UIViewController * The view controller of specified class.
 */
- (UIViewController *)showViewControllerWithClass:(Class)class animated:(BOOL)animated;

/**
 *  @brief Shows ViewController with specified name.
 *  
 *  @param viewName The view controller name.
 *  @param animated Specifies whether or not the transition should be animated.
 *
 *  @return UIViewController * The view controller with specified name.
 */
- (UIViewController *)showViewControllerWithName:(NSString *)viewName animated:(BOOL)animated;

@end
