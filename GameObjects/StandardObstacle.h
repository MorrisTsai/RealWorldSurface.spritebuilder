//
//  StandObstacle.h
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "StandardGameObject.h"
@class StandardObstacle;
@protocol StandardObstacleDelegate <NSObject>

-(void)obstalceCollected:(StandardObstacle*)obstacle;

@end

@interface StandardObstacle : StandardGameObject
@property BOOL hitted;
@property CCSprite* myView;
@property int damage;
@property int obstacleId;

@property (nonatomic, weak) id<StandardObstacleDelegate>delegate;
- (instancetype)initWithSize:(CGSize)size;
- (BOOL)checkTouched:(CCTouch*)touch;

@end
