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
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "SoundManager.h"
@interface MenuScene ()<AVPlayerViewControllerDelegate>
@end

@implementation MenuScene
{
    CCSprite* background ;
    CCSprite* pendingBackground;
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
        groundArray=[NSMutableArray array];
       
    }
    return self;
}
-(void)buildBackground
{
    background = [CCSprite spriteWithImageNamed:@"BroadBeach_BG.png"];
    [self addChild:background z:-1];
    background.position = ccp(winSize.width/2, winSize.height/2);
    
    pendingBackground = [CCSprite spriteWithImageNamed:@"BroadBeach_BG.png"];
    [self addChild:pendingBackground];
    pendingBackground.position = ccpAdd(background.position, ccp(pendingBackground.contentSize.width, 0));
}
-(void)backgroundMove
{
    background.position = ccp(background.position.x -1, background.position.y);
    pendingBackground.position = ccp(pendingBackground.position.x - 1, pendingBackground.position.y);
    
    if(background.position.x + background.contentSize.width*2/3 < 0)
    {
        background.position = ccpAdd(pendingBackground.position, ccp(background.contentSize.width, 0));
    }
    
    if(pendingBackground.position.x + pendingBackground.contentSize.width*2/3 < 0)
    {
        pendingBackground.position = ccpAdd(background.position, ccp(background.contentSize.width, 0));
    }
    
    
}


-(void)onEnter
{
    [super onEnter];
    [self buildBackground];
    [self startView];
    
    [self buildGround];
    [self schedule:@selector(groundMove) interval:0.01];
  
       [[RealSourceManager shared]checkDataNumberFromServerWithCompletionHandler:^(BOOL ok)
    {
         [self buildButtons];
        if(![RealSourceManager shared].regionArray)
        {
            
            [[RealSourceManager shared]listAllRegionFromServerWithCompletionHandler:^(BOOL ok)
             {
                 
             }];
        }

    }];
    
   // [self performSelector:@selector(runVideo) withObject:nil afterDelay:5];
    [[SoundManager shared]playBackgroundMusic];
    
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
    CCSprite* gg = [CCSprite spriteWithImageNamed:@"empty-green-button.png"];
    dispatch_async(dispatch_get_main_queue(), ^(){
                       gameButton = [CCButton buttonWithTitle:@"Start" fontName:@"AmericanTypewriter-CondensedBold" fontSize:30];
                       // gameButton = [CCButton buttonWithTitle:@"Start" spriteFrame:gg.spriteFrame];
                     //  gameButton.label.fontSize = 14;
                    //gameButton.background.spriteFrame = gg.spriteFrame;
                       [self addChild:gameButton z:2];
                       gameButton.position = ccp(winSize.width*0.8, winSize.height*0.8);
                       [gameButton setTarget:self selector:@selector(gameButtonPressed)];
        
            CCNodeColor* backgroundNode = [CCNodeColor nodeWithColor:[CCColor greenColor]];
            backgroundNode.contentSize = gameButton.contentSize;
            [self addChild:backgroundNode z:1];
            backgroundNode.position = gameButton.position;
            backgroundNode.anchorPoint = ccp(0.5, 0.5);
        
                   });
    
   
   // gameButton.background.color = [CCColor greenColor];
   // gameButton.label.fontColor = [CCColor redColor];
    
  
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
            groundNode.position = ccp(groundNode.position.x, 0);
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
    CCSprite* left= [CCSprite spriteWithImageNamed:@"vic.png"];
    [self addChild:left];
    left.scale *= 0.5;
    left.position = ccp(-left.contentSize.width/2, self.contentSize.height*0.8);
    CCActionMoveTo* mt = [CCActionMoveTo actionWithDuration:0.3 position:ccp(self.contentSize.width*0.2, self.contentSize.height*0.8)];
    [left runAction:mt];
}
-(void)rightIn
{
    CCSprite* right= [CCSprite spriteWithImageNamed:@"run.png"];
    right.scale *= 0.5;
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
    CCSprite* character = [CCSprite spriteWithImageNamed:@"cat_run(1).png"];
    character.scale *= 0.2;
    [self addChild:character z:10];
    character.position = ccp(self.contentSize.width*0.1, standO.position.y+ character.contentSize.height*0.2/2 + standO.contentSize.height + 20);
    CCActionFadeOut* fo = [CCActionFadeOut actionWithDuration:1];
    [whiteNode runAction:fo];
    
    CCActionMoveTo* ft1 = [CCActionMoveTo actionWithDuration:0.4 position:ccp(character.position.x, character.position.y+5)];
    CCActionMoveTo* ft2 = [CCActionMoveTo actionWithDuration:0.4 position:ccp(character.position.x, character.position.y - 5)];
    CCActionSequence* seq = [CCActionSequence actionOne:ft1 two:ft2];
    CCActionRepeatForever* fr = [CCActionRepeatForever actionWithAction:seq];
    [character runAction:fr];
    
    
    
    
    
   
        NSMutableArray* aniFrames = [NSMutableArray array];
        CCSprite* sp1 = [CCSprite spriteWithImageNamed:@"cat_run(1).png"];
        CCSprite* sp2 =[CCSprite spriteWithImageNamed:@"cat_run(2).png"];
        CCSprite* sp3 =[CCSprite spriteWithImageNamed:@"cat_run(3).png"];
        CCSprite* sp4 =[CCSprite spriteWithImageNamed:@"cat_run(4).png"];
        
        CCSprite* sp5 = [CCSprite spriteWithImageNamed:@"cat_run(5).png"];
        CCSprite* sp6 =[CCSprite spriteWithImageNamed:@"cat_run(6).png"];
        CCSprite* sp7 =[CCSprite spriteWithImageNamed:@"cat_run(7).png"];
        CCSprite* sp8 =[CCSprite spriteWithImageNamed:@"cat_run(8).png"];
        [aniFrames addObject:sp1.spriteFrame];
        [aniFrames addObject:sp2.spriteFrame];
        [aniFrames addObject:sp3.spriteFrame];
        [aniFrames addObject:sp4.spriteFrame];
        [aniFrames addObject:sp5.spriteFrame];
        [aniFrames addObject:sp6.spriteFrame];
        [aniFrames addObject:sp7.spriteFrame];
        [aniFrames addObject:sp8.spriteFrame];
        
        CCAnimation* animation = [CCAnimation animationWithSpriteFrames:aniFrames delay:0.2];
        // aniSprite = [CCSprite spriteWithImageNamed:@"Water_drop_1.png"];
        CCActionAnimate* actionAni = [CCActionAnimate actionWithAnimation:animation];
        CCActionRepeatForever* rp = [CCActionRepeatForever actionWithAction:actionAni];
        // aniSprite.scale = self.myView.scaleX*2;
        [character runAction:rp];
      [self schedule:@selector(backgroundMove) interval:0.01];
        
    
}



@end
