/**
 *  @header UIResponder+Layout.h
 *
 *  @brief UIResponder+Layout header file
 *         in MaxelerComponents project.
 *
 *  @discussion Responsible for custom layout (superclass of UIView and UIViewController).
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import <UIKit/UIKit.h>
#import "IdiomAndOrientation.h"

@interface UIResponder (Layout)

/**
 *  @brief A list of all layout constraints.
 *
 *  @discussion This property should only be changed using addLayoutConstraint functions,
 *              any other type of use can lead up to undefined behavior.
 *
 *  @see UIResponder::addLayoutConstraint:
 */
@property (nonatomic, nonnull) NSMutableArray<NSLayoutConstraint *> *layoutConstraints;

/**
 *  @brief Function in which to set all layout constraints.
 *
 *  @discussion Any layout constraint not added in this function can lead up to undefined behavior.
 */
- (void)setUpLayoutConstraints;

/**
 *  @brief Activates all layout constraints.
 *
 *  @discussion This function is called inside layoutSubviews in UIView+Layout and
 *              viewWillLayoutSubviews in MaxelerViewController.
 *              This function first deactivates all layout constraints and then
 *              calls [self setUpLayoutConstraints] to set up all layout constraints
 *              and activates them.
 *
 *  @see UIResponder::setUpLayoutConstraints
 */
- (void)activateLayoutConstraints;

/**
 *  @brief Adds layout constraint to *layoutConstraints*.
 *
 *  @param layoutConstraint The layout constraint to be added.
 *  
 *  @see UIResponder::layoutConstraints
 */
- (void)addLayoutConstraint:(NSLayoutConstraint * _Nonnull)layoutConstraint;

/**
 *  @brief Adds a layout constraint that defines the anchor’s size attribute as
 *         equal to the specified size attribute multiplied by a constant plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forAnchor = (toAnchor * multiplier) + constant;
 *  @endcode
 *
 *  @param forAnchor The anchor for which to add the constraint.
 *  @param toAnchor The anchor to which it is equal.
 *  @param multiplier The multiplier constant for the constraint.
 *  @param constant The offset constant for this relationship.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:constant:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:
 */
- (void)addLayoutConstraintFor:(NSLayoutDimension * _Nonnull)forAnchor
                       equalTo:(NSLayoutDimension * _Nonnull)toAnchor
                    multiplier:(CGFloat)multiplier
                      constant:(CGFloat)constant;

/**
 *  @brief Adds a layout constraint that defines the anchor’s size attribute as
 *         equal to the specified size attribute multiplied by a constant.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forAnchor = toAnchor * multiplier;
 *  @endcode
 *
 *  @param forAnchor The anchor for which to add the constraint.
 *  @param toAnchor The anchor to which it is equal.
 *  @param multiplier The multiplier constant for the constraint.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:constant:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:
 */
- (void)addLayoutConstraintFor:(NSLayoutDimension * _Nonnull)forAnchor
                       equalTo:(NSLayoutDimension * _Nonnull)toAnchor
                    multiplier:(CGFloat)multiplier;

/**
 *  @brief Adds a layout constraint that defines the anchor’s size attribute as
 *         equal to the specified size attribute plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forAnchor = toAnchor + constant;
 *  @endcode
 *
 *  @param forAnchor The anchor for which to add the constraint.
 *  @param toAnchor The anchor to which it is equal.
 *  @param constant The offset constant for this relationship.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:
 */
- (void)addLayoutConstraintFor:(NSLayoutAnchor * _Nonnull)forAnchor
                       equalTo:(NSLayoutAnchor * _Nonnull)toAnchor
                      constant:(CGFloat)constant;

/**
 *  @brief Adds a layout constraint that defines the anchor’s size attribute as
 *         equal to the specified size attribute.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forAnchor = toAnchor;
 *  @endcode
 *
 *  @param forAnchor The anchor for which to add the constraint.
 *  @param toAnchor The anchor to which it is equal.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:constant:
 */
- (void)addLayoutConstraintFor:(NSLayoutAnchor * _Nonnull)forAnchor
                       equalTo:(NSLayoutAnchor * _Nonnull)toAnchor;

/**
 *  @brief Adds a layout constraint that defines the anchor’s size attribute as
 *         equal to the specified constant.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forAnchor = constant;
 *  @endcode
 *
 *  @param forAnchor The anchor for which to add the constraint.
 *  @param constant The constant for this relationship.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:constant:
 */
