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
    
    
    
    double ni;
    double ox;
    double ph;
}

- (instancetype)initAttribute:(NSDictionary*)attribute;
{
    self = [super init];
    if (self) {
        min = [[attribute objectForKey:Minumun]intValue];
       // quarter = [[attribute objectForKey:Quarter]intValue];
        half = [[attribute objectForKey:Half]intValue];
        //threeQ = [[attribute objectForKey:ThreeQ]intValue];
        max = [[attribute objectForKey:Maxima]intValue];
        
        ni = [[attribute objectForKey:Ni50]doubleValue];
        ox = [[attribute objectForKey:Ox50]doubleValue];
        ph = [[attribute objectForKey:Ph50]doubleValue];
        self.stageName = [attribute objectForKey:SubRegionName];
    }
    return self;
}
-(int)creatureConstant
{
    return 10;
}
-(int)obstacleConstant
{
    return self.garbageConstant + 4;
}
-(int)garbageConstant
{
    int returnInt =ox*ni*ph*20;
    return returnInt < 2 ? returnInt : 2;
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
