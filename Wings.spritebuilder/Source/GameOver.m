//
//  GameOver.m
//  Wings
//
//  Created by Nam Trung on 11/19/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOver.h"
//#import <StoreKit/StoreKit.h>
//#import <Foundation/Foundation.h>
#import "CCTextureCache.h"

#import "AppDelegate.h"
@implementation GameOver
{
   // CCNode*  _removeAdsBtn;
    CCNode*  _gameOverLabel;
    CCNode*  _tryAgainBtn;
    CCNode*  _goToProBtn;
    BOOL _isPro;
}

- (void) Replay {
  //   [GamePlay setGameOver:false];
    [(GamePlay*)self.parent Replay];
    
   //  [[CCTextureCache sharedTextureCache] dumpCachedTextureInfo];
}

- (void) RemoveAds {
    
}


- (void)didLoadFromCCB {
  
    _isPro=true;
    
    _goToProBtn.visible=false;
    [(CCLabelTTF*) _gameOverLabel   setString:NSLocalizedString(@"GameOver", nil)];
   
    [(CCLabelTTF* ) ((CCButton*) _tryAgainBtn).label   setString:NSLocalizedString(@"TryAgain", nil)];
    ((CCLabelTTF* ) ((CCButton*) _tryAgainBtn).label).position = ccp(-10,0);

    [(CCLabelTTF* ) ((CCButton*) _goToProBtn).label   setString:NSLocalizedString(@"GoToPro", nil)];
    ((CCLabelTTF* ) ((CCButton*) _goToProBtn).label).position = ccp(-10,0);
}

@end
