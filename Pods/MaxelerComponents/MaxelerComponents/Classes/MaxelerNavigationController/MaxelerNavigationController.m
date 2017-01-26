/**
 *  @header MaxelerNavigationController.h
 *
 *  @brief MaxelerNavigationController implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Subclass of UINavigationController that uses
 *              MaxelerNavigationBar and MaxelerToolbar.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "MaxelerNavigationController.h"
#import "MaxelerNavigationBar.h"
#import "MaxelerToolbar.h"

@implementation MaxelerNavigationController

#pragma mark - Instancetype

- (instancetype)init;
{
    self = [super initWithNavigationBarClass:[MaxelerNavigationBar class]
                                toolbarClass:[MaxelerToolbar class]];
    
    if (self) {
        self.toolbarHidden = NO;
    }
        
    return self;
}

@end
