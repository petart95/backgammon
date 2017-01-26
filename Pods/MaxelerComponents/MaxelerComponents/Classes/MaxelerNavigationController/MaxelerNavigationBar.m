/**
 *  @header MaxelerNavigationBar.h
 *
 *  @brief MaxelerNavigationBar implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Subclass of UINavigationBar with custom options.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "MaxelerNavigationBar.h"
#import "MaxColor.h"

@implementation MaxelerNavigationBar

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.translucent = NO;
        
        self.backgroundColor = [UIColor maxblueColor];
        self.textColor = [UIColor cloudsColor];
        self.isStatusBarColorWhite = YES;
    }
    
    return self;
}

- (void)layoutSubviews;
{
    [super layoutSubviews];
    
    // Navigation bar background color
    self.barTintColor = self.backgroundColor;
    super.backgroundColor = self.backgroundColor;
    
    // Navigation bar text color
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:self.textColor}];
    self.tintColor = self.textColor;
    
    if(self.isStatusBarColorWhite) {
        // Change status bar color to white
        self.barStyle = UIBarStyleBlack;
    } else {
        self.barStyle = UIBarStyleDefault;
    }
}

@end
