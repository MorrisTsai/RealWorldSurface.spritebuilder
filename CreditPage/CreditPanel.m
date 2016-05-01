//
//  CreditPanel.m
//  RealWorldSurface
//
//  Created by Morris on 1/05/2016.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CreditPanel.h"

@implementation CreditPanel
{
    CCSprite* background;
}
- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.contentSize = size;
        self.anchorPoint = ccp(0.5,0.5);
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
    [self buildBackground];
    [self buildView];
}
-(void)buildBackground
{
    background = [CCSprite spriteWithImageNamed:@"ButtonBlue_T.png"];
    [self addChild:background];
    background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    background.scaleX = self.contentSize.width/background.contentSize.width;
    background.scaleY = self.contentSize.height/background.contentSize.height;
    
    CCSprite* logo = [CCSprite spriteWithImageNamed:@"Logo.png"];
    [self addChild:logo];
    logo.position = ccp(self.contentSize.width/2, self.contentSize.height*0.8);
    logo.scale /= 5;
    
}
-(void)buildView
{
    [self buildSelf];
    [self buildOthers];
}
-(void)buildSelf
{
    CCLabelTTF* nameLabel = [CCLabelTTF labelWithString:@"MENG LIN TSAI" fontName:@"AmericanTypewriter-CondensedBold" fontSize:13];
    CCLabelTTF* nameLabel2 = [CCLabelTTF labelWithString:@"Rizky Noor Ichwan" fontName:@"AmericanTypewriter-CondensedBold" fontSize:13];
    CCLabelTTF* nameLabel3 = [CCLabelTTF labelWithString:@"Ankit Rawat" fontName:@"AmericanTypewriter-CondensedBold" fontSize:13];
    CCLabelTTF* nameLabel4 = [CCLabelTTF labelWithString:@"Chenxue Zhao" fontName:@"AmericanTypewriter-CondensedBold" fontSize:13];
    CCLabelTTF* nameLabel5 = [CCLabelTTF labelWithString:@"Bing Yao" fontName:@"AmericanTypewriter-CondensedBold" fontSize:13];
    
    [self addChild:nameLabel];
    [self addChild:nameLabel2];
    [self addChild:nameLabel3];
    [self addChild:nameLabel4];
    [self addChild:nameLabel5];
    nameLabel.position = ccp(self.contentSize.width/4, self.contentSize.height*0.65);
    nameLabel2.position = ccpAdd(nameLabel.position,ccp(0, -nameLabel2.contentSize.height*1.1));
    nameLabel3.position = ccpAdd(nameLabel2.position,ccp(0, -nameLabel3.contentSize.height*1.1));
    nameLabel4.position = ccpAdd(nameLabel3.position,ccp(0, -nameLabel4.contentSize.height*1.1));
    nameLabel5.position = ccpAdd(nameLabel4.position,ccp(0, -nameLabel5.contentSize.height*1.1));

}
-(void)buildOthers
{
    CCLabelTTF* nameLabel = [CCLabelTTF labelWithString:@"Music (or Sound Effects)" fontName:@"AmericanTypewriter-CondensedBold" fontSize:8];
    CCLabelTTF* nameLabel2 = [CCLabelTTF labelWithString:@"Eric Matyas & freesound.org" fontName:@"AmericanTypewriter-CondensedBold" fontSize:10];
    CCLabelTTF* nameLabel3 = [CCLabelTTF labelWithString:@"&&" fontName:@"AmericanTypewriter-CondensedBold" fontSize:13];
    CCLabelTTF* nameLabel4 = [CCLabelTTF labelWithString:@"Icons" fontName:@"AmericanTypewriter-CondensedBold" fontSize:8];
    CCLabelTTF* nameLabel5 = [CCLabelTTF labelWithString:@"IconsPlace/GameArt2D/BSGStudio" fontName:@"AmericanTypewriter-CondensedBold" fontSize:10];
    
    [self addChild:nameLabel];
    [self addChild:nameLabel2];
    [self addChild:nameLabel3];
    [self addChild:nameLabel4];
    [self addChild:nameLabel5];
    nameLabel.position = ccp(self.contentSize.width*2.7/4, self.contentSize.height*0.65);
    nameLabel2.position = ccpAdd(nameLabel.position,ccp(0, -nameLabel2.contentSize.height*1.1));
    nameLabel3.position = ccpAdd(nameLabel2.position,ccp(0, -nameLabel3.contentSize.height*1.1));
    nameLabel4.position = ccpAdd(nameLabel3.position,ccp(0, -nameLabel4.contentSize.height*1.1));
    nameLabel5.position = ccpAdd(nameLabel4.position,ccp(0, -nameLabel5.contentSize.height*1.1));

}
@end
