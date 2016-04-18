//
//  GarbageObstacle.m
//  RealWorldSurface
//
//  Created by Morris on 4/2/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "GarbageObstacle.h"

@implementation GarbageObstacle


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
    [self decideSpriteFrame];
  //  [self setUserInteractionEnabled:YES];
    
}
-(void)decideSpriteFrame
{
    NSArray* candidates = @[@"bottle1.png",@"bottle2.png",@"trubbish.png"];
    int index = arc4random() % [candidates count];
    NSString* fileName = [candidates objectAtIndex:index];
    CCSprite* thisSprite = [CCSprite spriteWithImageNamed:fileName];
    self.myView.spriteFrame = thisSprite.spriteFrame;
    self.myView.scale = 1;
    self.myView.scaleX = self.contentSize.width/self.myView.contentSize.width;
    self.myView.scaleY = self.contentSize.height/self.myView.contentSize.height;
   // self.myView.scale = 1;
    
    self.myView.color = [CCColor whiteColor];
    
}
-(BOOL)checkTouched:(CCTouch *)touch
{
    CGPoint touchPoint = [self convertToNodeSpace:touch.locationInWorld];
    if(ccpDistance(touchPoint, ccp(self.contentSize.width/2, self.contentSize.width/2)) < self.contentSize.width)
    {
        [self pickedUp];
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
   
}
-(void)pickedUp
{
    self.hitted = YES;
   // [self removeFromParentAndCleanup:YES];
    [self.delegate obstalceCollected:self];
}

@end
