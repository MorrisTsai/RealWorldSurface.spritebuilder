//
//  PollutionEventStandard.m
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "PollutionEventStandard.h"
#import "PollutionStandard.h"


@implementation PollutionEventStandard
{
    NSMutableArray* pollutionNodes;
    NSMutableArray* swipeNodes;
    CCDrawNode* drawNode;
    int pNumbers;;
    CGPoint prevPoint;
}

- (instancetype)initWithSize:(CGSize)size andNumber:(int)numbers;
{
    self = [super init];
    if (self) {
        self.contentSize = size;
        drawNode = [CCDrawNode node];
        prevPoint = CGPointZero;
        [self addChild:drawNode];
        self.anchorPoint = ccp(0.5, 0.5);
        pNumbers = numbers;
        pollutionNodes = [NSMutableArray array];
      //  [self setUserInteractionEnabled:YES];
         
    }
    return self;
}

-(void)onEnter
{
    [super onEnter];
    [self buildPollutionView];
    
}
-(BOOL)creatrueCollide:(StandCreature *)creature
{
    CGPoint pivot = [self convertToNodeSpace:[creature.parent convertToWorldSpace:creature.boundingBox.origin]];
    CGRect rect = CGRectMake(pivot.x, pivot.y, creature.contentSize.width, creature.contentSize.height);
    for(PollutionStandard* thisPollution in pollutionNodes)
    {
        if(CGRectIntersectsRect(rect, thisPollution.boundingBox))
        {
            [creature die];
        }
    }
}
-(void)nextFrame
{
    
}
-(void)checkHitPollution:(CGPoint)touchPoint
{
    for(int i = 0 ;i < [pollutionNodes count]; i++)
    {
        CGRect checkSwipeRect = CGRectMake(touchPoint.x-1, touchPoint.y + 1, 2, 2);
        PollutionStandard* pollution = [pollutionNodes objectAtIndex:i];
        if(CGRectIntersectsRect(pollution.boundingBox, checkSwipeRect))
        {
            [pollution die];
            [pollutionNodes removeObject:pollution];
            i--;
           
        }
    }
}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint touchPoint = [self convertToNodeSpace:touch.locationInWorld];
    [self checkHitPollution:touchPoint];
}
-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint touchPoint = [self convertToNodeSpace:touch.locationInWorld];
    [self checkHitPollution:touchPoint];
    
}
-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
   
}
-(void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
}
-(void)buildPollutionView
{
    for(int i = 0; i < pNumbers; i ++)
    {
        PollutionStandard* pollution = [[PollutionStandard alloc]initWithSize:CGSizeMake(10, 10)];
        [self addChild:pollution];
        pollution.position = ccp(self.contentSize.width/4 + arc4random()%((int)self.contentSize.width/2),self.contentSize.height/4 +  arc4random()%((int)self.contentSize.height/2));
        [pollutionNodes addObject:pollution];
        
    }
    
}
@end
