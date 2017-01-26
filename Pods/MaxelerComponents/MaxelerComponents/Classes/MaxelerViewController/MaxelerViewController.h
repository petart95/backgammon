/**
 *  @header MaxelerViewController.h
 *
 *  @brief MaxelerViewController header file
 *         in MaxelerComponents project.
 *
 *  @discussion Subclass ofUIViewController with 
 *              custom layout options, usage message support and Google ad banner.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import <UIKit/UIKit.h>
#import "UIResponder+Layout.h"

@class GADBannerView;
@class GADRequest;

/**
 *  @brief ShowUsageMessageType represent the behavior of message view.
 */
enum ShowUsageMessageType : NSUInteger {
    /** @brief Shows usage message whenever viewDidLoad method is called. */
    ShowUsageMessageOnAllViewDidLoad = 1,
    /** @brief Shows usage message whenever viewDidAppear method is called. */
    ShowUsageMessageOnAllViewDidAppear = 2,
    /** @brief Shows usage message only on first viewDidLoad method call. */
    ShowUsageMessageOnFirstViewDidLoad = 4,
    /** @brief Doesn't show usage message. */
    ShowUsageMessageNever = 8,
};

/**
 *  @class MaxelerViewController
 *
 *  @brief The MaxelerViewController class.
 *
 *  @discussion This class adds the option to show usage message
 *              and can show usage banner on the bottom of the view.
 *
 *  @superclass  Super Class: UIViewController
 */
@interface MaxelerViewController : UIViewController

/**
 *  @brief Google Ad banner.
 *
 *  @discussion This banner is centered and located on the bottom of the view.
 *              Size of the banner is 320x50.
 */
@property (strong, nonatomic, nonnull) GADBannerView *bannerView;

/*
 *  @brief Indicates whether or not to the ads banner should be shown.
 *  
 *  @discussion When set to YES the banner will be shown.
 *              Standard value is YES.
 */
@property BOOL useAds;

/*
 *  @brief The type of behavior the usage view should have.
 *  
 *  @discussion Standard value is ShowUsageMessageOnFirstViewDidLoad
 *
 *  @see :ShowUsageMessageType
 */
@property enum ShowUsageMessageType showUsageMessageType;

/**
 *  @brief Sets usage message.
 *
 *  @discussion The message can be changed to "" 
 *              if the ShowUsageMessageType is ShowUsageMessageOnFirstViewDidLoad
 *
 *  @param usageMessage The pointer to the usage message.
 */
- (void)setUsageMessage:(NSString * _Nonnull __strong * _Nonnull)usageMessage;

/**
 *  @brief Shows warning message.
 *
 *  @discussion This function creates a UIAlertController with the specified warning message,
 *              "Warning" title and an "OK" button.
 *
 *  @param warningMessage The warning message
 */
- (void)showWarningWithMessage:(NSString * _Nonnull)warningMessage;

/**
 *  @brief Ad unit id.
 *  
 *  @discussion This function should return the ad unit id of the developer.
 *
 *  @remark This function currently returns the test ad unit id!
 *
 *  @return NSString Return the ad unit id.
 */
+ (NSString * _Nonnull)adUnitID;

/**
 *  @brief Returns GADRequest.
 *
 *  @discussion This request is only created once, and is used in all the MaxelerViewControllers
 *
 *  @return GADRequest Returns GADRequest.
 */
+ (GADRequest * _Nonnull)googleADRequest;

@end
