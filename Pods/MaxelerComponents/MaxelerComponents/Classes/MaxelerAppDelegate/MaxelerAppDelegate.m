/**
 *  @header MaxelerAppDelegate.h
 *
 *  @brief MaxelerAppDelegate implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Subclass of UIResponder <UIApplicationDelegate>
 *              responsible for starting the app without the storyboard.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "MaxelerAppDelegate.h"

@interface MaxelerAppDelegate ()

@property (strong, nonatomic) UINavigationController *navigationController;

@end

@implementation MaxelerAppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
{
    // Initiate Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Initiate Navigation controller
    self.navigationController = [[[self.class navigationControllerClass] alloc] init];
    
    // Set Navigation controller as root view
    [self.window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

+ (Class)navigationControllerClass;
{
    return [UINavigationController class];
}

@end
