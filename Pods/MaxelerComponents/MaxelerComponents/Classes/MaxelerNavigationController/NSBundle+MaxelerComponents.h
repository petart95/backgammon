/**
 *  @header NSBundle+MaxelerComponents.h
 *
 *  @brief NSBundle+MaxelerComponents header file
 *         in MaxelerComponents project.
 *
 *  @discussion Returns path to MaxelerComponents framework and bundle.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import <Foundation/Foundation.h>

@interface NSBundle (MaxelerComponents)

/**
 *  @brief The MaxelerComponents.framework
 *
 *  @return NSBundle * Returns MaxelerComponents.framework
 */
+ (NSBundle *)maxelerComponentsFramework;

/**
 *  @brief The MaxelerComponents.bundle
 *
 *  @return NSBundle * Returns MaxelerComponents.bundle
 */
+ (NSBundle *)maxelerComponentsBundle;

@end
