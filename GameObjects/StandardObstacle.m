//
//  StandObstacle.m
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "StandardObstacle.h"

@implementation StandardObstacle
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hitted = NO;
        self.myView = [CCSprite spriteWithImageNamed:@"Rectangle.png"];
        [self addChild:self.myView];
      //  self.contentSize = self.myView.contentSize;
        self.myView.scale = 15/self.myView.contentSize.width;
        self.myView.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        self.anchorPoint = ccp(0.5, 0.5);
    }
    return self;
}

@end
