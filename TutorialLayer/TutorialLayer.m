//
//  TutorialLayer.m
//  RealWorldSurface
//
//  Created by Morris on 4/19/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "TutorialLayer.h"

@implementation TutorialLayer
{
    NSMutableArray* tutorialArray;
    NSMutableArray* page;
    NSMutableArray* touchArray;
    int showingPage;
    BOOL animating;
    
    CCSprite* rightArrow;
    CCSprite* leftArrow;
}
- (instancetype)initWithMode:(StageType)type
{
    self = [super init];
    if (self) {
        tutorialArray = [[NSMutableArray alloc]init];
        if(type == StageType_Water)
        {
            [self waterTutorial];
        }
        else if(type == StageType_Garbage)
        {
            [self garbageTutorial];
        }
        else
        {
            [self waterTutorial];
            [self garbageTutorial];
        }
        showingPage = 0;
        animating = NO;
        [self setUserInteractionEnabled:YES];
        self.contentSize = [CCDirector sharedDirector].viewSize;
        touchArray = [NSMutableArray array];
        page = [NSMutableArray array];
        self.anchorPoint = ccp(0.5, 0.5);
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
    [self buildTutorialView];
    [self buildArrow];
    [self buildSkip];
}
-(void)buildSkip
{
    CCButton* skipButton = [CCButton buttonWithTitle:@"Skip" fontName:nil fontSize:15];
    [self addChild:skipButton];
    skipButton.position = ccp(self.contentSize.width - skipButton.contentSize.width*2, skipButton.contentSize.height*2);
    skipButton.cascadeColorEnabled = YES;
    skipButton.color = [CCColor redColor];
    [skipButton setTarget:self selector:@selector(skipButtonPressed)];
}
-(void)skipButtonPressed
{
    [self.delegate tutorialEnd];
    [self removeFromParentAndCleanup:YES];
}
-(void)buildTutorialView
{
    for(int i = 0 ; i < [tutorialArray count]; i++)
    {
        CCSprite* tutorial = [tutorialArray objectAtIndex:i];
        
        CCNode* node = [CCNode node];
        node.contentSize = CGSizeMake(self.contentSize.width*1.1, self.contentSize.height);
        node.anchorPoint = ccp(0.5,0.5);
        [node addChild:tutorial];
        tutorial.position = ccp(node.contentSize.width/2, node.contentSize.height/2);
        tutorial.scale = self.contentSize.width/tutorial.contentSize.width;
        tutorial.scale*= 1.05;
        [page addObject:node];
        [self addChild:node];
        node.position = ccp(self.contentSize.width/2 + i*node.contentSize.width, self.contentSize.height/2);
    }
    
    
}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [touchArray addObject:[NSValue valueWithCGPoint:[self convertToWorldSpace:touch.locationInWorld]]];
}
-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [touchArray addObject:[NSValue valueWithCGPoint:[self convertToWorldSpace:touch.locationInWorld]]];
}
-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [touchArray addObject:[NSValue valueWithCGPoint:[self convertToWorldSpace:touch.locationInWorld]]];
    [self checkChangePage];
   if([touchArray count] <= 2)
   {
       [self nextPage];
   }
}

-(void)checkChangePage
{
    CGPoint firstPoint = [[touchArray firstObject]CGPointValue];
    CGPoint lastPoint = [[touchArray lastObject]CGPointValue];
    if((lastPoint.x - firstPoint.x) >20 )
    {
        [self prevPage];
    }
    else if ((lastPoint.x - firstPoint.x) < -20)
    {
        [self nextPage];
    }
    [touchArray removeAllObjects];
}
-(void)nextPage
{
    if((showingPage < [page count]) && !animating)
    {
        for(CCNode* thisPage in page)
        {
            CCActionMoveBy* mb = [CCActionMoveBy actionWithDuration:0.3 position:ccp(-thisPage.contentSize.width, 0)];
            [thisPage runAction:mb];
           
            animating = YES;
            [self scheduleBlock:^(CCTimer* timer){
                animating = NO;
                if(showingPage == [page count])
                {
                    [self removeFromParentAndCleanup:YES];
                    [self.delegate tutorialEnd];
                }

            }delay:0.3];
        }
         showingPage ++;
    }
    }
-(void)prevPage
{
    if((showingPage > 0) && !animating)
    {
        for(CCNode* thisPage in page)
        {
            CCActionMoveBy* mb = [CCActionMoveBy actionWithDuration:0.3 position:ccp(thisPage.contentSize.width, 0)];
            [thisPage runAction:mb];
                        [self scheduleBlock:^(CCTimer* timer){
                animating = NO;
            }delay:0.3];
        }
        showingPage --;
        [self checkArrow];

    }
}
-(void)checkArrow
{
    
    if(showingPage == 0)
    {
        leftArrow.visible = NO;
    }
    else
    {
        leftArrow.visible = YES;
    }
}
-(void)buildArrow
{
    if(!leftArrow)
    {
        rightArrow = [CCSprite spriteWithImageNamed:@"arrowleft.png"];
        leftArrow = [CCSprite spriteWithImageNamed:@"arrowright.png"];
        
        
    }
    if(!leftArrow.parent)
    {
        [self addChild:leftArrow];
        [self addChild:rightArrow];
        leftArrow.position = ccp(50, self.contentSize.height/2);
        rightArrow.position = ccp(self.contentSize.width - 50, self.contentSize.height/2);
        CCActionMoveBy* mb = [CCActionMoveBy actionWithDuration:0.5 position:ccp(-10, 0)];
        CCActionMoveBy* mb2 = [CCActionMoveBy actionWithDuration:0.5 position:ccp(10, 0)];
        CCActionDelay* dl = [CCActionDelay actionWithDuration:1];
        CCActionSequence* seq1 = [CCActionSequence actions:mb,mb2,dl,nil];
        CCActionRepeatForever* fr = [CCActionRepeatForever actionWithAction:seq1];
        [leftArrow runAction:fr];
        
        
        
        
        CCActionMoveBy* mb3 = [CCActionMoveBy actionWithDuration:0.5 position:ccp(10, 0)];
        CCActionMoveBy* mb4 = [CCActionMoveBy actionWithDuration:0.5 position:ccp(-10, 0)];
        CCActionDelay* dl2 = [CCActionDelay actionWithDuration:1];
        CCActionSequence* seq2 = [CCActionSequence actions:mb3,mb4,dl2,nil];
        CCActionRepeatForever* fr2 = [CCActionRepeatForever actionWithAction:seq2];
        [rightArrow runAction:fr2];
        
        leftArrow.scale /= 2;
        rightArrow.scale /= 2;
        
        leftArrow.visible = NO;
    }
}
-(void)waterTutorial
{
     [tutorialArray addObject:[CCSprite spriteWithImageNamed:@"swipeToClean1.png"]];
     [tutorialArray addObject:[CCSprite spriteWithImageNamed:@"swipeToClean2.png"]];
     [tutorialArray addObject:[CCSprite spriteWithImageNamed:@"swipeToClean3.png"]];
}
-(void)garbageTutorial
{
    [tutorialArray addObject:[CCSprite spriteWithImageNamed:@"collectGarbage1.png"]];
    [tutorialArray addObject:[CCSprite spriteWithImageNamed:@"collectGarbage2.png"]];
     [tutorialArray addObject:[CCSprite spriteWithImageNamed:@"jumpOverStone1.png"]];
     [tutorialArray addObject:[CCSprite spriteWithImageNamed:@"jumpOverStone2.png"]];
}
@end
