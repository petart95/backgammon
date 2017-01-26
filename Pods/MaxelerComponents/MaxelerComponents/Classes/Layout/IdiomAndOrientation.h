/**
 *  @header IdiomAndOrientation.h
 *
 *  @brief IdiomAndOrientation header file
 *         in MaxelerComponents project.
 *
 *  @discussion Responsible for type(phone or iPad) and
 *              orientation(portrait and landscape) of device.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#ifndef IdiomAndOrientation_h
#define IdiomAndOrientation_h

/**
 *  @brief Returns the type of the Device in use.
 *
 *  @discussion This macro can return one of two possible values:
 *                  1) UIUserInterfaceIdiomPad - for iPad Devices
 *                  2) UIUserInterfaceIdiomPhone - for iPhone and iPod Devices
 */
#define IDIOM UI_USER_INTERFACE_IDIOM()

/**
 *  @brief Type returned by IDIOM and UI_USER_INTERFACE_IDIOM() if the Device is an iPad.
 */
#define IPAD UIUserInterfaceIdiomPad

/**
 *  @brief Type returned by IDIOM and UI_USER_INTERFACE_IDIOM() if the Device is an iPhone or iPod.
 */
#define PHONE UIUserInterfaceIdiomPhone

/**
 *  @brief Returns true if the type of the Device is IPAD (UIUserInterfaceIdiomPad)
 */
#define IS_IPAD (IDIOM == IPAD)

/**
 *  @brief Returns true if the type of the Device is PHONE (UIUserInterfaceIdiomPhone)
 */
#define IS_PHONE (IDIOM == PHONE)

/**
 *  @brief Returns the orientation of the Device.
 *
 *  @discussion This macro can return one of several possible values:
 *                  1) UIDeviceOrientationUnknown
 *                  2) UIDeviceOrientationPortrait
 *                  3) UIDeviceOrientationPortraitUpsideDown
 *                  4) UIDeviceOrientationLandscapeLeft
 *                  5) UIDeviceOrientationLandscapeRight
 *                  6) UIDeviceOrientationFaceUp
 *                  7) UIDeviceOrientationFaceDown
 */
#define ORIENTATION [UIDevice currentDevice].orientation

/**
 *  @brief Returns true if the orientation of the Device is Landscape
 */
#define IS_LANDSCAPE (UIDeviceOrientationIsLandscape(ORIENTATION))

/**
 *  @brief Returns true if the orientation of the Device is Portrait
 */
#define IS_PORTRAIT (UIDeviceOrientationIsPortrait(ORIENTATION))

/**
 *  @brief Returns true if the type of the Device is IPAD (UIUserInterfaceIdiomPad)
 *
 *  @return BOOL Is the type of the Device iPad
 */
BOOL isIpad();

/**
 *  @brief Returns true if the type of the Device is PHONE (UIUserInterfaceIdiomPhone)
 *
 *  @return BOOL Is the type of the Device iPhone or iPod
 */
BOOL isPhone();

/**
 *  @brief Returns true if the orientation of the Device is Landscape
 *
 *  @return BOOL Is the orientation of the Device Landscape
 */
BOOL isLandscape();

/**
 *  @brief Returns true if the orientation of the Device is Portrait
 *
 *  @return BOOL Is the orientation of the Device Portrait
 */
BOOL isPortrait();

#endif /* IdiomAndOrientation_h */
