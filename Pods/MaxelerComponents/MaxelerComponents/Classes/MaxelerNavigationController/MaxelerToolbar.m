/**
 *  @header MaxelerToolbar.h
 *
 *  @brief MaxelerToolbar implementation file
 *         in MaxelerComponents project.
 *
 *  @discussion Subclass of UIToolbar with custom options.
 *
 *  @author Petar Trifunovic - ptrifunovic@maxeler.com
 *  @copyright Copyright © 2017 Maxeler Technologies. All rights reserved.
 *  @version 1.8
 */

#import "MaxelerToolbar.h"
#import "UIView+Layout.h"
#import "NSBundle+MaxelerComponents.h"
#import "SVGKit.h"
#import "MaxColor.h"

@implementation MaxelerToolbar

#pragma mark - Setup

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.translucent = NO;
        
        self.backgroundColor = [UIColor maxblueColor];
        self.textColor = [UIColor cloudsColor];
        self.toolbarHeight = 30;
        self.logoHeight = 22;
        self.siteURL = @"http://www.maxeler.com/";
        
        // Create logo image
        SVGKImage* newImage = [SVGKImage imageNamed:@"maxeler-white"
                                           inBundle:[NSBundle maxelerComponentsBundle]];
        self.logoImage = [[SVGKFastImageView alloc] initWithSVGKImage:newImage];
        [self addSubview:self.logoImage];
        
        // Create label view
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.text = @"by Maxeler Technologies";
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
        
        // Add tap gesture
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [self addGestureRecognizer:tap];
        
        [self layoutSubviews];
    }
    
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews;
{
    [super layoutSubviews];
    
    // Toolbar background color
    self.barTintColor = self.backgroundColor;
    super.backgroundColor = self.backgroundColor;
    self.textLabel.textColor = self.textColor;
}

#pragma mark - Layout constraints

- (void)setUpLayoutConstraints {
    [self setUpLogoImageConstraints:self.logoImage];
    [self setUpLabelViewConstraints:self.textLabel];
}

- (void)setUpLogoImageConstraints:(UIView *)view;
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addLayoutConstraintFor:view.centerYAnchor equalTo:self.centerYAnchor];
    [self addLayoutConstraintFor:view.heightAnchor equalTo:view.widthAnchor];
    [self addLayoutConstraintFor:view.heightAnchor equalToConstant:self.logoHeight];
}

- (void)setUpLabelViewConstraints:(UIView *)view;
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGFloat offset = 6;
    
    [self addLayoutConstraintFor:view.centerYAnchor equalTo:self.centerYAnchor];
    [self addLayoutConstraintFor:view.centerXAnchor equalTo:self.centerXAnchor
                        constant:-(self.logoHeight + offset)/2];
    [self addLayoutConstraintFor:view.heightAnchor equalTo:self.heightAnchor];
    [self addLayoutConstraintFor:view.rightAnchor equalTo:self.logoImage.leftAnchor
                        constant:-offset];
}

- (CGSize)sizeThatFits:(CGSize)size;
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = self.toolbarHeight;
    
    return sizeThatFits;
}

#pragma mark - Gestures

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    NSURL *url = [[NSURL alloc] initWithString:self.siteURL];
    
    [[UIApplication sharedApplication] openURL:url];
}

@end
