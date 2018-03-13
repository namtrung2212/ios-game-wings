//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "GamePlay.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation MainScene
{
     CCNode *_startButton  ;
    CCNode *_developedByLabel;
    
}
- (void)play {
    
    
    CCLOG(@"play button pressed");

    CCTransition *transition = [CCTransition transitionCrossFadeWithDuration:1.f];
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene withTransition:transition];
    [GamePlay setGameOver:false];
    
    if(GamePlay.isMusicOn )
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio stopEverything];
        if( ((double)arc4random() / ARC4RANDOM_MAX)*2 <=1)
        {
            [audio playBg:@"Intro1.mp3" volume:0.8f pan:0 loop:true];
            [GamePlay setBackgroundSong:@"Intro1.mp3"];
        }
        else
        {
            [audio playBg:@"BackGround1.mp3" volume:0.8f pan:0 loop:true];
            [GamePlay setBackgroundSong:@"BackGround1.mp3"];
        }
    }
}

- (void)didLoadFromCCB {
    
    [(CCLabelTTF* ) ((CCButton*) _startButton).label   setString:NSLocalizedString(@"Start", nil)];
  //  ((CCLabelTTF* ) ((CCButton*) _startButton).label).position = ccp(-5,0);

    [((CCLabelTTF* ) _developedByLabel)  setString:NSLocalizedString(@"DevBy", nil)];
    
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio setEffectsVolume:0.5f];
    [audio setBgVolume:0.8f];
    
    [audio preloadEffect:@"Collision1.mp3"];
    [audio preloadEffect:@"Intro1.mp3"];
    if(GamePlay.isMusicOn )
    {
        [audio stopEverything];
        [audio playBg:@"Start1.mp3" volume:0.8f pan:0 loop:true];
        [GamePlay setBackgroundSong:@"Start1.mp3"];
    }
    
    
  

}
@end