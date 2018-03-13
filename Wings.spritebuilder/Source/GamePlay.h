//
//  GamePlay.h
//  Wings
//
//  Created by Nam Trung on 11/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"


@interface GamePlay : CCNode

-(void)GoMainScreen ;
- (void) Replay ;

- (void) setScoreLabel;

+ (BOOL) isSoundOn;
+ (void) setSoundOn:(BOOL)value;

+ (BOOL) isMusicOn;
+ (void) setMusicOn:(BOOL)value;


+ (BOOL) isGameOver;
+ (void) setGameOver:(BOOL)value;

+ (NSInteger) getScores;
+ (void) setScores:(NSInteger)value;

+ (void) increaseScores:(NSInteger)increasevalue;

+ (NSString*) getBackgroundSong;
+ (void) setBackgroundSong:(NSString*)value;


- (void)gameOver ;

@end
