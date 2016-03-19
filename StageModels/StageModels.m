//
//  StageModels.m
//  RealWorldSurface
//
//  Created by Morris on 3/14/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "StageModels.h"
#import "VSConstant.h"
@implementation StageModels
{
    int min;
    int quarter;
    int half;
    int threeQ;
    int max;
}

- (instancetype)initAttribute:(NSDictionary*)attribute;
{
    self = [super init];
    if (self) {
        min = [[attribute objectForKey:Minumun]intValue];
        quarter = [[attribute objectForKey:Quarter]intValue];
        half = [[attribute objectForKey:Half]intValue];
        threeQ = [[attribute objectForKey:ThreeQ]intValue];
        max = [[attribute objectForKey:Maxima]intValue];
        self.stageName = [attribute objectForKey:@"Name"];
    }
    return self;
}
-(int)creatureConstant
{
    return 10;
}
-(int)obstacleConstant
{
    return 4;
}
-(int)pollutionConstant
{
    return  20 - sqrt(min+ max);
}
-(int)randNumberOfPOllutionNumbers
{
    int diff = (max - min)*1.0/5;
    int standard = 3;
    return arc4random()%(standard*diff);
    
}
@end
