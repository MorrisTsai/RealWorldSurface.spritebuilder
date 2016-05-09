//
//  TimeBar.m
//  VicRun
//
//  Created by Morris on 9/05/2016.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TimeBar.h"

@implementation TimeBar
{
    CCSprite* background;
    CCSprite* catHead;
}
- (instancetype)initWithSize:(CGSize)size;
{
    self = [super init];
    if (self) {
        self.contentSize = size;
        self.anchorPoint = ccp(0.5,0.5);
    }
    return self;
}
-(void)onEnter
{
    [self buildBackground];
    [self buildHeadCat];
    [super onEnter];
}
-(void)setCatPositionWithCurrentTime:(int)currentTime andMaxTime:(int)maxTime
{
    CCActionMoveTo*mt = [CCActionMoveTo actionWithDuration:1 position:ccp(self.contentSize.width* ((maxTime-currentTime)*1.0/maxTime), self.contentSize.height/2)];
    [catHead runAction:mt];
}
-(void)buildBackground
{
    background = [CCSprite spriteWithImageNamed:@"BroadBeach_BG.png"];
    [self addChild:background];
    background.scaleX = self.contentSize.width/background.contentSize.width;
    background.scaleY = self.contentSize.height/background.contentSize.height;
    background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
}
-(void)buildHeadCat
{
    catHead = [CCSprite spriteWithImageNamed:@"catHead.png"];
    [self addChild:catHead z:1];
    catHead.scale = (self.contentSize.height*0.8)/catHead.contentSize.height;
    catHead.position = ccp(0,self.contentSize.height/2);
}
@end
