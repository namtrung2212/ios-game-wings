//
//  Level1.m
//  Wings
//
//  Created by Nam Trung on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Level1.h"
#import "Hero.h"
#import "CCTextureCache.h"
static const CGFloat firstSpritePosition = 280.f;

typedef NS_ENUM (NSInteger, DrawingOrder) {
    DrawingOrderSprites,
    DrawingOrderGround,
    DrawingOrdeHero
};


@implementation Level1
{
    CCPhysicsNode *_physicsGameNode;
    Hero *_hero;
    
    CCNode *_ground1;
    CCNode *_ground2;
    CCNode *_ground3;
    CCNode *_ground4;
    CCNode *_ground5;
    CCNode *_ground6;
    CCNode *_ground7;
    
    CCNode *_groundMountain0_1;
    CCNode *_groundMountain0_2;
    
    CCNode *_groundMountain1_1;
    CCNode *_groundMountain1_2;
    
    CCNode *_groundMountain2_1;
    CCNode *_groundMountain2_2;
    
    NSMutableArray *_sprites;
    NSMutableArray *_groundSprites;
    NSMutableArray *_sheeps;

    CGFloat _scrollSpeedBG;
    CGFloat _scrollSpeedGround0;
    CGFloat _scrollSpeedGround1;
    CGFloat _scrollSpeedGround2;
    
    CCLabelTTF *_scoreLabel;
    CCSprite* bom;
}

- (CGFloat) getScrollSpeedBG {
    return _scrollSpeedBG;
}
- (void) setScrollSpeedBG:(CGFloat) value
{
    _scrollSpeedBG=value;
    if(_scrollSpeedBG<0)
        _scrollSpeedBG=0;
    
    _scrollSpeedGround0 = _scrollSpeedBG-30.f;
    if(_scrollSpeedGround0<0)
        _scrollSpeedGround0=0;
    
    _scrollSpeedGround1 = _scrollSpeedBG-80.f;
    if(_scrollSpeedGround1<0)
        _scrollSpeedGround1=0;
    
    _scrollSpeedGround2 = _scrollSpeedBG-110.f;
    if(_scrollSpeedGround2<0)
        _scrollSpeedGround2=0;
}
- (void)didLoadFromCCB {
    
    [GamePlay setScores:0];
    [(GamePlay*) self.parent setScoreLabel];
   
    [self setScrollSpeedBG:0.f];
    
    self.userInteractionEnabled = TRUE;

    _ground2.position = ccp(_ground1.position.x +_ground1.contentSize.width, _ground1.position.y);
    _ground3.position = ccp(_ground2.position.x +_ground2.contentSize.width, _ground2.position.y);
    _ground4.position = ccp(_ground3.position.x +_ground3.contentSize.width, _ground3.position.y);
    _ground5.position = ccp(_ground4.position.x +_ground4.contentSize.width, _ground4.position.y);
    _ground6.position = ccp(_ground5.position.x +_ground5.contentSize.width, _ground5.position.y);
    _ground7.position = ccp(_ground6.position.x +_ground6.contentSize.width, _ground6.position.y);
    
    _groundMountain0_2.position = ccp(_groundMountain0_1.position.x +_groundMountain0_1.contentSize.width, _groundMountain0_1.position.y);
    _groundMountain1_2.position = ccp(_groundMountain1_1.position.x +_groundMountain1_1.contentSize.width, _groundMountain1_1.position.y);
    _groundMountain2_2.position = ccp(_groundMountain2_1.position.x +_groundMountain2_1.contentSize.width, _groundMountain2_1.position.y);

    _physicsGameNode.collisionDelegate = self;

    _sprites = [NSMutableArray array];
    _groundSprites= [NSMutableArray array];

    _sheeps= [NSMutableArray array];
    
    _hero.scaleX=0.35f;
    _hero.scaleY=0.35f;
    _hero.position=ccp(0.35f,_hero.position.y);
    _hero.visible=false;
    [GamePlay setGameOver:false];
    
    id delayAction = [CCActionInterval actionWithDuration:14.f];
    CCAction * genSprite = [CCActionCallFunc actionWithTarget:self selector:@selector(genNewSprites)];
    [self runAction:[CCActionSequence actions: delayAction, genSprite, nil]];

    id delayAction2 = [CCActionInterval actionWithDuration:11.f];
    CCAction * genGroundSprite = [CCActionCallFunc actionWithTarget:self selector:@selector(genNewGroundSprites)];
    [self runAction:[CCActionSequence actions: delayAction2, genGroundSprite, nil]];
    
    id delayAction3 = [CCActionInterval actionWithDuration:11.f];
    CCAction * genSheeps = [CCActionCallFunc actionWithTarget:self selector:@selector(genNewSheeps)];
    [self runAction:[CCActionSequence actions: delayAction3, genSheeps, nil]];
    
    [GamePlay setGameOver:false];

}
-(void)Ready {
    [_hero Ready];
    CGSize s = [CCDirector sharedDirector].viewSize;
    _hero.position=ccp(s.width*0.4f,s.height+40);
    _hero.visible=true;
}
-(BOOL)isReady {
    return [_hero isReady];
}

