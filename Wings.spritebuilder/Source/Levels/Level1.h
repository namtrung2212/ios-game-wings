//
//  Level1.h
//  Wings
//
//  Created by Nam Trung on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Level.h"
#import "GamePlay.h"
#import "NTSpriteObject.h"
@interface Level1 : CCNode<CCPhysicsCollisionDelegate>
- (CGFloat) getScrollSpeedBG ;
- (void) setScrollSpeedBG:(CGFloat) value ;
-(void)Ready ;

-(BOOL)isReady;
@end
