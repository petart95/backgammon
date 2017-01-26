//
//  Bot.m
//  backgamon
//
//  Created by maxeler on 1/23/17.
//  Copyright © 2017 maxeler. All rights reserved.
//

#import "Bot.h"

#define RED 0
#define WHITE 1


@implementation Bot

#pragma mark - Bot

+ (NSInteger)sign:(BOOL)player;
{
    if(player == WHITE)
        return -1;
    
    return 1;
}

+ (NSInteger)player:(NSInteger)sign;
{
    if(sign == -1)
        return WHITE;
    
    return RED;
}

+ (NSMutableDictionary *)getMoveForPlayer:(NSInteger)player withBoard:(NSMutableArray *)board dices:(NSMutableArray *)dices
                                    first:(NSInteger)first depth:(NSInteger)depth alpha:(CGFloat)alpha beta:(CGFloat)beta playAgain:(BOOL)playAgain;
{
    if(depth == 0) {
        return [NSMutableDictionary dictionaryWithDictionary: @{@"value" : @([self getValueForPlayer:first withBoard:board]),
                 @"type" : @"NODE"}];
    }
    
    NSMutableArray *moves = [self getPosibleMovesForPlayer:player withBoard:board dices:dices first:first];
    
    if([moves count] == 0) {
        CGFloat value = 0;
        for(NSUInteger i = 1; i <= 6; i++) {
            for(NSUInteger j = 1; j <= 6; j++) {
                @autoreleasepool {
                    NSMutableArray *dice  = [NSMutableArray arrayWithArray:@[@(i), @(j)]];
                    NSMutableDictionary *dic= [self getMoveForPlayer:playAgain ? player : !player withBoard:board dices:dice
                                                               first:first depth:depth-1 alpha:alpha beta:beta playAgain:NO];
                    value += [dic[@"value"] floatValue];
                }
            }
        }
        
        return [NSMutableDictionary dictionaryWithDictionary: @{@"value" : @(value/36),
                 @"type"  : @"EXP"}];
    }
    
    if([ dices count] == 2) {
        playAgain = [dices[0] isEqual:dices[1]];
    }
    
    CGFloat minmax = player == first ? -1000000 : 1000000;
    NSMutableDictionary *minmaxMove;
    for(NSMutableDictionary *move in moves) {
        CGFloat value;
        @autoreleasepool {
            NSMutableArray *dice = [dices mutableCopy];
            NSInteger index = [dice indexOfObject:move[@"dice"]];
            [dice removeObjectAtIndex:index];
            value = [[self getMoveForPlayer:player withBoard:[self applayMove:move toBoard:board] dices:dice
                                      first:first depth:depth-1 alpha:alpha beta:beta playAgain:playAgain][@"value"] doubleValue];
        }
        
        if((player == first && minmax < value) ||
           (player != first && minmax > value)) {
            minmaxMove = move;
        }
        
        if(player == first) {
            minmax = MAX(value, minmax);
            alpha = MAX(value, alpha);
        } else {
            minmax = MIN(value, minmax);
            beta = MIN(value, alpha);
        }
        
        if(beta <= alpha) {
            break;
        }
    }
    
    minmaxMove[@"value"] = @(minmax);
    minmaxMove[@"type"] = first == player ? @"MAX" : @"MIN";
    
    return minmaxMove;
}

+ (NSMutableArray *)getPosibleMovesForPlayer:(NSInteger)player withBoard:(NSMutableArray *)board dices:(NSMutableArray *)dices first:(NSInteger)first;
{
    NSMutableArray *moves = [NSMutableArray new];
    
    NSInteger direction = player == RED ? 1 : -1;
    
    if([board[24 + player] intValue] != 0) {
        NSInteger index = player == RED ? -1 : 24;
        for(NSNumber *number in dices) {
            NSInteger i = direction * [number intValue] + index;
            if(i < 24 && i >= 0 &&
               (ABS([board[i] intValue]) <= 1 || [board[i] intValue] * [self sign:player] >= 0)) {
                [moves addObject:[NSMutableDictionary dictionaryWithDictionary: @{
                                                                                  @"from" : @(24+player),
                                                                                  @"to"   : @(i),
                                                                                  @"dice" : number,
                                                                                  }]];
            }
        }
        
        return moves;
    }
    
    NSInteger numberOfRed = [board[26+RED] intValue];
    for(NSInteger i=18;i<24;i++){
        if([board[i] intValue] > 0) {
            numberOfRed += [board[i] intValue];
        }
    }
    
    NSInteger numberOfWhite = [board[26+WHITE] intValue];
    for(NSInteger i=0;i<6;i++){
        if([board[i] intValue] < 0) {
            numberOfWhite -= [board[i] intValue];
        }
    }
    
    for(NSInteger index = 0; index < 24; index++) {
        if([board[index] intValue] * [self sign:player] <= 0) continue;
        
        for(NSNumber *number in dices) {
            NSInteger i = direction * [number intValue] + index;
            if((i < 24 && i >= 0 &&
               (ABS([board[i] intValue]) <= 1 || [board[i] intValue] * [self sign:player] >= 0))
               || (i>=24 && player == RED && numberOfRed == 15)
               || (i<0 && player == WHITE && numberOfWhite == 15)) {
                   [moves addObject:[NSMutableDictionary dictionaryWithDictionary: @{
                                                                                     @"from" : @(index),
                                                                                     @"to"   : @(i),
                                                                                     @"dice" : number,
                                                                                     }]];
            }
        }
    }
    
    return moves;
}

