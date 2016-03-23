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
    CCNodeColor* background;
}
- (instancetype)initWithSize:(CGSize)size andStageModel:(StageModels*)model;
{
    self = [super init];
    if (self) {
        self.contentSize = size;
        background = [CCNodeColor nodeWithColor:[CCColor greenColor] width:size.width height:size.height];
        [self addChild:background];
        self.anchorPoint = ccp(0.5, 0.5);
        background.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        self.myModel = model;
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
}
-(void)buildView
{
    
    CCLabelTTF* nameLabel  = [CCLabelTTF labelWithString:self.myModel.name fontName:nil fontSize:12];
    [self addChild:nameLabel];
    nameLabel.anchorPoint = ccp(0, 0.5);
    nameLabel.position = ccp(3, self.contentSize.height/2);
    
    
    CCLabelTTF* rate = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",self.myModel.pollutionConstant] fontName:nil fontSize:12];
    rate.anchorPoint = ccp(1, 0.5);
    [self addChild:rate];
    rate.position = ccp(self.contentSize.width - 2, 0);
    
}
@end

