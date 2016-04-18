//
//  StageCell.h
//  RealWorldSurface
//
//  Created by Morris on 3/21/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "StageModels.h"
@class StageCell;
@protocol StageCellDelegate
-(void)stageCellClicked:(StageCell*)stageCell;
@end
@interface StageCell : CCNode
- (instancetype)initWithSize:(CGSize)size andStageModel:(StageModels*)model;
@property StageModels* myModel;

@property (nonatomic, weak) id<StageCellDelegate>delegate;
@end
