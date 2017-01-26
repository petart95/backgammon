//
//  GraphViewController.h
//  backgamon
//
//  Created by maxeler on 1/23/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "Bot.h"

@interface GraphViewController : UIViewController

@property NSMutableDictionary *root;
@property NSMutableArray *children;

@end
