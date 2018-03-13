//
//  NTSpriteObject.h
//  Wings
//
//  Created by Nam Trung on 11/18/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "CCSprite.h"

@interface NTSpriteObject : CCSprite
- (CGFloat) Speed;
-(void) SetSpeed:(CGFloat)value;

- (void)setupRandomPosition:(CGFloat) heroPosY;
+ (NTSpriteObject*) GenRandomSprite:(CGFloat) heroPosY;


+ (NSString*) getLastSpriteName;
+ (void) setLastSpriteName:(NSString*)value;


- (NSString*) getSpriteName;
- (void) setSpriteName:(NSString*)value;

@end