- (void)addLayoutConstraintFor:(NSLayoutDimension * _Nonnull)forAnchor
               equalToConstant:(CGFloat)constant;

/**
 *  @brief Adds a layout constraint that defines the forView’s position attribute
 *         in such a way that it is on top of toView plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forView.bottomAnchor = toView.topAnchor - offset;
 *  @endcode
 *
 *  @param forView The view for which to add the constraint.
 *  @param toView The view to which it is equal.
 *  @param offset The constant for this relationship.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:onTopOf:
 */
- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
                       onTopOf:(UIView * _Nonnull)toView
                        offset:(CGFloat)offset;

/**
 *  @brief Adds a layout constraint that defines the forView’s position attribute
 *         in such a way that it is on top of toView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forView.bottomAnchor = toView.topAnchor;
 *  @endcode
 *
 *  @param forView The view for which to add the constraint.
 *  @param toView The view to which it is equal.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:onTopOf:offset:
 */
- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
                       onTopOf:(UIView * _Nonnull)toView;

/**
 *  @brief Adds a layout constraint that defines the forView’s position attribute
 *         in such a way that it is under toView plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forView.topAnchor = toView.bottomAnchor + offset;
 *  @endcode
 *
 *  @param forView The view for which to add the constraint.
 *  @param toView The view to which it is equal.
 *  @param offset The constant for this relationship.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:under:
 */
- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
                         under:(UIView * _Nonnull)toView
                        offset:(CGFloat)offset;

/**
 *  @brief Adds a layout constraint that defines the forView’s position attribute
 *         in such a way that it is under toView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forView.topAnchor = toView.bottomAnchor;
 *  @endcode
 *
 *  @param forView The view for which to add the constraint.
 *  @param toView The view to which it is equal.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:under:offset:
 */
- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
                         under:(UIView * _Nonnull)toView;

/**
 *  @brief Adds a layout constraint that defines the forView’s position attribute
 *         in such a way that it is on the left side of toView plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forView.rightAnchor = toView.leftAnchor - offset;
 *  @endcode
 *
 *  @param forView The view for which to add the constraint.
 *  @param toView The view to which it is equal.
 *  @param offset The constant for this relationship.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:onTheLeftSideOf:
 */
- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
               onTheLeftSideOf:(UIView * _Nonnull)toView
                        offset:(CGFloat)offset;

/**
 *  @brief Adds a layout constraint that defines the forView’s position attribute
 *         in such a way that it is on the left side of toView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forView.rightAnchor = toView.leftAnchor;
 *  @endcode
 *
 *  @param forView The view for which to add the constraint.
 *  @param toView The view to which it is equal.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:onTheLeftSideOf:offset:
 */
- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
               onTheLeftSideOf:(UIView * _Nonnull)toView;

/**
 *  @brief Adds a layout constraint that defines the forView’s position attribute
 *         in such a way that it is on the right side of toView plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forView.leftAnchor = toView.rightAnchor + offset;
 *  @endcode
 *
 *  @param forView The view for which to add the constraint.
 *  @param toView The view to which it is equal.
 *  @param offset The constant for this relationship.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:onTheRightSideOf:
 */
- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
              onTheRightSideOf:(UIView * _Nonnull)toView
                        offset:(CGFloat)offset;

/**
 *  @brief Adds a layout constraint that defines the forView’s position attribute
 *         in such a way that it is on the right side of toView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      forView.leftAnchor = toView.rightAnchor;
 *  @endcode
 *
 *  @param forView The view for which to add the constraint.
 *  @param toView The view to which it is equal.
 *
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 *  @see UIResponder::addLayoutConstraintFor:onTheRightSideOf:offset:
 */
- (void)addLayoutConstraintFor:(UIView * _Nonnull)forView
              onTheRightSideOf:(UIView * _Nonnull)toView;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches top of UIView plus topOffset
 *         and bottom of UIView plus bottomOffset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.topAnchor = self.topAnchor + topOffset;
 *      view.bottomAnchor = self.bottomAnchor - bottomOffset;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *  @param topOffset The offset from top of the UIView.
 *  @param bottomOffset The offset from bottom of the UIView.
 *
 *  @see UIResponder::addMaxHeightConstraintsFor:
 *  @see UIResponder::addTouchesTopOfViewConstraintFor:offset:
 *  @see UIResponder::addTouchesBottomOfViewConstraintFor:offset:
 */
