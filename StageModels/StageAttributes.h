//
//  StageAttributes.h
//  RealWorldSurface
//
//  Created by Morris on 4/17/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "StageModels.h"

@interface StageAttributes : CCNode
- (instancetype)initWithStageModel:(StageModels*)thisModel;
@property StageModels* myModel;
@end
