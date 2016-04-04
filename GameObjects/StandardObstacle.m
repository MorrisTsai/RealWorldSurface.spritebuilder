//
//  StandObstacle.m
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "StandardObstacle.h"
static int counter = 0;
@implementation StandardObstacle
{
    
}

- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.hitted = NO;
        self.myView = [CCSprite spriteWithImageNamed:@"Rectangle.png"];
        [self addChild:self.myView];
        self.contentSize = size;
      //  self.contentSize = self.myView.contentSize;
        self.myView.scale = size.width/self.myView.contentSize.width;
        self.myView.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        self.anchorPoint = ccp(0.5, 0.5);
        self.damage = 1;
        self.obstacleId = counter;
        counter++;
    }
    return self;
}
-(BOOL)checkTouched:(CCTouch*)touch
{
    return NO;
}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
}
@end
