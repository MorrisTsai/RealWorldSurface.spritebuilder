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
    CCSprite* fishSprite ;
    CCSprite* garbageSprite;
    CCLabelTTF* fishCountLabel;
    CCLabelTTF* garbageCountlabel;
    CCLabelTTF* percentage;
}

- (instancetype)initWithStageModel:(StageModels*)thisModel
{
    self = [super init];
    if (self) {
        self.myModel = thisModel;
        self.anchorPoint = ccp(0.5,0.5);
        self.contentSize = CGSizeMake(350, 270);
        self.myModel = thisModel;
        [self setUserInteractionEnabled:YES];
        
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
    CCButton* goButton = [CCButton buttonWithTitle:@"GO!"];
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
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
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
        [self checkCompleteAniamtion];
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
    trophy.position = ccp(self.contentSize.width*0.3, self.contentSize.height/2);
   
    percentage = [CCLabelTTF labelWithString: [NSString stringWithFormat:@"%.2f%% Clean",[self.myModel cleanPercentage]] fontName:nil fontSize:14];
    [self addChild:percentage];
    percentage.position = ccp(self.contentSize.width*0.3, self.contentSize.height*0.3);
    
    
    
    fishSprite= [CCSprite spriteWithImageNamed:@"Mud_Fish.png"];
    garbageSprite = [CCSprite spriteWithImageNamed:@"trubbish.png"];
    
    fishSprite.scale = 55/fishSprite.contentSize.width;
    garbageSprite.scale = 40 /garbageSprite.contentSize.width;
    
    
    [self addChild:fishSprite];
    [self addChild:garbageSprite];
    fishSprite.position = ccp(self.contentSize.width*0.7, self.contentSize.height*0.6);
    garbageSprite.position = ccp(self.contentSize.width*0.7, self.contentSize.height*0.4);
    fishCountLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",self.myModel.savedFish] fontName:nil fontSize:12];
    
    garbageCountlabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",self.myModel.collectedGarbage] fontName:nil fontSize:12];
    
    [self addChild:fishCountLabel];
    [self addChild:garbageCountlabel];
    fishCountLabel.position =ccp(self.contentSize.width*0.7, self.contentSize.height*0.5);
    garbageCountlabel.position = ccp(self.contentSize.width*0.7, self.contentSize.height*0.3);
    
    
    if(!self.myModel.isWaterEnable)
    {
        garbageSprite.position = ccp(self.contentSize.width*0.7, self.contentSize.height*0.5);
        garbageCountlabel.position = ccp(self.contentSize.width*0.7, self.contentSize.height*0.4);
        [fishCountLabel removeFromParentAndCleanup:YES];
        [fishSprite removeFromParentAndCleanup:YES];
    }
    else if(!self.myModel.isGarbageEnable)
    {
        fishSprite.position = ccp(self.contentSize.width*0.7, self.contentSize.height*0.5);
        fishCountLabel.position = ccp(self.contentSize.width*0.7, self.contentSize.height*0.4);
        [garbageCountlabel removeFromParentAndCleanup:YES];
        [garbageSprite removeFromParentAndCleanup:YES];

    }
}
-(void)checkCompleteAniamtion
{
    if(self.myModel.prevSavedFish < self.myModel.savedFish)
    {
        [self animteLabel:fishCountLabel fromStart:self.myModel.prevSavedFish to:self.myModel.savedFish];
    }
    if(self.myModel.prevCollectedGarbage < self.myModel.collectedGarbage)
    {
        [self animteLabel:garbageCountlabel fromStart:self.myModel.prevCollectedGarbage to:self.myModel.collectedGarbage];
    }
    self.myModel.prevCollectedGarbage = self.myModel.collectedGarbage;
    self.myModel.prevSavedFish = self.myModel.savedFish;
}
-(void)animteLabel:(CCLabelTTF*)label fromStart:(int)start to:(int)to
{
  __block CCLabelTTF* blockLabel = label;
    label.string = [NSString stringWithFormat:@"%d",start];
    int diff = to - start;
    
    
    for(int i = 0 ; i < diff; i ++)
    {
        [self scheduleBlock:^(CCTimer* timer){
            blockLabel.string = [NSString stringWithFormat:@"%d",start + i + 1];
        }delay:2.0*i*1.0/diff];
    }
    
    [self scheduleBlock:^(CCTimer* timer){
        label.string = [NSString stringWithFormat:@"%d",to];
    }delay:1.1];
    
    
    
    
    
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
