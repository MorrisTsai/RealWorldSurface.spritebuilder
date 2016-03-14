//
//  MenuScene.m
//  RealWorldSurface
//
//  Created by Morris on 3/14/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "MenuScene.h"
#import "GameMainScene.h"

@implementation MenuScene
{
    CCSprite* background ;
    CGSize winSize;
    CCButton* gameButton;
    CCButton* shopButton;
    CCButton* leaderboardButton;
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
-(void)buildButtons
{
    gameButton = [CCButton buttonWithTitle:@"Start" fontName:nil fontSize:20];
    [self addChild:gameButton];
    gameButton.position = ccp(winSize.width/2, winSize.height/2);
    [gameButton setTarget:self selector:@selector(gameButtonPressed)];
}
-(void)gameButtonPressed
{
    [[CCDirector sharedDirector]replaceScene:[GameMainScene node] withTransition:[CCTransition transitionFadeWithDuration:2]];
}



@end
