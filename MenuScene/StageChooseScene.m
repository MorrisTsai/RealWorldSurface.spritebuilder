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
#define MARGIN 7
#define TOP_MARGIN 14
@implementation StageChooseScene
{
    CCButton* gameButton;
    CCSprite* background;
    NSMutableArray* stagesArray;
    CGSize winSize;
    CCNode* contentNode;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        winSize = [CCDirector sharedDirector].viewSize;
        background = [CCSprite spriteWithImageNamed:@"green-forest-and-hills-background_PNG.png"];
        [self addChild:background];
        background.position = ccp(winSize.width/2,winSize.height/2);
        stagesArray = [NSMutableArray array];
    }
    return self;
}
-(void)onEnter
{
    
    [super onEnter];
    [self checkData];
   // [self buildStageList];
}
-(void)checkData
{
    [self showLoading];
    if(![RealSourceManager shared].regionArray)
    {
        
        [[RealSourceManager shared]listAllRegionFromServerWithCompletionHandler:^(BOOL ok)
         {
             [self buildRegion];
         }];
    }
    else
    {
        [self buildRegion];
    }

}
-(void)buildRegion
{
    [contentNode removeAllChildrenWithCleanup:YES];
    for(int i = 0 ; i < [[RealSourceManager shared].regionArray count];i++)
    {
        NSDictionary* thisArea = [[RealSourceManager shared].regionArray objectAtIndex:i];
        NSString* areaName = [thisArea objectForKey:AreaName];
        NSString* areaKey = [thisArea objectForKey:AreaKey];
        CCButton* thisButton = [CCButton buttonWithTitle:areaName fontName:nil fontSize:13];
        [contentNode addChild:thisButton];
        thisButton.position = ccp(contentNode.contentSize.width/2, (i+1)*(contentNode.contentSize.height/([[RealSourceManager shared].regionArray count]+1)));
        thisButton.name = areaKey;
        [thisButton setTarget:self selector:@selector(areaButtonPressed:)];
        
        
    }
}
-(void)showLoading
{
    [contentNode removeFromParentAndCleanup:YES];
    contentNode = [CCNodeColor nodeWithColor:[CCColor brownColor]];
    [self addChild:contentNode];
    contentNode.position = ccp(winSize.width/2, winSize.height/2);
    contentNode.contentSize = CGSizeMake(winSize.width/2, winSize.height/2);
    contentNode.anchorPoint = ccp(0.5, 0.5);
    CCLabelTTF* label = [CCLabelTTF labelWithString:@"Loading..." fontName:nil fontSize:20];
    [contentNode addChild:label];
    label.position = ccp(contentNode.contentSize.width/2, contentNode.contentSize.height/2);
}
-(void)areaButtonPressed:(CCButton*)sender;
{
    NSString* key = sender.name;
    [self showLoading];
    NSArray* subRegionInformation = [[[RealSourceManager shared]getSubRegionArrayByAreaId:key]mutableCopy];
    if([subRegionInformation count] == 0)
    {
        [[RealSourceManager shared]listDataWithAreaId:key withCompletionHandler:^(BOOL ok)
         {
             if(ok)
             {
                 [self areaButtonPressed:sender];
             }
         }];
    }
    else
    {
        for(int i = 0 ; i < [subRegionInformation count]; i ++)
        {
            NSDictionary* info = [subRegionInformation objectAtIndex:i];
            StageModels* model = [[StageModels alloc]initAttribute:info];
              [stagesArray addObject:model];
        }
        [self buildStageList];
    }
   
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
-(void)buildStageList
{
    [contentNode removeFromParentAndCleanup:YES];
    
    CCNode* scrollContent = [CCNode node];
    int height = 15;
    int space = 5;
    ScrollViewBoundaryShader* shader = [[ScrollViewBoundaryShader alloc]init];
    shader.contentSize = CGSizeMake(self.contentSize.width*0.9, self.contentSize.height*0.9);
    [self addChild:shader];
    shader.position = ccp(self.contentSize.width*0.1, self.contentSize.height*0.1);

    scrollContent.contentSize = CGSizeMake(contentNode.contentSize.width, ([stagesArray count]+2) * (height + space)*0.75);
    
    for(int i = 0 ; i < [stagesArray count]; i++)
    {
        
        StageModels* thisModel = [stagesArray objectAtIndex:i];
        CCButton* button = [CCButton buttonWithTitle:thisModel.stageName];
     //   button.position = ccp(self.contentSize.width/2, self.contentSize.height/2 + 20*i);
        button.name = [NSString stringWithFormat:@"%d",i];
     
        [button setTarget:self selector:@selector(stageChosed:)];
        
        button.position = ccp(button.contentSize.width/2 + MARGIN, scrollContent.contentSize.height - (i + 1) * (MARGIN + space));
        [scrollContent addChild:button];
      
    }
    
    
    CCScrollView* scrollView = [[CCScrollView alloc] initWithContentNode:scrollContent];
    scrollView.contentSizeType = CCSizeTypePoints;
    scrollView.contentSize = shader.contentSize;
    scrollView.anchorPoint = ccp(0,0);
    scrollView.position = ccp(0, -10);
    scrollView.horizontalScrollEnabled = NO;
    scrollView.verticalScrollEnabled = YES;
    scrollView.scrollPosition = CGPointZero;
    [shader addChild: scrollView z:1000];
   // [self textViewShow:NO];

    }
-(void)stageChosed:(CCButton*)sender
{
    int index = [sender.name intValue];
    StageModels* thisStage = [stagesArray objectAtIndex:index];
    GameMainScene* game = [[GameMainScene alloc]initWithModel:thisStage];
    [[CCDirector sharedDirector]replaceScene:game withTransition:[CCTransition transitionFadeWithDuration:1]];
}
@end
