//
//  StandCreature.m
//  RealWorldSurface
//
//  Created by Morris on 3/13/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "StandCreature.h"

@implementation StandCreature
- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.contentSize = size;
        self.anchorPoint = ccp(0.5, 0.5);
        self.myView = [CCSprite spriteWithImageNamed:@"Mud_Fish.png"];
        [self addChild:self.myView];
        self.myView.scale = size.width/self.myView.contentSize.width;
        self.myView.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        
    }
    return self;
}
-(void)die
{
    CCSprite* ff = [CCSprite spriteWithImageNamed:@"Dead_Fish.png"];
    self.myView.spriteFrame = ff.spriteFrame;
    [self stopAllActions];
    CCActionMoveBy* mb = [CCActionMoveBy actionWithDuration:4 position:ccp(0, -50)];
    CCActionRemove* rm = [CCActionRemove action];
    CCActionSequence* seq = [CCActionSequence actions:mb,rm, nil];
    [self.myView runAction:seq];
}
@end
