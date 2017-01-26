//
//  Bot.h
//  backgamon
//
//  Created by maxeler on 1/23/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Bot : NSObject

+ (NSMutableDictionary *)getMoveForPlayer:(NSInteger)player withBoard:(NSMutableArray *)board dices:(NSMutableArray *)dices
                                    first:(NSInteger)first depth:(NSInteger)depth alpha:(CGFloat)alpha beta:(CGFloat)beta playAgain:(BOOL)playAgain;

+ (CGFloat)getValueForPlayer:(NSInteger)player withBoard:(NSMutableArray *)board;


+ (NSMutableArray *)getPosibleMovesForPlayer:(NSInteger)player withBoard:(NSMutableArray *)board dices:(NSMutableArray *)dices first:(NSInteger)first;

+ (NSMutableArray *)applayMove:(NSMutableDictionary *)move toBoard:(NSMutableArray *) board;

@end
