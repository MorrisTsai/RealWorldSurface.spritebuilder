//
//  GroundObject.m
//  RealWorldSurface
//
//  Created by Morris on 3/21/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "GroundObject.h"

@implementation GroundObject
{
    CCSprite* myView;
}
- (instancetype)initWithSize:(CGSize)size;
{
    self = [super init];
    if (self) {
        self.contentSize = size;
        self.anchorPoint = ccp(0.5, 0.5);
        myView = [CCSprite spriteWithImageNamed:@"ocean-part.png"];
        [self addChild:myView];
        myView.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        myView.scaleX = (size.width+ 10)/myView.contentSize.width;
        myView.scaleY = size.height/myView.contentSize.height;
    }
    return self;
}

@end
