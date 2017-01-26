/**
 *  @header UIResponder+Layout.m
 *
 *  @brief UIResponder+Layout implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Responsible for custom layout (superclass of UIView and UIViewController).
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "UIResponder+Layout.h"
#import <objc/runtime.h>

static char layoutConstraintsKey;

@implementation UIResponder (Layout)

#pragma mark - Associated objects methods

- (NSMutableArray<NSLayoutConstraint *> *)layoutConstraints;
{
    return objc_getAssociatedObject(self, &layoutConstraintsKey);
}

- (void)setLayoutConstraints:(NSMutableArray<NSLayoutConstraint *> *)layoutConstraints;
{
    objc_setAssociatedObject(self, &layoutConstraintsKey, layoutConstraints, OBJC_ASSOCIATION_COPY);
}

#pragma mark - Helper function

- (void)setUpLayoutConstraints;
{
    // Add layout constraint when subclassed
}

- (void)activateLayoutConstraints;
{
    [NSLayoutConstraint deactivateConstraints:self.layoutConstraints];
    
    if ([self.layoutConstraints  count]) {
        NSMutableArray *constraints = [self.layoutConstraints mutableCopy];
        [constraints removeAllObjects];
        [self setLayoutConstraints:constraints];
    }
    
    [self setUpLayoutConstraints];
    
    [NSLayoutConstraint activateConstraints:self.layoutConstraints];
}

- (void)addLayoutConstraint:(NSLayoutConstraint *)layoutConstraint;
{
    NSMutableArray *constraints = [self.layoutConstraints mutableCopy];
    
    [constraints addObject:layoutConstraint];
    
    [self setLayoutConstraints:constraints];
}

#pragma mark - Layout constraints functions

- (void)addLayoutConstraintFor:(NSLayoutDimension * _Nonnull)forAnchor
                       equalTo:(NSLayoutDimension * _Nonnull)toAnchor
                    multiplier:(CGFloat)multiplier
                      constant:(CGFloat)constant;
{
    [self addLayoutConstraint:[forAnchor constraintEqualToAnchor:toAnchor
                                                      multiplier:multiplier
                                                        constant:constant]];
}

- (void)addLayoutConstraintFor:(NSLayoutDimension * _Nonnull)forAnchor
                       equalTo:(NSLayoutDimension * _Nonnull)toAnchor
                    multiplier:(CGFloat)multiplier;
{
    [self addLayoutConstraintFor:forAnchor equalTo:toAnchor multiplier:multiplier constant:0];
}

- (void)addLayoutConstraintFor:(NSLayoutAnchor * _Nonnull)forAnchor
                       equalTo:(NSLayoutAnchor * _Nonnull)toAnchor
                      constant:(CGFloat)constant;
{
    [self addLayoutConstraint:[forAnchor constraintEqualToAnchor:toAnchor constant:constant]];
}

- (void)addLayoutConstraintFor:(NSLayoutAnchor * _Nonnull)forAnchor
                       equalTo:(NSLayoutAnchor * _Nonnull)toAnchor;
{
    [self addLayoutConstraintFor:forAnchor equalTo:toAnchor constant:0];
}

- (void)addLayoutConstraintFor:(NSLayoutDimension * _Nonnull)forAnchor
               equalToConstant:(CGFloat)constant;
{
     [self addLayoutConstraintFor:forAnchor equalTo:forAnchor multiplier:0 constant:constant];
}

- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
                       onTopOf:(UIView * _Nonnull)toView
                        offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:forView.bottomAnchor equalTo:toView.topAnchor constant:-offset];
}

- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
                       onTopOf:(UIView * _Nonnull)toView;
{
    [self addLayoutConstraintFor:forView onTopOf:toView offset:0];
}

- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
                         under:(UIView * _Nonnull)toView
                        offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:forView.topAnchor equalTo:toView.bottomAnchor constant:offset];
}

- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
                         under:(UIView * _Nonnull)toView;
{
    [self addLayoutConstraintFor:forView under:toView offset:0];
}

- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
               onTheLeftSideOf:(UIView * _Nonnull)toView
                        offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:forView.rightAnchor equalTo:toView.leftAnchor constant:-offset];
}

- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
               onTheLeftSideOf:(UIView * _Nonnull)toView;
{
    [self addLayoutConstraintFor:forView onTheLeftSideOf:toView offset:0];
}

- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
              onTheRightSideOf:(UIView * _Nonnull)toView
                        offset:(CGFloat)offset;
{
    [self addLayoutConstraintFor:forView.leftAnchor equalTo:toView.rightAnchor constant:offset];
}

- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
              onTheRightSideOf:(UIView * _Nonnull)toView;
{
    [self addLayoutConstraintFor:forView onTheRightSideOf:toView offset:0];
}

- (void)addTouchesLeftSideOfViewConstraintFor:(UIView *)view;
{
    [self addTouchesLeftSideOfViewConstraintFor:view offset:0];
}

- (void)addTouchesRightSideOfViewConstraintFor:(UIView *)view;
{
    [self addTouchesRightSideOfViewConstraintFor:view offset:0];
}

- (void)addTouchesTopOfViewConstraintFor:(UIView *)view;
{
    [self addTouchesTopOfViewConstraintFor:view offset:0];
}

- (void)addTouchesBottomOfViewConstraintFor:(UIView *)view;
{
    [self addTouchesBottomOfViewConstraintFor:view offset:0];
}

- (void)addMaxHeightConstraintsFor:(UIView * _Nonnull)view
                         topOffset:(CGFloat)topOffset
                      bottomOffset:(CGFloat)bottomOffset;
{
    [self addTouchesTopOfViewConstraintFor:view offset:topOffset];
    [self addTouchesBottomOfViewConstraintFor:view offset:bottomOffset];
}

- (void)addMaxHeightConstraintsFor:(UIView * _Nonnull)view;
{
    [self addMaxHeightConstraintsFor:view topOffset:0 bottomOffset:0];
}

- (void)addMaxWidthConstraintsFor:(UIView * _Nonnull)view
                       leftOffset:(CGFloat)leftOffset
                      rightOffset:(CGFloat)rightOffset;
{
    [self addTouchesLeftSideOfViewConstraintFor:view offset:leftOffset];
    [self addTouchesRightSideOfViewConstraintFor:view offset:rightOffset];
}

- (void)addMaxWidthConstraintsFor:(UIView * _Nonnull)view;
{
    [self addMaxWidthConstraintsFor:view leftOffset:0 rightOffset:0];
}

- (void)addMaxWidthAndHeightConstraintsFor:(UIView * _Nonnull)view
                                 topOffset:(CGFloat)topOffset
                              bottomOffset:(CGFloat)bottomOffset
                                leftOffset:(CGFloat)leftOffset
                               rightOffset:(CGFloat)rightOffset;
{
    [self addMaxWidthConstraintsFor:view leftOffset:leftOffset rightOffset:rightOffset];
    [self addMaxHeightConstraintsFor:view topOffset:topOffset bottomOffset:bottomOffset];
}

- (void)addMaxWidthAndHeightConstraintsFor:(UIView * _Nonnull)view
                                leftOffset:(CGFloat)leftOffset
                               rightOffset:(CGFloat)rightOffset;
{
    [self addMaxWidthAndHeightConstraintsFor:view
                                   topOffset:0
                                bottomOffset:0
                                  leftOffset:leftOffset
                                 rightOffset:rightOffset];
}

- (void)addMaxWidthAndHeightConstraintsFor:(UIView * _Nonnull)view
                                 topOffset:(CGFloat)topOffset
                              bottomOffset:(CGFloat)bottomOffset;
{
    [self addMaxWidthAndHeightConstraintsFor:view
                                   topOffset:topOffset
                                bottomOffset:bottomOffset
                                  leftOffset:0
                                 rightOffset:0];
}

- (void)addMaxWidthAndHeightConstraintsFor:(UIView * _Nonnull)view;
{
    [self addMaxWidthAndHeightConstraintsFor:view
                                   topOffset:0
                                bottomOffset:0
                                  leftOffset:0
                                 rightOffset:0];
}

- (void)addTouchesTopOfViewConstraintFor:(UIView *)view offset:(CGFloat)offset;
{
    // This method should be implemented by UIView and UIViewController subclasses.
}

- (void)addTouchesBottomOfViewConstraintFor:(UIView *)view offset:(CGFloat)offset;
{
    // This method should be implemented by UIView and UIViewController subclasses.
}

- (void)addTouchesLeftSideOfViewConstraintFor:(UIView *)view offset:(CGFloat)offset;
{
    // This method should be implemented by UIView and UIViewController subclasses.
}

- (void)addTouchesRightSideOfViewConstraintFor:(UIView *)view offset:(CGFloat)offset;
{
    // This method should be implemented by UIView and UIViewController subclasses.
}

@end
