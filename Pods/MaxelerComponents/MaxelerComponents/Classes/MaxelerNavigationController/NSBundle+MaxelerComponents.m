/**
 *  @header NSBundle+MaxelerComponents.h
 *
 *  @brief NSBundle+MaxelerComponents implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Returns path to MaxelerComponents framework and bundle.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "NSBundle+MaxelerComponents.h"
#import "MaxelerToolbar.h"

@implementation NSBundle (MaxelerComponents)

+ (NSBundle *)maxelerComponentsFramework;
{
    return [NSBundle bundleForClass:[MaxelerToolbar class]];
}

+ (NSBundle *)maxelerComponentsBundle;
{
    NSBundle *framework = [NSBundle maxelerComponentsFramework];
    NSURL *bundleURL = [framework URLForResource:@"MaxelerComponents" withExtension:@"bundle"];
    
    return [NSBundle bundleWithURL:bundleURL];
}

@end
