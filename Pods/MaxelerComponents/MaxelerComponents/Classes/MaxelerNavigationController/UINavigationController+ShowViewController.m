/**
 *  @header UINavigationController+ShowViewController.h
 *
 *  @brief UINavigationController+ShowViewController implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Adds option to show navigation controller with given class or name.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "UINavigationController+ShowViewController.h"

@implementation UINavigationController (ShowViewController)

#pragma mark - Show ViewController

- (UIViewController *)showViewControllerWithName:(NSString *)viewName animated:(BOOL)animated;
{
    // Initiate Main storyboard
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // Initiate Data view controller
    UIViewController *viewController = [sb instantiateViewControllerWithIdentifier:viewName];
    
    // Show Data view controller
    [self pushViewController:viewController animated:animated];
    
    return viewController;
}

- (UIViewController *)showViewControllerWithClass:(Class)class animated:(BOOL)animated;
{
    // Initiate Data view controller
    UIViewController *viewController = [[class alloc] init];
    
    // Show Data view controller
    [self pushViewController:viewController animated:animated];
    
    return viewController;
}

@end
