//
//  StageModels.h
//  RealWorldSurface
//
//  Created by Morris on 3/14/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
typedef enum StageType
{
    StageType_Water = 1,
    StageType_Garbage = 2,
    StageType_Hybrid = 3
}StageType;
@interface StageModels : CCNode

- (instancetype)initAttribute:(NSDictionary*)attribute;
@property NSString* stageName;
@property (nonatomic, readonly) int creatureConstant;
@property (nonatomic, readonly) int obstacleConstant;
@property (nonatomic, readonly) int pollutionConstant;
@property (nonatomic, readonly) int garbageConstant;

@property double locationX;
@property double locationY;
@property BOOL isWaterEnable;
@property BOOL isGarbageEnable;
@property StageType type;
@property (nonatomic,readonly) NSString* stageTypeString;
@property (nonatomic) int waterPercentage;
@property (nonatomic) int garbagePercentage;
-(int)randNumberOfPOllutionNumbers;
@end
