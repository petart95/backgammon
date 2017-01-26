//
//  TriangleView.h
//  backgamon
//
//  Created by maxeler on 1/20/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TraingleSelected.h"

@class CircleView;

@interface TriangleView : UIView

@property TraingleSelected *backgroundView;
@property TraingleSelected *selectedView;

@property BOOL showBackgroundView;

@property UIColor *bottomColor;

@property UIColor *shadingColor;
@property CGFloat shadingWidth;

@property NSMutableArray<CircleView *>* circles;

- (void)showBackgrooundView:(BOOL)show animated:(BOOL)animated;

@end
