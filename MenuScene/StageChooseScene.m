//
//  StageChooseScene.m
//  RealWorldSurface
//
//  Created by Morris on 3/14/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "StageChooseScene.h"
#import "StageModels.h"
#import "GameMainScene.h"
#import "VSConstant.h"
#import "RealSourceManager.h"
#import "ScrollViewBoundaryShader.h"
#import "RealSourceManager.h"
#import "StageCell.h"
#import "StageAttributes.h"
#define MARGIN 7
#define TOP_MARGIN 14

@interface StageChooseScene ()<StageCellDelegate>

@end
@implementation StageChooseScene
{
    CCButton* gameButton;
    CCSprite* background;
    CGSize winSize;
    CCNode* contentNode;
    CCButton* backButton;
    ScrollViewBoundaryShader* shader;
    StageAttributes * chosedStageAttrubites;
    
    CGPoint prevTouchPoint;
    CGPoint oriMapPosition;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        winSize = [CCDirector sharedDirector].viewSize;
        background = [CCSprite spriteWithImageNamed:@"stasticmap.png"];
        [self addChild:background];
        background.position = ccp(winSize.width/2,winSize.height/2);
        [self setUserInteractionEnabled:YES];
    }
    return self;
}
-(void)onEnter
{
    
    [super onEnter];
    [self checkData];
    [self buildStageList];
}
-(void)checkData
{
    [self showLoading];

}
-(void)showLoading
{
    [contentNode removeFromParentAndCleanup:YES];
    contentNode = [CCNodeColor nodeWithColor:[CCColor clearColor]];
    [self addChild:contentNode];
    contentNode.position = ccp(winSize.width/2, winSize.height/2);
    contentNode.contentSize = CGSizeMake(winSize.width/2, winSize.height/2);
    contentNode.anchorPoint = ccp(0.5, 0.5);
    CCLabelTTF* label = [CCLabelTTF labelWithString:@"Loading..." fontName:nil fontSize:20];
    [contentNode addChild:label];
    label.position = ccp(contentNode.contentSize.width/2, contentNode.contentSize.height/2);
}