- (void)addMaxHeightConstraintsFor:(UIView * _Nonnull)view
                         topOffset:(CGFloat)topOffset
                      bottomOffset:(CGFloat)bottomOffset;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches top and bottom of UIView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.topAnchor = self.topAnchor;
 *      view.bottomAnchor = self.bottomAnchor;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *
 *  @see UIResponder::addMaxHeightConstraintsFor:topOffset:bottomOffset:
 *  @see UIResponder::addTouchesTopOfViewConstraintFor:
 *  @see UIResponder::addTouchesBottomOfViewConstraintFor:
 */
- (void)addMaxHeightConstraintsFor:(UIView * _Nonnull)view;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches left side of UIView plus leftOffset
 *         and right side of UIView plus rightOffset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.leftAnchor = self.leftAnchor + leftOffset;
 *      view.rightAnchor = self.rightAnchor - rightOffset;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *  @param leftOffset The offset from left side of the UIView.
 *  @param rightOffset The offset from right side of the UIView.
 *
 *  @see UIResponder::addMaxWidthConstraintsFor:
 *  @see UIResponder::addTouchesLeftSideOfViewConstraintFor:offset:
 *  @see UIResponder::addTouchesRightSideOfViewConstraintFor:offset:
 */
- (void)addMaxWidthConstraintsFor:(UIView * _Nonnull)view
                       leftOffset:(CGFloat)leftOffset
                      rightOffset:(CGFloat)rightOffset;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches left and right side of UIView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.leftAnchor = self.leftAnchor;
 *      view.rightAnchor = self.rightAnchor;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *
 *  @see UIResponder::addMaxWidthConstraintsFor:leftOffset:rightOffset:
 *  @see UIResponder::addTouchesLeftSideOfViewConstraintFor:
 *  @see UIResponder::addTouchesRightSideOfViewConstraintFor:
 */
- (void)addMaxWidthConstraintsFor:(UIView * _Nonnull)view;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches left side of UIView plus leftOffset,
 *         right side of UIView plus rightOffset, top of UIView plus topOffset
 *         and bottom of UIView plus bottomOffset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.topAnchor = self.topAnchor + topOffset;
 *      view.bottomAnchor = self.bottomAnchor - bottomOffset;
 *      view.leftAnchor = self.leftAnchor + leftOffset;
 *      view.rightAnchor = self.rightAnchor - rightOffset;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *  @param topOffset The offset from top of the UIView.
 *  @param bottomOffset The offset from bottom of the UIView.
 *  @param leftOffset The offset from left side of the UIView.
 *  @param rightOffset The offset from right side of the UIView.
 *
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:topOffset:bottomOffset:
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:leftOffset:rightOffset:
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:
 *  @see UIResponder::addMaxHeightConstraintsFor:topOffset:bottomOffset:
 *  @see UIResponder::addMaxWidthConstraintsFor:leftOffset:rightOffset:
 */
- (void)addMaxWidthAndHeightConstraintsFor:(UIView * _Nonnull)view
                                 topOffset:(CGFloat)topOffset
                              bottomOffset:(CGFloat)bottomOffset
                                leftOffset:(CGFloat)leftOffset
                               rightOffset:(CGFloat)rightOffset;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches left side of UIView plus leftOffset,
 *         right side of UIView plus rightOffset, top of UIView and bottom of UIView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.topAnchor = self.topAnchor;
 *      view.bottomAnchor = self.bottomAnchor;
 *      view.leftAnchor = self.leftAnchor + leftOffset;
 *      view.rightAnchor = self.rightAnchor - rightOffset;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *  @param leftOffset The offset from left side of the UIView.
 *  @param rightOffset The offset from right side of the UIView.
 *
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:
 *                    topOffset:bottomOffset:leftOffset:rightOffset:
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:topOffset:bottomOffset:
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:
 *  @see UIResponder::addMaxHeightConstraintsFor:
 *  @see UIResponder::addMaxWidthConstraintsFor:leftOffset:rightOffset:
 */
