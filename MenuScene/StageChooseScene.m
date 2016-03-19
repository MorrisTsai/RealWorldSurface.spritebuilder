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
    CGSize winSize;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        winSize = [CCDirector sharedDirector].viewSize;
        background = [CCSprite spriteWithImageNamed:@"bg1.png"];
        [self addChild:background];
        background.position = ccp(winSize.width/2,winSize.height/2);
    }
    return self;
}
-(void)onEnter
{
    
    [super onEnter];
    [self buildButtons];
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
@end