- (void)genNewSheeps {
    
    if(_sheeps.count<4)
    {
        CCNode* sheep= (CCNode*)[CCBReader load:@"Sprites/Sheep"];
        sheep.position=ccp([CCDirector sharedDirector].viewSize.width +50,30);
        sheep.scaleX=-1.5f;
        sheep.scaleY=1.5f;

        [self addChild:sheep];
        [_sheeps addObject:sheep];
        
    }
    
}


- (void)genNewGroundSprites {
    
    if(_groundSprites.count<2 && [_hero isReady])
    {
        NTSpriteObject *sprite1 = (NTSpriteObject *)[NTSpriteObject GenRandomSprite: 0];
        
        [_physicsGameNode addChild:sprite1];
        [_groundSprites addObject:sprite1];
        
    }
    
}


- (int)getMaxSprites {
    
    if([GamePlay getScores]<30)
        return 2;
    
    if([GamePlay getScores]<60)
        return 3;

    if([GamePlay getScores]<100)
        return 4;
 
    return 5;
}

- (void)genNewSprites {
  
    if(_sprites.count<[self getMaxSprites]  && [_hero isReady])
    {
        NTSpriteObject *sprite1 = (NTSpriteObject *)[NTSpriteObject GenRandomSprite: _hero.position.y];
        
        [_physicsGameNode addChild:sprite1];
        [_sprites addObject:sprite1];
        
        if(_sprites.count<=[self getMaxSprites])
        {
            id delayAction = [CCActionInterval actionWithDuration:2.f];
            CCAction * genSprite2 = [CCActionCallFunc actionWithTarget:self selector:@selector(genNewSprite2)];
            [self runAction:[CCActionSequence actions: delayAction, genSprite2, nil]];
        }
    }
    
}


- (void)genNewSprite2 {
    
    if(_sprites.count<=[self getMaxSprites] && [_hero isReady])
    {
        CGSize s = [CCDirector sharedDirector].viewSize;
        CGFloat sprite2PosY=_hero.position.y;
        if (sprite2PosY>s.height/2 ) {
            sprite2PosY-=150;
        }else
        {
            sprite2PosY+=150;

        }
        
        NTSpriteObject *sprite2 = (NTSpriteObject *)[NTSpriteObject GenRandomSprite: sprite2PosY];
        
        [_physicsGameNode addChild:sprite2];
        [_sprites addObject:sprite2];
      
    }
}


- (void)update:(CCTime)delta {
   
    [self updateGrounds:delta];
    
    [self updateSprites:delta];
    
    [self updateGroundSprites:delta];
    
    [self updateSheeps:delta];
}


