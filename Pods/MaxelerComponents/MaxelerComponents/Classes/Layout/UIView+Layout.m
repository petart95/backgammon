/**
 *  @header UIView+Layout.m
 *
 *  @brief UIView+Layout implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Responsible for custom layout
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "UIView+Layout.h"
#import <objc/runtime.h>

@implementation UIView (Layout)

#pragma mark - Swizzled methods

- (void)swizzled_layoutSubviews;
{
    [self swizzled_layoutSubviews];
    
    [self activateLayoutConstraints];
}

- (id)swizzled_initWithFrame:(CGRect)frame;
{
    id result = [self swizzled_initWithFrame:frame];
    
    [result setLayoutConstraints:[[NSMutableArray alloc] init]];
    
    return result;
}

- (id)swizzled_initWithCoder:(NSCoder *)aDecoder;
{
    id result = [self swizzled_initWithCoder:aDecoder];
    
    [result setLayoutConstraints:[[NSMutableArray alloc] init]];
    
    return result;
}

#pragma mark - Load

+ (void)load;
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Method originalMethod, swizzledMethod;
        
        // Swizzle layoutSubviews
        originalMethod = class_getInstanceMethod(self, @selector(layoutSubviews));
        swizzledMethod = class_getInstanceMethod(self, @selector(swizzled_layoutSubviews));
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
        // Swizzle initWithFrame:
        originalMethod = class_getInstanceMethod(self, @selector(initWithFrame:));
        swizzledMethod = class_getInstanceMethod(self, @selector(swizzled_initWithFrame:));
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
        // Swizzle initWithCoder:
        originalMethod = class_getInstanceMethod(self, @selector(initWithCoder:));
        swizzledMethod = class_getInstanceMethod(self, @selector(swizzled_initWithCoder:));
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

#pragma mark - Layout constraints functions

- (void)addTouchesLeftSideOfViewConstraintFor:(UIView * _Nonnull)view
                                       offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:view.leftAnchor equalTo:self.leftAnchor constant:offset];
}

- (void)addTouchesRightSideOfViewConstraintFor:(UIView * _Nonnull)view
                                        offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:view.rightAnchor equalTo:self.rightAnchor constant:-offset];
}

- (void)addTouchesTopOfViewConstraintFor:(UIView * _Nonnull)view
                                  offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:view.topAnchor equalTo:self.topAnchor constant:offset];
}

- (void)addTouchesBottomOfViewConstraintFor:(UIView * _Nonnull)view
                                     offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:view.bottomAnchor equalTo:self.bottomAnchor constant:-offset];
}

@end
