//
//  BackgamonNavigationController.m
//  backgamon
//
//  Created by maxeler on 1/20/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "BackgamonNavigationController.h"
#import "ViewController.h"
#import "OptionsViewController.h"

@interface BackgamonNavigationController ()

@end

@implementation BackgamonNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ((MaxelerToolbar *)self.toolbar).textLabel.text = @"by Petar Trifunovic";
    
    ((MaxelerToolbar *)self.toolbar).logoHeight = 0;
    //((MaxelerToolbar *)self.toolbar).toolbarHeight = 0;
    
    UIImage* image = [UIImage imageNamed: @"felt"];
    
    [[UIToolbar appearance]
     setBackgroundImage: image
     forToolbarPosition: UIToolbarPositionAny
     barMetrics: UIBarMetricsDefault];
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.toolbar.clipsToBounds = YES;
    
    [self showViewControllerWithClass:[OptionsViewController class] animated:NO];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


@end
