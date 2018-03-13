//
//  Hero.h
//  Wings
//
//  Created by Nam Trung on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Hero : CCSprite
-(void)PushBeginHero ;
-(void)PushEndHero ;
-(void)ActionFallDown;
-(void)Ready ;

-(BOOL)isReady;
@end
