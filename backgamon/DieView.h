//
//  DieView.h
//  DiceRoll
//
//  Created by Christopher Ching on 2013-09-19.
//  Copyright (c) 2013 CodeWithChris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DieView : UIView

#pragma mark Properties

@property (nonatomic, strong) UIImageView *dieImage;
@property UIView *dimView;

#pragma mark Methods

- (void)showDieNumber:(int)num;

@end
