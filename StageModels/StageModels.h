//
//  StageModels.h
//  RealWorldSurface
//
//  Created by Morris on 3/14/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface StageModels : CCNode

- (instancetype)initAttribute:(NSDictionary*)attribute;
@property NSString* stageName;
@property (nonatomic, readonly) int creatureConstant;
@property (nonatomic, readonly) int obstacleConstant;
@property (nonatomic, readonly) int pollutionConstant;
@property (nonatomic, readonly) int garbageConstant;
-(int)randNumberOfPOllutionNumbers;
@end