- (void)addMaxWidthAndHeightConstraintsFor:(UIView * _Nonnull)view
                                leftOffset:(CGFloat)leftOffset
                               rightOffset:(CGFloat)rightOffset;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches top of UIView plus topOffset,
 *         bottom of UIView plus bottomOffset and left and right side of UIView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.topAnchor = self.topAnchor + topOffset;
 *      view.bottomAnchor = self.bottomAnchor - bottomOffset;
 *      view.leftAnchor = self.leftAnchor;
 *      view.rightAnchor = self.rightAnchor;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *  @param topOffset The offset from top of the UIView.
 *  @param bottomOffset The offset from bottom of the UIView.
 *
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:
 *                    topOffset:bottomOffset:leftOffset:rightOffset:
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:leftOffset:rightOffset:
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:
 *  @see UIResponder::addMaxHeightConstraintsFor:topOffset:bottomOffset:
 *  @see UIResponder::addMaxWidthConstraintsFor:
 */
- (void)addMaxWidthAndHeightConstraintsFor:(UIView * _Nonnull)view
                                 topOffset:(CGFloat)topOffset
                              bottomOffset:(CGFloat)bottomOffset;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches top, bottom, left and right side of UIView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.topAnchor = self.topAnchor;
 *      view.bottomAnchor = self.bottomAnchor;
 *      view.leftAnchor = self.leftAnchor;
 *      view.rightAnchor = self.rightAnchor;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:
 *                    topOffset:bottomOffset:leftOffset:rightOffset:
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:leftOffset:rightOffset:
 *  @see UIResponder::addMaxWidthAndHeightConstraintsFor:topOffset:bottomOffset:
 *  @see UIResponder::addMaxHeightConstraintsFor:
 *  @see UIResponder::addMaxWidthConstraintsFor:
 */
- (void)addMaxWidthAndHeightConstraintsFor:(UIView * _Nonnull)view;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches left side of UIView plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.leftAnchor = self.leftAnchor + offset;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *  @param offset The offset from left side of the UIView.
 *
 *  @see UIResponder::addTouchesLeftSideOfViewConstraintFor:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 */
- (void)addTouchesLeftSideOfViewConstraintFor:(UIView * _Nonnull)view
                                       offset:(CGFloat)offset;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches left side of UIView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.leftAnchor = self.leftAnchor;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *
 *  @see UIResponder::addTouchesLeftSideOfViewConstraintFor:offset:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 */
- (void)addTouchesLeftSideOfViewConstraintFor:(UIView * _Nonnull)view;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches right side of UIView plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.rightAnchor = self.rightAnchor - offset;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *  @param offset The offset from right side of the UIView.
 *
 *  @see UIResponder::addTouchesRightSideOfViewConstraintFor:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 */
- (void)addTouchesRightSideOfViewConstraintFor:(UIView * _Nonnull)view
                                        offset:(CGFloat)offset;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches right side of UIView plus.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.rightAnchor = self.rightAnchor;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *
 *  @see UIResponder::addTouchesRightSideOfViewConstraintFor:offset
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 */
- (void)addTouchesRightSideOfViewConstraintFor:(UIView * _Nonnull)view;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches top of UIView plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.topAnchor = self.topAnchor + offset;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *  @param offset The offset from top of the UIView.
 *
 *  @see UIResponder::addTouchesTopOfViewConstraintFor:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 */
- (void)addTouchesTopOfViewConstraintFor:(UIView * _Nonnull)view
                                  offset:(CGFloat)offset;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches top of UIView plus.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.topAnchor = self.topAnchor;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *
 *  @see UIResponder::addTouchesTopOfViewConstraintFor:offset
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 */
- (void)addTouchesTopOfViewConstraintFor:(UIView * _Nonnull)view;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches bottom of UIView plus an offset.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.bottomAnchor = self.bottomAnchor - offset;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *  @param offset The offset from bottom of the UIView.
 *
 *  @see UIResponder::addTouchesBottomOfViewConstraintFor:
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 */
- (void)addTouchesBottomOfViewConstraintFor:(UIView * _Nonnull)view
                                     offset:(CGFloat)offset;

/**
 *  @brief Adds a layout constraint that defines the view’s position attribute
 *         in such a way that it touches bottom of UIView.
 *
 *  @discussion This method defines the relationship:
 *
 *  @code
 *      view.bottomAnchor = self.bottomAnchor;
 *  @endcode
 *
 *  @param view The view for which to add the constraint.
 *
 *  @see UIResponder::addTouchesBottomOfViewConstraintFor:offset
 *  @see UIResponder::addLayoutConstraintFor:equalTo:multiplier:constant:
 */
- (void)addTouchesBottomOfViewConstraintFor:(UIView * _Nonnull)view;

@end
