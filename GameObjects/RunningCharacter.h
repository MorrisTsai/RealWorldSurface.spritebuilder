//
//  RunningCharacter.h
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "StandardGameObject.h"

@interface RunningCharacter : StandardGameObject
@property int hp;
@property int maxHp;
@property int speed;
@property int ammunition;
@property BOOL doubleJump;
@property BOOL invincible;
@property BOOL boostSpeed;
@property BOOL powerRege;
@property CCSprite* myView;

- (instancetype)initWithSize:(CGSize)size;
@end
