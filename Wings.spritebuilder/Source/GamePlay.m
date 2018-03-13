//
//  GamePlay.m
//  Wings
//
//  Created by Nam Trung on 11/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GamePlay.h"
#import "Hero.h"
#import "Level.h"
#import "Level1.h"
#import "AppDelegate.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation GamePlay {
    
    CCNode *_Level  ;
    CCNode *_soundOn;
    CCNode *_soundOff;
    CCNode *_musicOn;
    CCNode *_musicOff;
    CCNode *_score  ;
    CCNode*_letgoLabel;
    CCNode* _playmachine;
}

static BOOL _isSoundOn=true;
static BOOL _isMusicOn=true;
static NSInteger _points;
static NSString* _backgroundSong;


+ (NSString*) getBackgroundSong
{
    return _backgroundSong;
}
+ (void) setBackgroundSong:(NSString*)value
{
    _backgroundSong=value;
}



+ (BOOL) isSoundOn
{
    return _isSoundOn;
}
+ (void) setSoundOn:(BOOL)value
{
    _isSoundOn=value;
    if(!value)
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio stopAllEffects];
    }
}

+ (BOOL) isMusicOn
{
    return _isMusicOn;
}
+ (void) setMusicOn:(BOOL)value
{
    _isMusicOn=value;
    if(!value)
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio stopBg];
    }else if(![GamePlay isGameOver])
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playBg:[GamePlay getBackgroundSong] volume:0.1f pan:0 loop:true];
    }
}

static BOOL _gameOver=false;
+ (BOOL) isGameOver
{
    return _gameOver;
}
+ (void) setGameOver:(BOOL)value
{
    _gameOver=value;
}


+ (NSInteger) getScores
{
    return _points;
}
+ (void) setScores:(NSInteger)value
{
    _points=value;
}
+ (void) increaseScores:(NSInteger)increasevalue
{
    _points+=increasevalue;
    if(GamePlay.isSoundOn )
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"ScoreSound.mp3"volume:0.3f pitch:1.f pan:0 loop:false];
    }
}
- (void) Replay {
    
    [GamePlay setGameOver:false];

    CCScene *gameplayScene = [CCBReader loadAsScene:@"GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    
    [(Level1*)_Level setScrollSpeedBG:0.f];
    [self schedule:@selector(speedUp1) interval:1.5f ];
    [self schedule:@selector(speedUp1_1) interval:1.1f ];
    if(GamePlay.isMusicOn )
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio stopEverything];
        CGFloat random=((double)arc4random() / ARC4RANDOM_MAX)*10;
        if(  random<=1)
        {
            [audio playBg:@"Intro1.mp3" volume:0.8f pan:0 loop:true];
            [GamePlay setBackgroundSong:@"Intro1.mp3"];
        }
        else if(  random<=2)
        {
            [audio playBg:@"BackGround1.mp3" volume:0.8f pan:0 loop:true];
            [GamePlay setBackgroundSong:@"BackGround1.mp3"];
        }
        else if( random<=3)
        {
            [audio playBg:@"Intro1.mp3" volume:0.8f pan:0 loop:true];
            [GamePlay setBackgroundSong:@"Intro1.mp3"];
        }else if( random<=4)
        {
            [audio playBg:@"Restart2.mp3" volume:0.8f pan:0 loop:true];
            [GamePlay setBackgroundSong:@"Restart2.mp3"];
        }else if( random<=5)
        {
            [audio playBg:@"Restart3.mp3" volume:0.8f pan:0 loop:true];
            [GamePlay setBackgroundSong:@"Restart3.mp3"];
        }else if( random<=6)
        {
            [audio playBg:@"Restart4.mp3" volume:0.8f pan:0 loop:true];
            [GamePlay setBackgroundSong:@"Restart4.mp3"];
        }else
        {
            [audio playBg:@"Intro1.mp3" volume:0.8f pan:0 loop:true];
            [GamePlay setBackgroundSong:@"Intro1.mp3"];
        }
    }
    

    
}

-(void)GoMainScreen {
    
    CCTransition *transition = [CCTransition transitionCrossFadeWithDuration:1.f];
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene withTransition:transition];
    
    if(GamePlay.isMusicOn )
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio stopEverything];
        [audio playBg:@"Start1.mp3" volume:0.8f pan:0 loop:true];
        [GamePlay setBackgroundSong:@"Start1.mp3"];
        
    }
}


- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _soundOff.visible=false;
    _musicOff.visible=false;
    [GamePlay setGameOver:false];
    
    [(CCLabelTTF*) _letgoLabel   setString:NSLocalizedString(@"LetGo", nil)];
    
    [(Level1*)_Level setScrollSpeedBG:0.f];
    
    [self schedule:@selector(speedUp1) interval:1.5f ];
    [self schedule:@selector(speedUp1_1) interval:1.1f ];
}

- (void)speedUp1{
    [(Level1*)_Level setScrollSpeedBG:130.f];
    [self unschedule:@selector(speedUp1)];
    [self schedule:@selector(speedUp2) interval:0.2f ];
}


- (void)speedUp1_1{
    if(GamePlay.isSoundOn )
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"KickOff.mp3" volume:1.f pitch:1.f pan:0 loop:false];
    }
    [self unschedule:@selector(speedUp1_1)];

}

- (void)speedUp2{
    if(GamePlay.isSoundOn )
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"SpriteSound1.mp3" volume:0.6f pitch:1.f pan:0 loop:false];
    }
     [(Level1*)_Level setScrollSpeedBG:330.f];
     [self unschedule:@selector(speedUp2)];
    [self schedule:@selector(speedUp3) interval:3.5f ];
}

- (void)speedUp3{
        [(Level1*)_Level Ready];
    [(Level1*)_Level setScrollSpeedBG:130.f];
    [self unschedule:@selector(speedUp3)];
   }

- (void)update:(CCTime)delta {
    _soundOff.visible=![GamePlay isSoundOn];
    _soundOn.visible=[GamePlay isSoundOn];
    _musicOff.visible=![GamePlay isMusicOn];
    _musicOn.visible=[GamePlay isMusicOn];
    
    if(_playmachine.visible)
    {
        _playmachine.position=ccp(_playmachine.position.x-([(Level1*)_Level getScrollSpeedBG]*delta),_playmachine.position.y);
        if(_playmachine.position.x<-100)
            _playmachine.visible=false;
    }
}
- (void) setScoreLabel
{
    [(CCLabelTTF*)_score setString:[NSString stringWithFormat:@"%d", [GamePlay getScores]]];
}

- (void) SoundOn {
    _soundOff.visible=true;    _soundOn.visible=false;
    [GamePlay setSoundOn:false];
}
- (void) SoundOff {
    _soundOff.visible=false;
    _soundOn.visible=true;
    [GamePlay setSoundOn:true];
}
- (void) MusicOn {
    _musicOff.visible=true;
    _musicOn.visible=false;
    [GamePlay setMusicOn:false];
}
- (void) MusicOff {
    _musicOff.visible=false;
    _musicOn.visible=true;
    [GamePlay setMusicOn:true];
}


- (void)gameOver {
    
    [GamePlay setGameOver:true];
    // Rest of game over logic goes here.
}

@end
