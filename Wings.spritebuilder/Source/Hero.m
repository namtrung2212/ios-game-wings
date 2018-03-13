//
//  Hero.m
//  AladdinFly
//
//  Created by Nam Trung on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Hero.h"
#import "GamePlay.h"

CGFloat heroPositionX;
CGFloat highestPositionY;

@implementation Hero
{
    NSTimeInterval _sinceTouch;
    BOOL _falldown;
    BOOL _playing;
    CCNode*_score;
}

- (void)didLoadFromCCB {
    
    heroPositionX=self.position.x;
    
    self.physicsBody.collisionType = @"hero";
    
    [self.physicsBody setCollisionCategories:[NSArray arrayWithObjects:@"hero", nil]];
    [self.physicsBody setCollisionMask:[NSArray arrayWithObjects:@"sprite", nil]];
    _sinceTouch = -1.f;
    _falldown=false;
    _playing=false;
}

-(void)Ready {
    _playing=true;
    _falldown=false;
    CGSize s = [CCDirector sharedDirector].viewSize;
    self.position=ccp(s.width*0.4f,s.height+40);
    heroPositionX=self.position.x;
    [GamePlay setGameOver:false];
    //[self.physicsBody applyImpulse:ccp(0, -550.f)];
    self.rotation =  -10.f;
    highestPositionY=-1;
}
-(BOOL)isReady {
    return _playing;
}

-(void)PushBeginHero {
    
    if(GamePlay.isSoundOn )
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"HeroSound.mp3" volume:0.2f pitch:1.f pan:0 loop:false ];
    }
    
    highestPositionY=0;
    _sinceTouch = 0.f;
    [self.physicsBody applyImpulse:ccp(0, 100.f)];

}


-(void)PushEndHero {
    _sinceTouch = -1.f;
}

-(void)ActionFallDown {
    _sinceTouch = -1.f;
    _falldown=true;
    
    CCBAnimationManager* animationManager = self.userObject;
    [animationManager runAnimationsForSequenceNamed:@"Falling"];
    [self.physicsBody applyImpulse:ccp(0, -5.f)];
    //  [self.physicsBody applyAngularImpulse:4000.f];
    
    if(GamePlay.isSoundOn )
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio playEffect:@"SpriteSound1.mp3" volume:0.6f pitch:1.f pan:0 loop:false];
    }
    
    
}


- (void)update:(CCTime)delta {
    self.position = ccp(heroPositionX, self.position.y);
    
    if(_playing)
    {
        if(!_falldown)
        {
            [GamePlay setGameOver:false];
            [self UpdateAladdinFly:delta];
            
        }
        else
        {
            [GamePlay setGameOver:true];
            [self UpdateHeroFalldown:delta];
            
        }
    }
}



- (void)UpdateHeroFalldown:(CCTime)delta {
    self.position = ccp(heroPositionX, self.position.y);
    self.rotation = clampf(self.rotation, -10.f, 10.f);
    if (self.physicsBody.allowsRotation) {
        float angularVelocity = clampf(self.physicsBody.angularVelocity, -2.f, 1.f);
        self.physicsBody.angularVelocity = angularVelocity;
    }
    
    [self.physicsBody applyImpulse:ccp(0, -5.f)];
    [self.physicsBody applyAngularImpulse:0.f];
    if (self.position.y <75)
    {
        CCBAnimationManager* animationManager = self.userObject;
        if(![animationManager.runningSequenceName isEqualToString:@"Falled"]&&![animationManager.lastCompletedSequenceName isEqualToString:@"Falled"])
        {
            if(GamePlay.isSoundOn)
            {
                OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
                [audio playEffect:@"Falled.mp3" volume:1.5f pitch:1.f pan:0 loop:false];
            }
            [(CCLabelTTF*)_score setString:[NSString stringWithFormat:@"%d", [GamePlay getScores]]];
            [animationManager runAnimationsForSequenceNamed:@"Falled"];
        }
    }
    
}

- (void)UpdateAladdinFly:(CCTime)delta {
    float yVelocity = clampf(self.physicsBody.velocity.y, -1 * MAXFLOAT, 200.f);
    self.physicsBody.velocity = ccp(0, yVelocity);
    self.position = ccp(heroPositionX, self.position.y);
    
    
    self.rotation = clampf(self.rotation, -10.f, 10.f);
    if (self.physicsBody.allowsRotation) {
        float angularVelocity = clampf(self.physicsBody.angularVelocity, -2.f, 1.f);
        self.physicsBody.angularVelocity = angularVelocity;
    }
    
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    if (self.position.y >s.height) {
        self.position = ccp(self.position.x, s.height);
        [self.physicsBody applyImpulse:ccp(0, -100.f)];
        [self.physicsBody applyAngularImpulse:0.f];
        
    }else if (self.position.y <65) {
        self.position = ccp(self.position.x, 65);
        [self.physicsBody applyImpulse:ccp(0, 100.f)];
        [self.physicsBody applyAngularImpulse:0.f];
    }else
    {
        if(_sinceTouch>=0)
            _sinceTouch += delta;
        
        if(_sinceTouch>=0)
        {
            [self.physicsBody applyImpulse:ccp(0, 40.f)];
            [self.physicsBody applyAngularImpulse:1000.f];
        }
    }
    
    if (highestPositionY<self.position.y )
        highestPositionY=self.position.y;
    
    if(self.position.y<highestPositionY  && self.position.y<150.f )
        self.rotation = clampf(self.rotation, -10.f, 0.f);

}

@end
