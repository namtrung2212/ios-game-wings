//
//  NTSpriteObject.m
//  Wings
//
//  Created by Nam Trung on 11/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//
#import "GamePlay.h"
#import "NTSpriteObject.h"

@implementation NTSpriteObject
{
    
    CGFloat _speed;
    CGFloat MaxStartSpriteX ;
    NSString* _spriteObjectName;
}


static NSString* _lastSpriteName;

+ (NSString*) getLastSpriteName
{
    return _lastSpriteName;
}
+ (void) setLastSpriteName:(NSString*)value
{
    _lastSpriteName=value;
}



- (NSString*) getSpriteName
{
    return  _spriteObjectName;
}
- (void) setSpriteName:(NSString*)value
{
    _spriteObjectName = value;
}


-(CGFloat)Speed
{
    return _speed;
}

-(void) SetSpeed:(CGFloat)value
{
    _speed=value;
}

#define ARC4RANDOM_MAX      0x100000000


static const CGFloat minimumYPosition = 128.f;

- (void)didLoadFromCCB {
    
    MaxStartSpriteX = 100.f;
    
    self.physicsBody.collisionType = @"sprite";
    self.physicsBody.sensor = YES;
    _speed=80.f;
    
    [self.physicsBody setCollisionCategories:[NSArray arrayWithObjects:@"sprite", nil]];
    [self.physicsBody setCollisionMask:[NSArray arrayWithObjects:@"hero", nil]];
    
    [self.physicsBody setDensity:1.f];
}


+ (NTSpriteObject*) GenRandomSprite:(CGFloat) heroPosY
{
   
    NSString* spriteName;
    NSString* lastSpriteName=[NTSpriteObject getLastSpriteName];
    
    while (spriteName==nil ||(lastSpriteName!=nil && spriteName == lastSpriteName))
    {
        CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX);
        if(heroPosY<=90)
        {
            CGFloat value=random *3;
            
            if(value <=1)
                spriteName=@"Sprite4";
            else if(value <=2)
                spriteName=@"Sprite5";
            else if(value <=3)
                spriteName=@"Sprite67";
            
        }else
        {
            CGFloat value=random * 4;
            
            if(value <=1)
                spriteName=@"Sprite1";
            else if(value <=2)
                spriteName=@"Sprite9";
            else if(value <=3)
                spriteName=@"Sprite14";
            else if(value <=4)
                spriteName=@"Sprite15";
           // else if(value <=5)
             //   spriteName=@"W5";
        }
        
    }
    
    [NTSpriteObject setLastSpriteName:spriteName];
    
    NTSpriteObject* sprite;
    
    if([spriteName isEqual:@"Sprite1"])
    {
        sprite= (NTSpriteObject*)[CCBReader load:@"Sprites/Sprite1"];
        [sprite setSpriteName:@"Sprite1"];
        sprite.scaleX=0.65f;
        sprite.scaleY=0.65f;
        if(GamePlay.isSoundOn && ![GamePlay isGameOver] )
        {
            OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
            [audio playEffect:@"SpriteSound1.mp3" volume:0.2f pitch:1.f pan:0 loop:false];
        }
    }
    
    if([spriteName isEqual:@"Sprite4"])
    {
        sprite= (NTSpriteObject*)[CCBReader load:@"Sprites/Sprite4"];
        [sprite setSpriteName:@"Sprite4"];
        sprite.scaleX=0.7f;
        sprite.scaleY=0.7f;
        if(GamePlay.isSoundOn && ![GamePlay isGameOver])
        {
            OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
            [audio playEffect:@"SpriteSound3.mp3" volume:0.2f pitch:1.f pan:0 loop:false];
        }
    }
    
    if([spriteName isEqual:@"Sprite5"])
    {
        sprite= (NTSpriteObject*)[CCBReader load:@"Sprites/Sprite5"];
        [sprite setSpriteName:@"Sprite5"];
        sprite.scaleX=0.7f;
        sprite.scaleY=0.7f;
        if(GamePlay.isSoundOn && ![GamePlay isGameOver])
        {
            OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
            [audio playEffect:@"SpriteSound4.mp3" volume:0.2f pitch:1.f pan:0 loop:false];
        }
    }
    
    if([spriteName isEqual:@"Sprite9"])
    {
        sprite= (NTSpriteObject*)[CCBReader load:@"Sprites/Sprite9"];
        [sprite setSpriteName:@"Sprite9"];
        sprite.scaleX=0.6f;
        sprite.scaleY=0.6f;
    }
    
    if([spriteName isEqual:@"Sprite14"])
    {
        sprite= (NTSpriteObject*)[CCBReader load:@"Sprites/Sprite14"];
        [sprite setSpriteName:@"Sprite14"];
        sprite.scaleX=0.65f;
        sprite.scaleY=0.65f;
        if(GamePlay.isSoundOn && ![GamePlay isGameOver])
        {
            OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
            [audio playEffect:@"SpriteSound2.mp3" volume:0.2f pitch:1.f pan:0 loop:false];
        }
    }
    if([spriteName isEqual:@"Sprite15"])
    {
        sprite= (NTSpriteObject*)[CCBReader load:@"Sprites/Sprite15"];
        [sprite setSpriteName:@"Sprite15"];
        sprite.scaleX=0.5f;
        sprite.scaleY=0.5f;
        if(GamePlay.isSoundOn && ![GamePlay isGameOver])
        {
            OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
            [audio playEffect:@"SpriteSound3.mp3" volume:0.2f pitch:1.f pan:0 loop:false];
        }
    }
    
//    if([spriteName isEqual:@"W5"])
//    {
//        sprite= (NTSpriteObject*)[CCBReader load:@"Sprites/W5"];
//        [sprite setSpriteName:@"W5"];
//        sprite.scaleX=0.5f;
//        sprite.scaleY=0.5f;
//    }
    
    if([spriteName isEqual:@"Sprite67"])
    {
        sprite= (NTSpriteObject*)[CCBReader load:@"Sprites/Sprite67"];
        [sprite setSpriteName:@"Sprite67"];
    }
    [sprite setupRandomPosition:heroPosY];
    [sprite setupRandomSpeed];
    if(sprite==nil)
    {
    
    }

    return sprite ;
}


- (void)setupRandomPosition: (CGFloat) heroPosY {
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX);

    CGFloat distance=  MaxStartSpriteX-[GamePlay getScores]*2/3;
    if(distance<0)
        distance=30;
    
    CGFloat newX = s.width+ (random * distance);
    CGFloat newY =heroPosY;
    
    if(heroPosY>=[CCDirector sharedDirector].viewSize.height/2)
        newY =heroPosY+20;
    
    if(heroPosY<=[CCDirector sharedDirector].viewSize.height/2)
        newY =heroPosY-20;
    
    if(newY<50 || heroPosY<=90)
        newY=50;
    
    if(newY>s.height)
        newY=s.height;
    
    self.position = ccp(newX,newY);// minimumYPosition + (random * range));
    
}

- (void)setupRandomSpeed {
    
    CGFloat random = ((double)arc4random() / ARC4RANDOM_MAX);
    
    if(_spriteObjectName==@"Sprite4" )
        _speed=random * 50 + 175;
    else if( _spriteObjectName==@"Sprite5" )
            _speed=random * 30 + 215;
    else if(_spriteObjectName==@"Sprite67" )
        _speed=random * 40 + 225;
    else if(_spriteObjectName==@"Sprite9" )
        _speed=random * 30 + 115;

    else
        _speed=random * 20 + 155*(1+[GamePlay getScores]/300);
}


@end