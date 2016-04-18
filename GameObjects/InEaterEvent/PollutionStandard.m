//
//  PollutionStandard.m
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "PollutionStandard.h"

@implementation PollutionStandard
{
    CCNodeColor* view;
}
- (instancetype)initWithSize:(CGSize)size;
{
    self = [super init];
    if (self) {
        self.contentSize = size;
        _alive = YES;
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
    [self buildView];
    
    
}
-(void)die
{
    _alive = NO;
    
    [self dieAnimation];
}
-(void)dieAnimation
{
    CCActionMoveBy* mb = [CCActionMoveBy actionWithDuration:2 position:ccp(0, -100)];
    CCActionRemove* rm = [CCActionRemove action];
    CCActionSequence* seq = [CCActionSequence actions:mb,rm, nil];
    [view runAction:seq];
}
-(void)buildView
{
    view = [CCNodeColor nodeWithColor:[CCColor cyanColor]];
    view.contentSize = self.contentSize;
    [self addChild:view];
    view.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    CCNodeColor* shineColor = [CCNodeColor nodeWithColor:[CCColor whiteColor]];
    shineColor.contentSize = self.contentSize;
    [view addChild:shineColor];
    shineColor.opacity = 0.6;
    shineColor.anchorPoint = ccp(0.5, 0.5);
    shineColor.position = ccp(view.contentSize.width/2, view.contentSize.height/2);
}
@end
