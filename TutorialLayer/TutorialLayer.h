//
//  TutorialLayer.h
//  RealWorldSurface
//
//  Created by Morris on 4/19/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "StageModels.h"
@protocol TutorialLayerDelegate
-(void) tutorialEnd;
@end
@interface TutorialLayer : CCNode
- (instancetype)initWithMode:(StageType)type;
@property (nonatomic,weak) id<TutorialLayerDelegate>delegate;
@end
