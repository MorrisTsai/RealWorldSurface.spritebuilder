//
//  MenuScene.m
//  RealWorldSurface
//
//  Created by Morris on 3/14/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "MenuScene.h"
#import "GameMainScene.h"
#import "StageChooseScene.h"
#import "RealSourceManager.h"

@implementation MenuScene
{
    CCSprite* background ;
    CGSize winSize;
    CCButton* gameButton;
    CCButton* shopButton;
    CCButton* leaderboardButton;
    NSMutableArray* groundArray;
    CCNodeColor* whiteNode;
    
   
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        winSize = [CCDirector sharedDirector].viewSize;
        background = [CCSprite spriteWithImageNamed:@"Background.png"];
        [self addChild:background];
        background.position = ccp(winSize.width/2,winSize.height/2);
        
        groundArray=[NSMutableArray array];
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
    
    [self startView];
    [self buildGround];
    [self schedule:@selector(groundMove) interval:0.01];
    if(![RealSourceManager shared].regionArray)
    {
        
        [[RealSourceManager shared]listAllRegionFromServerWithCompletionHandler:^(BOOL ok)
         {
             
         }];
    }
    [[RealSourceManager shared]checkDataNumberFromServerWithCompletionHandler:^(BOOL ok)
    {
         [self buildButtons];
    }];
    
   
    
}
-(void)startView
{
    CCActionCallFunc* cf1 = [CCActionCallFunc actionWithTarget:self selector:@selector(leftIn)];
    CCActionCallFunc* cf2 = [CCActionCallFunc actionWithTarget:self selector:@selector(rightIn)];
    CCActionCallFunc* cf3 = [CCActionCallFunc actionWithTarget:self selector:@selector(shine)];
    CCActionCallFunc* cf4 = [CCActionCallFunc actionWithTarget:self selector:@selector(shineFadeOut)];
    CCActionDelay* delay1 = [CCActionDelay actionWithDuration:0.3];
    CCActionDelay* delay2 = [CCActionDelay actionWithDuration:0.3];
    CCActionDelay* delay3 = [CCActionDelay actionWithDuration:0.3];
    CCActionSequence* seq = [CCActionSequence actions:cf1,delay1,cf2,delay2,cf3,delay3,cf4, nil];
    [self runAction:seq];
}
-(void)buildButtons
{
    gameButton = [CCButton buttonWithTitle:@"Start" fontName:nil fontSize:20];
    [self addChild:gameButton];
    gameButton.position = ccp(winSize.width*0.8, winSize.height*0.8);
    [gameButton setTarget:self selector:@selector(gameButtonPressed)];
}
-(void)buildGround
{
    int blockWidth =0;
    while (blockWidth < winSize.width)
    {
      //  CCNodeColor* groundNode = [CCNodeColor nodeWithColor:[CCColor colorWithCcColor3b:ccc3(arc4random()%255, arc4random()%255, arc4random()%255)]];
        CCSprite* groundNode = [CCSprite spriteWithImageNamed:@"ocean-part.png"];
        groundNode.scale *= 0.2;
        [self addChild:groundNode];
        groundNode.contentSize = CGSizeMake(groundNode.contentSize.width*0.2, groundNode.contentSize.height*0.2);
        groundNode.anchorPoint = ccp(0.5, 0.5);
        CCSprite* lastNode = [groundArray lastObject];
        groundNode.position = ccpAdd(lastNode.position, ccp(lastNode.contentSize.width, 0));
        
        blockWidth += groundNode.contentSize.width;
        if(groundNode.position.y  == 0)
        {
            groundNode.position = ccp(groundNode.position.x, 25);
        }
        [groundArray addObject:groundNode];
        
    }
}
-(void)groundMove
{
    for(CCNodeColor* thisNode in groundArray)
    {
        thisNode.position = ccpAdd(thisNode.position, ccp(-2, 0));
        if((thisNode.position.x + thisNode.contentSize.width) < 0)
        {
            [thisNode removeFromParentAndCleanup:YES];
            
        }
    }
    //checkToAdd
    CCNodeColor* lastNode = [groundArray lastObject];
    if((lastNode.position.x - lastNode.contentSize.width) < winSize.width)
    {
        [self addAppendingNode];
    }
    
}
-(void)addAppendingNode
{
    CCSprite* groundNode = [CCSprite spriteWithImageNamed:@"ocean-part.png"];
    groundNode.scale *= 0.2;
    
    [self addChild:groundNode];
    groundNode.contentSize = CGSizeMake(groundNode.contentSize.width*0.2, groundNode.contentSize.height*0.2);
    groundNode.anchorPoint = ccp(0.5, 0.5);
    CCNodeColor* lastNode = [groundArray lastObject];
    groundNode.position = ccpAdd(lastNode.position, ccp(lastNode.contentSize.width, 0));
    [groundArray addObject:groundNode];
    
    
}

-(void)gameButtonPressed
{
    [[CCDirector sharedDirector]replaceScene:[StageChooseScene node] withTransition:[CCTransition transitionFadeWithDuration:2]];
}
-(void)leftIn
{
    CCSprite* left= [CCSprite spriteWithImageNamed:@"VIC.png"];
    [self addChild:left];
    left.scale *= 0.2;
    left.position = ccp(-left.contentSize.width/2, self.contentSize.height*0.8);
    CCActionMoveTo* mt = [CCActionMoveTo actionWithDuration:0.3 position:ccp(self.contentSize.width*0.2, self.contentSize.height*0.8)];
    [left runAction:mt];
}
-(void)rightIn
{
    CCSprite* right= [CCSprite spriteWithImageNamed:@"SURV.png"];
    right.scale *= 0.2;
    [self addChild:right];
    right.position = ccp(self.contentSize.width + right.contentSize.width/2, self.contentSize.height*0.6);
    CCActionMoveTo* mt = [CCActionMoveTo actionWithDuration:0.3 position:ccp(self.contentSize.width*0.4, self.contentSize.height*0.6)];
    [right runAction:mt];
}
-(void)shine
{
    whiteNode = [CCNodeColor nodeWithColor:[CCColor whiteColor]];
    whiteNode.contentSize = winSize;
    [self addChild:whiteNode];
    whiteNode.anchorPoint = ccp(0.5, 0.5);
    whiteNode.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    CCActionFadeIn* fi = [CCActionFadeIn actionWithDuration:0.3];
    whiteNode.opacity = 0;
    [whiteNode runAction:fi];
    
    

}
-(void)shineFadeOut
{
    CCSprite* standO = [groundArray firstObject];
    CCSprite* character = [CCSprite spriteWithImageNamed:@"surfer.png"];
    character.scale *= 0.2;
    [self addChild:character z:10];
    character.position = ccp(self.contentSize.width*0.1, standO.position.y+ character.contentSize.height*0.2/2 + standO.contentSize.height + 20);
    CCActionFadeOut* fo = [CCActionFadeOut actionWithDuration:1];
    [whiteNode runAction:fo];
    
    CCActionMoveTo* ft1 = [CCActionMoveTo actionWithDuration:0.5 position:ccp(character.position.x, character.position.y+5)];
    CCActionMoveTo* ft2 = [CCActionMoveTo actionWithDuration:0.5 position:ccp(character.position.x, character.position.y - 5)];
    CCActionSequence* seq = [CCActionSequence actionOne:ft1 two:ft2];
    CCActionRepeatForever* fr = [CCActionRepeatForever actionWithAction:seq];
    [character runAction:fr];
}



@end