-(void)buildButtons
{
    gameButton = [CCButton buttonWithTitle:@"Start" fontName:nil fontSize:20];
    [self addChild:gameButton];
    gameButton.position = ccp(winSize.width/2, winSize.height/2);
    [gameButton setTarget:self selector:@selector(gameButtonPressed)];
}
-(void)gameButtonPressed
{
    NSDictionary* dictionary = @{Maxima:@"100",Minumun:@"10",Half:@"50",@"Name":@"Sample"};
    StageModels* model = [[StageModels alloc]initAttribute:dictionary];
    GameMainScene* game = [[GameMainScene alloc]initWithModel:model];
    [[CCDirector sharedDirector]replaceScene:game withTransition:[CCTransition transitionFadeWithDuration:1]];
}
-(void)backButtonPressed
{
    [shader removeFromParentAndCleanup:YES];
    [backButton removeFromParentAndCleanup:YES];
    [self showLoading];
  //  [self buildRegion];
}
-(void)buildStageList
{
    dispatch_async(dispatch_get_main_queue(), ^(){

    
    backButton = [CCButton buttonWithTitle:@"BACK" fontName:nil fontSize:14];
    [self addChild:backButton];
    [backButton setTarget:self selector:@selector(backButtonPressed)];
    backButton.position = ccp(winSize.width - backButton.contentSize.width, winSize.height - backButton.contentSize.height);
    [contentNode removeFromParentAndCleanup:YES];
    
    CCNode* scrollContent = [CCNode node];
    int height = 30;
    int space = 5;
    shader = [[ScrollViewBoundaryShader alloc]init];
    shader.contentSize = CGSizeMake(self.contentSize.width*0.9, self.contentSize.height*0.8);
    [self addChild:shader];
    shader.position = ccp(self.contentSize.width*0.05, self.contentSize.height*0.1);

    scrollContent.contentSize = CGSizeMake(contentNode.contentSize.width, ([[RealSourceManager shared].dailyStages count]+2) * (height + space));
     CCSprite* image = [CCSprite spriteWithImageNamed:@"ButtonBlue_T.png"];
    for(int i = 0 ; i < [[RealSourceManager shared].dailyStages count]; i++)
    {

        StageModels* thisModel = [[RealSourceManager shared].dailyStages objectAtIndex:i];
        StageCell* thisCell = [[StageCell alloc]initWithSize:CGSizeMake(40, 40) andStageModel:thisModel];
        [background addChild:thisCell];
        thisCell.position = ccp(thisModel.locationX, background.contentSize.height - thisModel.locationY);
        thisCell.delegate = self;
//       
//        CCButton* button = [CCButton buttonWithTitle:@"" spriteFrame:image.spriteFrame];
//        //button.preferredSize = CGSizeMake(winSize.width*0.8, height);
//        button.scaleX = winSize.width*0.75/button.contentSize.width;
//        button.scaleY = height/button.contentSize.height;
//        CCLabelTTF* nameLabel = [CCLabelTTF labelWithString:thisModel.stageName fontName:@"AmericanTypewriter-CondensedBold" fontSize:14];
//        nameLabel.fontColor = [CCColor greenColor];
//      
//     //   button.position = ccp(self.contentSize.width/2, self.contentSize.height/2 + 20*i);
//        button.name = [NSString stringWithFormat:@"%d",i];
//     
//        [button setTarget:self selector:@selector(stageChosed:)];
//        
//        button.position = ccp(shader.contentSize.width/2 , scrollContent.contentSize.height - (i + 1) * (height + space));
//        nameLabel.position = button.position;
//        [scrollContent addChild:button];
//        [scrollContent addChild:nameLabel];
      
    }
    
    
//    CCScrollView* scrollView = [[CCScrollView alloc] initWithContentNode:scrollContent];
//    scrollView.contentSizeType = CCSizeTypePoints;
//    scrollView.contentSize = shader.contentSize;
//    scrollView.anchorPoint = ccp(0,0);
//    scrollView.position = ccp(0, -10);
//    scrollView.horizontalScrollEnabled = NO;
//    scrollView.verticalScrollEnabled = YES;
//    scrollView.scrollPosition = CGPointZero;
//    [shader addChild: scrollView z:1000];
   // [self textViewShow:NO];
    });
}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
   prevTouchPoint = [self convertToNodeSpace:touch.locationInWorld];
}
-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint currentTouch = [self convertToNodeSpace:touch.locationInWorld];
    CGPoint pointMove = ccp(currentTouch.x - prevTouchPoint.x, currentTouch.y - prevTouchPoint.y);
    CGPoint newLocation = ccpAdd(background.position, pointMove);
    prevTouchPoint = currentTouch;
    if(newLocation.y + background.contentSize.height/2 < winSize.height )
    {
        newLocation.y =  background.position.y;
    }
    else if (newLocation.y - background.contentSize.height/2 > 0)
    {
        newLocation.y =  background.position.y;

    }
    if (newLocation.x + background.contentSize.width/2 < winSize.width)
    {
        newLocation.x =  background.position.x;
    }
    else if (newLocation.x - background.contentSize.width/2 > 0)
    {
         newLocation.x =  background.position.x;
    }
    
        background.position = newLocation;
    
    
}
-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [chosedStageAttrubites removeFromParentAndCleanup:YES];
}
-(void)stageCellClicked:(StageCell *)stageCell
{
//    GameMainScene* game = [[GameMainScene alloc]initWithModel:stageCell.myModel];
//    [[CCDirector sharedDirector]replaceScene:game withTransition:[CCTransition transitionFadeWithDuration:1]];
    [chosedStageAttrubites removeFromParentAndCleanup:YES];
    chosedStageAttrubites = [[StageAttributes alloc]initWithStageModel:stageCell.myModel];
    [self addChild:chosedStageAttrubites];
    chosedStageAttrubites.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    
}
-(void)stageChosed:(CCButton*)sender
{
    int index = [sender.name intValue];
    StageModels* thisStage = [[RealSourceManager shared].dailyStages objectAtIndex:index];
    GameMainScene* game = [[GameMainScene alloc]initWithModel:thisStage];
    [[CCDirector sharedDirector]replaceScene:game withTransition:[CCTransition transitionFadeWithDuration:1]];
}
@end
