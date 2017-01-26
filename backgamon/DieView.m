//
//  DieView.m
//  DiceRoll
//
//  Created by Christopher Ching on 2013-09-19.
//  Copyright (c) 2013 CodeWithChris. All rights reserved.
//

#import "DieView.h"

@implementation DieView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.dieImage = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.dieImage];
        
        CGRect frame = self.bounds;
        frame.size.width -= 5;
        frame.size.height -= 5;
        
        self.dimView = [[UIView alloc] initWithFrame:frame];
        self.dimView.layer.cornerRadius = 13;
        [self addSubview:self.dimView];
    }
    
    return self;
}

- (void)showDieNumber:(int)num
{
    // Constructing the filename based on the die number
    NSString *fileName = [NSString stringWithFormat:@"dice%d.png", num];
    // Setting the uiimageview to the appropriate image
    self.dieImage.image = [UIImage imageNamed:fileName];
}

@end
