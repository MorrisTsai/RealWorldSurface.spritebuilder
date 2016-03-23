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

@implementation StageChooseScene
{
    CCButton* gameButton;
    CCSprite* background;
    NSMutableArray* stagesArray;
    CGSize winSize;
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
    [self buildStageList];
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
    NSDictionary* dictionary = @{Maxima:@"9",Minumun:@"1",Half:@"4",@"Name":@"Ferny Creek upstream of confluence with Monbulk Ck, Knoxfield"};
    StageModels* model = [[StageModels alloc]initAttribute:dictionary];
    [stagesArray addObject:model];
    
    NSDictionary* dictionary2 = @{Maxima:@"56",Minumun:@"15",Half:@"26",@"Name":@"Dandenong Creek at Pillars Crossing, Dandenong South"};
    StageModels* model2 = [[StageModels alloc]initAttribute:dictionary2];
    [stagesArray addObject:model2];
    
    NSDictionary* dictionary3 = @{Maxima:@"140",Minumun:@"8",Half:@"39",@"Name":@"Corhanwarrabul Creek at Wellington Road, Rowville"};
    StageModels* model3 = [[StageModels alloc]initAttribute:dictionary3];
    [stagesArray addObject:model3];
    
    
    
    
    for(int i = 0 ; i < [stagesArray count]; i ++)
    {
        StageModels* thisModel = [stagesArray objectAtIndex:i];
        CCButton* button = [CCButton buttonWithTitle:thisModel.stageName];
        button.position = ccp(self.contentSize.width/2, self.contentSize.height/2 + 20*i);
        button.name = [NSString stringWithFormat:@"%d",i];
        [self addChild:button];
        [button setTarget:self selector:@selector(stageChosed:)];
    }
}
-(void)stageChosed:(CCButton*)sender
{
    int index = [sender.name intValue];
    StageModels* thisStage = [stagesArray objectAtIndex:index];
    GameMainScene* game = [[GameMainScene alloc]initWithModel:thisStage];
    [[CCDirector sharedDirector]replaceScene:game withTransition:[CCTransition transitionFadeWithDuration:1]];
}
@end
