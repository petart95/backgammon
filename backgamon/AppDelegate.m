//
//  AppDelegate.m
//  backgamon
//
//  Created by maxeler on 1/20/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "AppDelegate.h"
#import "BackgamonNavigationController.h"


@implementation AppDelegate

+ (Class)navigationControllerClass;
{
    return [BackgamonNavigationController class];
}

@end
