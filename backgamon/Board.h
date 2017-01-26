//
//  Board.h
//  backgamon
//
//  Created by maxeler on 1/22/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriangleView.h"
#import "CircleView.h"

@protocol BoardWon <NSObject>

-(void)player:(NSUInteger)player won:(NSUInteger)won;

@end

@interface Board : UIView <CircleMoveDelegate>

@property NSMutableArray<TriangleView*> *board;

@property BOOL useRedBot;
@property BOOL useWhiteBot;
@property NSInteger redBotDeapth;
@property NSInteger whiteBotDeapth;

@property NSMutableArray *diceNumbers;
@property NSMutableArray *eaten;
@property NSMutableArray<NSMutableArray<UIView *> *> *finished;
@property NSInteger player;

@property id<BoardWon> delegate;

- (void)dicesDidLandOnNumbers:(NSMutableArray *)numbers;
- (void)layoutCirclesAnimated:(BOOL)animated;

@end
