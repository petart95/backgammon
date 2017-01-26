/**
 *  @header MaxelerViewController.h
 *
 *  @brief MaxelerViewController implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Subclass ofUIViewController with
 *              custom layout options, usage message support and Google ad banner.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "MaxelerViewController.h"
#import "MaxelerNavigationController.h"

//@import GoogleMobileAds;

@interface MaxelerViewController ()

/**
 *  @brief Usage message
 */
@property NSString *usageMsg;

@end

@implementation MaxelerViewController

#pragma mark - Setup

- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    self.usageMsg = @"";
    self.showUsageMessageType = ShowUsageMessageOnFirstViewDidLoad;
    self.useAds = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setLayoutConstraints:[[NSMutableArray alloc] init]];
    
    /*if (self.useAds) {
        self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        [self.view addSubview:self.bannerView];
        
        // Replace this ad unit ID with your own ad unit ID.
        self.bannerView.adUnitID = [self.class adUnitID];
        self.bannerView.rootViewController = self;
        
        [self.bannerView loadRequest:[self.class googleADRequest]];
    }*/
    
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews;
{
    [super viewWillLayoutSubviews];
    
    [self.view bringSubviewToFront:self.bannerView];
    [UIView setAnimationsEnabled:YES];
    [self.view sizeToFit];
    [self activateLayoutConstraints];
}

- (void)viewDidLayoutSubviews;
{
    [super viewDidLayoutSubviews];
    
   /* if (self.useAds) {
        CGFloat x = (self.view.frame.size.width - self.bannerView.frame.size.width) / 2;
        CGFloat y = [[UIScreen mainScreen] applicationFrame].size.height -
                    self.bannerView.frame.size.height - 5 -
                    self.navigationController.toolbar.frame.size.height -
                    self.navigationController.navigationBar.frame.size.height;
        
        
        self.bannerView.frame = CGRectMake(x, y, self.bannerView.frame.size.width,
                                           self.bannerView.frame.size.height);
    }*/
    
    [self.view sizeToFit];
}

-(void)viewDidAppear:(BOOL)animated;
{
    [super viewDidAppear:animated];
    
    if (![self.usageMsg isEqualToString:@""]) {
        
        UIAlertController *alertController =
            [UIAlertController alertControllerWithTitle:@"Usage"
                                                message:self.usageMsg
                                         preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        
        if (self.showUsageMessageType != ShowUsageMessageOnAllViewDidAppear) {
            self.usageMsg = @"";
        }
    }
}

#pragma mark - Helper functions

- (void)setUsageMessage:(NSString * _Nonnull __strong * _Nonnull)usageMessage;
{
    self.usageMsg = *usageMessage;
    
    if (self.showUsageMessageType == ShowUsageMessageOnFirstViewDidLoad) {
        *usageMessage = @"";
    }
}

- (void)showWarningWithMessage:(NSString * _Nonnull)warningMessage;
{
    UIAlertController *alertController =
    [UIAlertController  alertControllerWithTitle:@"Warning"
                                         message:warningMessage
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:actionOk];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Ads

+ (NSString *)adUnitID;
{
    return @"ca-app-pub-3940256099942544/2934735716";
}

/*+ (GADRequest *)googleADRequest;
{
    static GADRequest *request = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        GADRequest *request = [GADRequest request];
        // Requests test ads on devices you specify.
        // Your test device ID is printed to the console when an ad request is made.
        // GADBannerView automatically returns test ads when running on a simulator.
        request.testDevices = @[
                                @"fb0f9122cc97b28f1cc2136fec3454e4",  // Petar's iPad
                                @"ea098144c9a28a4b375ae599afcb39f9"   // Petar's iPod Touch
                                ];
    });
    
    return request;
}*/

#pragma mark - Layout constraints functions

- (void)addTouchesLeftSideOfViewConstraintFor:(UIView * _Nonnull)view
                                       offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:view.leftAnchor equalTo:self.view.leftAnchor
                        constant:offset];
}

- (void)addTouchesRightSideOfViewConstraintFor:(UIView * _Nonnull)view
                                        offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:view.rightAnchor equalTo:self.view.rightAnchor
                        constant:-offset];
}

- (void)addTouchesTopOfViewConstraintFor:(UIView * _Nonnull)view
                                  offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:view.topAnchor equalTo:self.view.topAnchor
                        constant:self.topLayoutGuide.length + offset];
}

- (void)addTouchesBottomOfViewConstraintFor:(UIView * _Nonnull)view
                                     offset:(CGFloat)offset
{
    [self addLayoutConstraintFor:view.bottomAnchor equalTo:self.view.bottomAnchor
                        constant:-self.bottomLayoutGuide.length - offset];
}

@end