+ (NSMutableArray *)applayMove:(NSMutableDictionary *)move toBoard:(NSMutableArray *) board;
{
    NSMutableArray *newBoard = [board mutableCopy];
    
    if([move[@"to"] intValue] < 24 && [move[@"to"] intValue] >= 0) {
        NSInteger fromSign = [self signOfInteger:[board[[move[@"from"] intValue]] intValue]];
        NSInteger toSign = [self signOfInteger:[board[[move[@"to"] intValue]] intValue]];
        
        newBoard[[move[@"from"] intValue]] = @([board[[move[@"from"] intValue]] intValue] - fromSign);
        
        if([board[[move[@"to"] intValue]] intValue] == 1 && fromSign != toSign) {
            newBoard[24 + [self player:toSign]] = @(toSign);
        }
        
        newBoard[[move[@"to"] intValue]] = @([board[[move[@"to"] intValue]] intValue] + [self signOfInteger:[board[[move[@"from"] intValue]] intValue]]);
    } else if([move[@"to"] intValue] > 24) {
        newBoard[26+RED] = @([newBoard[26+RED] intValue]+1);
        newBoard[[move[@"from"] intValue]] = @([newBoard[[move[@"from"] intValue]] intValue] - 1);
    } else if([move[@"to"] intValue] < 0) {
        newBoard[26+WHITE] = @([newBoard[26+WHITE] intValue]+1);
        newBoard[[move[@"from"] intValue]] = @([newBoard[[move[@"from"] intValue]] intValue] + 1);
    }
    
    return newBoard;
}

+ (int)signOfInteger:(int)integer {
    
    return (integer > 0) - (integer < 0);
    
}

+ (CGFloat)getValueForPlayer:(NSInteger)player withBoard:(NSMutableArray *)board;
{
    CGFloat value = 0;
    
    if(player == RED) {
        for(int i=0;i<6;i++) {
            if([board[i] intValue] * [self sign:player] > 0) {
                value -=25*(24-i) * [board[i] intValue];
                
                if([board[i] intValue] == 1)
                    value -= 20;
            } else {
                if([board[i] intValue] == -1)
                    value += 5;
            }
        }
        for(int i=6;i<12;i++) {
            if([board[i] intValue] * [self sign:player] > 0) {
                value -=25* [board[i] intValue];
                
                if([board[i] intValue] == 1)
                    value -= 20;
            } else {
                if([board[i] intValue] == -1)
                    value += 10;
            }
        }
        for(int i=12;i<18;i++) {
            if([board[i] intValue] * [self sign:player] > 0) {
                value -=10* [board[i] intValue];
                
                if([board[i] intValue] == 1)
                    value -= 20;
            } else {
                if([board[i] intValue] == -1)
                    value += 10;
            }
        }
        for(int i=18;i<24;i++) {
            if([board[i] intValue] * [self sign:player] > 0) {
                value += 5 * [board[i] intValue];
                
                if([board[i] intValue] == 1)
                    value -= 100;
            } else {
                if([board[i] intValue] == -1)
                    value += 15;
            }
        }
        value += 500 * [board[24+WHITE] intValue];
        value -= 500 * [board[24+RED] intValue];
        value += 100 * [board[26+RED] intValue];
    } else {
        for(int i=18;i<24;i++) {
            if([board[i] intValue] * [self sign:player] > 0) {
                value +=25*i * [board[i] intValue];
                
                if([board[i] intValue] == -1)
                    value -= 20;
            } else {
                if([board[i] intValue] == 1)
                    value += 5;
            }
        }
        for(int i=12;i<18;i++) {
            if([board[i] intValue] * [self sign:player] > 0) {
                value +=25 * [board[i] intValue];
                
                if([board[i] intValue] == -1)
                    value -= 20;
            } else {
                if([board[i] intValue] == 1)
                    value += 10;
            }
        }
        for(int i=6;i<12;i++) {
            if([board[i] intValue] * [self sign:player] > 0) {
                value +=5 * [board[i] intValue];
                
                if([board[i] intValue] == -1)
                    value -=20;
            } else {
                if([board[i] intValue] == 1)
                    value += 10;
            }
        }
        for(int i=0;i<6;i++) {
            if([board[i] intValue] * [self sign:player] > 0) {
                value -= 10 * [board[i] intValue];
                
                if([board[i] intValue] == -1)
                    value -= 100;
            } else {
                if([board[i] intValue] == 1)
                    value += 15;
            }
        }
        value -= 500 * [board[24+WHITE] intValue];
        value += 500 * [board[24+RED] intValue];
        value += 100 * [board[26+WHITE] intValue];
    }
    
    return value;
}

@end
