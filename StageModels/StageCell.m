//
//  StageCell.m
//  RealWorldSurface
//
//  Created by Morris on 3/21/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "StageCell.h"

@implementation StageCell
{
    CCSprite* background;
    CCSprite* border;
}
- (instancetype)initWithSize:(CGSize)size andStageModel:(StageModels*)model;
{
    self = [super init];
    if (self) {
        self.contentSize = size;
        int rate =(((model.garbagePercentage+model.waterPercentage)/2)/25)*25;
        background = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"cleanRate%d.png",rate]];
        [self addChild:background z:-1];
        self.anchorPoint = ccp(0.5, 0.5);
        background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        self.myModel = model;
        background.scale = size.width/background.contentSize.width;
        [self setUserInteractionEnabled:YES];
        
        border = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"cleanRate%dBorder.png",rate]];
        [self addChild:border z:-2];
        border.position = background.position;
        border.scale = background.scale*1.1;
        
      
      
        
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
    [self buildView];
    [self borderChangeColor];
    [self scaleSeq];
    
}
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [self scheduleBlock:^(CCTimer* timer){
        [self checkShow];
    }delay:0.5];
}
-(void)checkShow
{
    if(self.myModel.prevCollectedGarbage != self.myModel.collectedGarbage ||
       self.myModel.prevSavedFish != self.myModel.savedFish)
    {
        [self.delegate stageCellClicked:self];
    }
}
-(void)scaleSeq
{
    CCActionScaleTo* st1 = [CCActionScaleTo actionWithDuration:0.8 scale:0.9];
    CCActionScaleTo* st2 = [CCActionScaleTo actionWithDuration:0.8 scale:1.1];
    CCActionSequence* seq = [CCActionSequence actions:st1,st2, nil];
    CCActionRepeatForever* fr = [CCActionRepeatForever actionWithAction:seq];
    [self runAction:fr];

    
}
-(void)onExit
{
    [self unschedule:@selector(borderChangeColor)];
    [super onExit];
}
-(void)borderChangeColor
{
    CCActionTintTo* tt = [CCActionTintTo actionWithDuration:1 color:[CCColor colorWithCcColor3b:ccc3(arc4random()%256,arc4random()%256,arc4random()%256)]];
    [border runAction:tt];
    [self scheduleOnce:@selector(borderChangeColor) delay:1];
}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    
    
}
-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self.delegate stageCellClicked:self];
}
-(void)buildView
{
    
//    CCLabelTTF* nameLabel  = [CCLabelTTF labelWithString:self.myModel.stageName fontName:nil fontSize:12];
//    [self addChild:nameLabel];
//    nameLabel.anchorPoint = ccp(0, 0.5);
//    nameLabel.position = ccp(3, self.contentSize.height/2);
    
    
//    CCLabelTTF* rate = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",self.myModel.pollutionConstant] fontName:nil fontSize:12];
//    rate.anchorPoint = ccp(1, 0.5);
//    [self addChild:rate];
//    rate.position = ccp(self.contentSize.width - 2, 0);
    
}
@end

