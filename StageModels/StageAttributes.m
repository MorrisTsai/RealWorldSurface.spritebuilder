//
//  StageAttributes.m
//  RealWorldSurface
//
//  Created by Morris on 4/17/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "StageAttributes.h"
#import "GameMainScene.h"

@implementation StageAttributes
{
    CCSprite* background;
}

- (instancetype)initWithStageModel:(StageModels*)thisModel
{
    self = [super init];
    if (self) {
        self.myModel = thisModel;
        self.anchorPoint = ccp(0.5,0.5);
        self.contentSize = CGSizeMake(300, 200);
        self.myModel = thisModel;
        
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
     [self buildBackground];
    [self enterAnimation];
    
    
}
-(void)buildButton
{
    CCButton* goButton = [CCButton buttonWithTitle:@"Challenge"];
    [self addChild:goButton];
    goButton.position = ccp(self.contentSize.width/3, self.contentSize.height*0.2);
    [goButton setTarget:self selector:@selector(goButtonPressed)];
    
    
    CCButton* cancelButton = [CCButton buttonWithTitle:@"Cancel"];
    [self addChild:cancelButton];
    cancelButton.position = ccp(self.contentSize.width*2/3, self.contentSize.height*0.2);
    [cancelButton setTarget:self selector:@selector(cancelButtonPressed)];
    
    
}
-(void)goButtonPressed
{
    GameMainScene* game = [[GameMainScene alloc]initWithModel:self.myModel];
    [[CCDirector sharedDirector]replaceScene:game withTransition:[CCTransition transitionFadeWithDuration:1]];
    
}
-(void)cancelButtonPressed
{
    [self removeFromParentAndCleanup:YES];
}
-(void)enterAnimation
{
    self.scale = 0.7;
    CCActionScaleTo* st = [CCActionScaleTo actionWithDuration:0.3 scale:1.2];
    CCActionScaleTo* st2 = [CCActionScaleTo actionWithDuration:0.1 scale:1];
    CCActionCallBlock* cb = [CCActionCallBlock actionWithBlock:^(){
       [self buildAttribute];
        [self buildButton];
    }];
    CCActionSequence* seq = [CCActionSequence actions:st,st2,cb, nil];
    [self runAction:seq];
}
-(void)buildAttribute
{
  CCLabelTTF* titleLabel =  [CCLabelTTF labelWithString:self.myModel.stageName fontName:@"AmericanTypewriter-CondensedBold" fontSize:16];
    [self addChild:titleLabel];
    titleLabel.position = ccp(self.contentSize.width/2, self.contentSize.height*0.8);
    
    
    
    CCLabelTTF* typeLabel =  [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Stage Type: %@",self.myModel.stageTypeString] fontName:@"AmericanTypewriter-CondensedBold" fontSize:14];
    [self addChild:typeLabel];
    typeLabel.position = ccpAdd(titleLabel.position, ccp(0, -titleLabel.contentSize.height - typeLabel.contentSize.height/2));
    
    
    int rate =(((self.myModel.garbagePercentage+self.myModel.waterPercentage)/2)/25)*25;
    CCSprite* trophy = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"cleanRate%d.png",rate]];
    trophy.scale = self.contentSize.width/5 / trophy.contentSize.width;
    [self addChild:trophy];
    trophy.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
   
    CCLabelTTF* percentage = [CCLabelTTF labelWithString: [NSString stringWithFormat:@"%.2f%% Clean",(self.myModel.garbagePercentage+self.myModel.waterPercentage)*1.0/2] fontName:nil fontSize:14];
    [self addChild:percentage];
    percentage.position = ccp(self.contentSize.width/2, self.contentSize.height*0.3);
    
    
}

-(void)buildBackground
{
    
    background = [CCSprite spriteWithImageNamed:@"ButtonBlue_T.png"];
    [self addChild:background];
    background.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    background.scaleX = self.contentSize.width/background.contentSize.width;
    background.scaleY = self.contentSize.height/background.contentSize.height;
    
    
}
@end
