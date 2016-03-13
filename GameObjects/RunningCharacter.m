//
//  RunningCharacter.m
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "RunningCharacter.h"

@implementation RunningCharacter
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.myView = [CCSprite spriteWithImageNamed:@"Circle.png"];
        [self addChild:self.myView];
         self.contentSize = CGSizeMake(25, 25);
        self.myView.scale = 25/self.myView.contentSize.width;
        self.myView.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        self.anchorPoint = ccp(0.5, 0.5);
    }
    return self;
}

@end