- (void)updateSheeps:(CCTime)delta {
    NSMutableArray *offScreenSheeps = nil;
    
    for (CCNode* sheep in _sheeps) {
        
        sheep.position = ccp(sheep.position.x - ((_scrollSpeedBG+20) *delta), sheep.position.y);
        
        CGPoint spriteWorldPos = [self convertToWorldSpace:sheep.position];
        CGPoint spriteScreenPos = [self convertToNodeSpace:spriteWorldPos];
        if (spriteScreenPos.x < -sheep.contentSize.width-100) {
            if (!offScreenSheeps) {
                offScreenSheeps = [NSMutableArray array];
            }
            [offScreenSheeps addObject:sheep];
        }
    }
    
    for (CCNode *sheepToRemove in offScreenSheeps) {
        [sheepToRemove removeFromParent];
        [_sheeps removeObject:sheepToRemove];
        [self genNewSheeps];
    }
    
}
- (void)updateGrounds:(CCTime)delta {
     if([GamePlay isGameOver])
     {
         if(_scrollSpeedBG>=1)
            [self setScrollSpeedBG:_scrollSpeedBG-1];
     }
    
    if(_scrollSpeedBG>0)
    {
         if(_scrollSpeedBG>0)
         {
             _ground1.position = ccp(_ground1.position.x - (_scrollSpeedBG *delta), _ground1.position.y);
             _ground2.position = ccp(_ground2.position.x - (_scrollSpeedBG *delta), _ground2.position.y);
             _ground3.position = ccp(_ground3.position.x - (_scrollSpeedBG *delta), _ground3.position.y);
             _ground4.position = ccp(_ground4.position.x - (_scrollSpeedBG *delta), _ground4.position.y);
             _ground5.position = ccp(_ground5.position.x - (_scrollSpeedBG *delta), _ground5.position.y);
             _ground6.position = ccp(_ground6.position.x - (_scrollSpeedBG *delta), _ground6.position.y);
             _ground7.position = ccp(_ground7.position.x - (_scrollSpeedBG *delta), _ground7.position.y);
             
             if (_ground1.position.x <= (-1 * _ground1.contentSize.width)) {
                 _ground1.position = ccp(_ground7.position.x+ _ground7.contentSize.width, _ground1.position.y);
             }
             if (_ground2.position.x <= (-1 * _ground2.contentSize.width)) {
                 _ground2.position = ccp(_ground1.position.x+ _ground1.contentSize.width, _ground2.position.y);
             }
             if (_ground3.position.x <= (-1 * _ground3.contentSize.width)) {
                 _ground3.position = ccp(_ground2.position.x+ _ground2.contentSize.width, _ground3.position.y);
             }
             if (_ground4.position.x <= (-1 * _ground4.contentSize.width)) {
                 _ground4.position = ccp(_ground3.position.x+ _ground3.contentSize.width, _ground4.position.y);
             }
             if (_ground5.position.x <= (-1 * _ground5.contentSize.width)) {
                 _ground5.position = ccp(_ground4.position.x+ _ground4.contentSize.width, _ground5.position.y);
             }
             if (_ground6.position.x <= (-1 * _ground6.contentSize.width)) {
                 _ground6.position = ccp(_ground5.position.x+ _ground5.contentSize.width, _ground6.position.y);
             }
             if (_ground7.position.x <= (-1 * _ground7.contentSize.width)) {
                 _ground7.position = ccp(_ground6.position.x+ _ground6.contentSize.width, _ground7.position.y);
             }
             
         }
        
        if(_scrollSpeedGround0>0)
        {
            _groundMountain0_1.position = ccp(_groundMountain0_1.position.x - (_scrollSpeedGround0 *delta), _groundMountain0_1.position.y);
            _groundMountain0_2.position = ccp(_groundMountain0_2.position.x - (_scrollSpeedGround0 *delta), _groundMountain0_2.position.y);
           
            if (_groundMountain0_1.position.x <= (-1 * _groundMountain0_1.contentSize.width)) {
                _groundMountain0_1.position = ccp(_groundMountain0_2.position.x+ _groundMountain0_2.contentSize.width, _groundMountain0_1.position.y);
            }
            if (_groundMountain0_2.position.x <= (-1 * _groundMountain0_2.contentSize.width)) {
                _groundMountain0_2.position = ccp(_groundMountain0_1.position.x+ _groundMountain0_1.contentSize.width, _groundMountain0_2.position.y);
            }
            
        }
       
        if(_scrollSpeedGround1>0)
        {

            _groundMountain1_1.position = ccp(_groundMountain1_1.position.x - (_scrollSpeedGround1 *delta), _groundMountain1_1.position.y);
            _groundMountain1_2.position = ccp(_groundMountain1_2.position.x - (_scrollSpeedGround1 *delta), _groundMountain1_2.position.y);
            
            if (_groundMountain1_1.position.x <= (-1 * _groundMountain1_1.contentSize.width)) {
                _groundMountain1_1.position = ccp(_groundMountain1_2.position.x+ _groundMountain1_2.contentSize.width, _groundMountain1_1.position.y);
            }
            if (_groundMountain1_2.position.x <= (-1 * _groundMountain1_2.contentSize.width)) {
                _groundMountain1_2.position = ccp(_groundMountain1_1.position.x+ _groundMountain1_1.contentSize.width, _groundMountain1_2.position.y);
            }
            
        }
        
        if(_scrollSpeedGround2>0)
        {
            _groundMountain2_1.position = ccp(_groundMountain2_1.position.x - (_scrollSpeedGround2 *delta), _groundMountain2_1.position.y);
            _groundMountain2_2.position = ccp(_groundMountain2_2.position.x - (_scrollSpeedGround2 *delta), _groundMountain2_2.position.y);
        
            if (_groundMountain2_1.position.x <= (-1 * _groundMountain2_1.contentSize.width)) {
                _groundMountain2_1.position = ccp(_groundMountain2_2.position.x+ _groundMountain2_2.contentSize.width, _groundMountain2_1.position.y);
            }
            if (_groundMountain2_2.position.x <= (-1 * _groundMountain2_2.contentSize.width)) {
                _groundMountain2_2.position = ccp(_groundMountain2_1.position.x+ _groundMountain2_1.contentSize.width, _groundMountain2_2.position.y);
            }
        }
    }
}

