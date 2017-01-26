/**
 *  @file IdiomAndOrientation.m
 *
 *  @brief IdiomAndOrientation implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Responsible for type(phone or iPad) and
 *              orientation(portrait and landscape) of device.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "IdiomAndOrientation.h"

BOOL isIpad()
{
    return IS_IPAD;
}

BOOL isPhone()
{
    return IS_PHONE;
}

BOOL isLandscape()
{
    return IS_LANDSCAPE;
}

BOOL isPortrait()
{
    return IS_PORTRAIT;
}
