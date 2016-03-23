//
//  StandObstacle.h
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "StandardGameObject.h"

@interface StandardObstacle : StandardGameObject
@property BOOL hitted;
@property CCSprite* myView;
@property int damage;

- (instancetype)initWithSize:(CGSize)size;
@end
