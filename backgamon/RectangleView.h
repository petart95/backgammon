//
//  RectangleView.h
//  backgamon
//
//  Created by maxeler on 1/26/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RectangleSelected.h"

@interface RectangleView : UIView

@property RectangleSelected *backgroundView;
@property RectangleSelected *selectedView;

@property BOOL showBackgroundView;

@property UIColor *bottomColor;

- (void)showBackgrooundView:(BOOL)show animated:(BOOL)animated;

@end