- (void)updateSprites:(CCTime)delta {
    NSMutableArray *offScreenSprites = nil;
    
    for (NTSpriteObject* sprite in _sprites) {
        
        sprite.position = ccp(sprite.position.x - (sprite.Speed *delta), sprite.position.y);
        
        CGPoint spriteWorldPos = [_physicsGameNode convertToWorldSpace:sprite.position];
        CGPoint spriteScreenPos = [self convertToNodeSpace:spriteWorldPos];
        if (spriteScreenPos.x < -sprite.contentSize.width) {
            if (!offScreenSprites) {
                offScreenSprites = [NSMutableArray array];
            }
            [offScreenSprites addObject:sprite];
        }
    }
    
    for (CCNode *spriteToRemove in offScreenSprites) {
        [spriteToRemove removeFromParent];
        [_sprites removeObject:spriteToRemove];
        [self genNewSprites];
        if(![GamePlay isGameOver])
        {
            [GamePlay increaseScores:1];
            [(GamePlay*) self.parent setScoreLabel];
        }
    }
}

- (void)updateGroundSprites:(CCTime)delta {
    NSMutableArray *offScreenSprites = nil;
    
    for (NTSpriteObject* sprite in _groundSprites) {
        
        sprite.position = ccp(sprite.position.x - (sprite.Speed *delta), sprite.position.y);
        
      //  if(sprite.position.x<s.
        CGPoint spriteWorldPos = [_physicsGameNode convertToWorldSpace:sprite.position];
        CGPoint spriteScreenPos = [self convertToNodeSpace:spriteWorldPos];
        if (spriteScreenPos.x < -sprite.contentSize.width) {
            if (!offScreenSprites) {
                offScreenSprites = [NSMutableArray array];
            }
            [offScreenSprites addObject:sprite];
        }
    }
    
    for (CCNode *spriteToRemove in offScreenSprites) {
        [spriteToRemove removeFromParent];
        [_groundSprites removeObject:spriteToRemove];
        [self genNewGroundSprites];
    }
}




- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (![GamePlay isGameOver]) {
        [_hero PushBeginHero];
    }
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (![GamePlay isGameOver]) {
        [_hero PushEndHero];
    }
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair hero:(CCNode *)hero sprite:(CCNode *)sprite {

    if(![GamePlay isGameOver])
    {
        
        [(Hero*)hero ActionFallDown];
        [self gameOver];

        
        bom= (CCSprite*)[CCBReader load:@"Sprites/Sprite69"];
        [_physicsGameNode addChild:bom];
        bom.position=sprite.position;
        bom.scaleX=2.f;
        bom.scale=2.f;
    
        if(GamePlay.isSoundOn )
        {
            OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
            [audio playEffect:@"Explore.mp3" volume:2.f pitch:1.f pan:0 loop:false ];
        }
        
        id delayAction = [CCActionInterval actionWithDuration:0.6f];
        CCAction * removebom = [CCActionCallFunc actionWithTarget:self selector:@selector(removeBom)];
        [bom runAction:[CCActionSequence actions: delayAction, removebom, nil]];
        
        [sprite removeFromParentAndCleanup:YES];
        
    }
    return YES;
}

-(void) removeBom
{
    [bom removeFromParentAndCleanup:YES];
}

-(void) gameOver
{
    [GamePlay setGameOver:true];
    
    id delayAction = [CCActionInterval actionWithDuration:4.f];
    CCAction * showGameOver = [CCActionCallFunc actionWithTarget:self selector:@selector(showGameOver)];
    [self   runAction:[CCActionSequence actions: delayAction, showGameOver, nil]];
    
}
-(void) showGameOver
{
    
    CCNode* gameover = (CCNode*)[CCBReader load:@"GameOver"];
    [self.parent addChild:gameover];
    [(GamePlay*)self.parent gameOver];
    
    if(GamePlay.isMusicOn )
    {
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        [audio stopEverything ];
        [audio playEffect:@"Restart1.mp3"volume:1.f pitch:1.f pan:0 loop:false ];;
    }
}


@end
