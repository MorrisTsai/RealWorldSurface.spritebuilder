//
//  StageModels.m
//  RealWorldSurface
//
//  Created by Morris on 3/14/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "StageModels.h"
#import "VSConstant.h"
#import "RealSourceManager.h"
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
@synthesize waterPercentage = _waterPercentage;
@synthesize garbagePercentage = _garbagePercentage;
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
        
        self.locationX = [[attribute objectForKey:@"x"]doubleValue];
        self.locationY = [[attribute objectForKey:@"y"]doubleValue];
        
        self.isGarbageEnable = [[attribute objectForKey:@"garbage_active"]intValue];
        self.isWaterEnable = [[attribute objectForKey:@"water_active"]intValue];
        
        
        self.savedFish = [[attribute objectForKey:@"fish"]intValue];
        self.collectedGarbage = [[attribute objectForKey:@"garbage"]intValue];
        
        self.stageName = [attribute objectForKey:SubRegionName];
        self.type = self.isGarbageEnable*2 + self.isWaterEnable;
        self.prevSavedFish = self.savedFish;
        self.prevCollectedGarbage = self.collectedGarbage;
        self.prevCleanPercentage = [self cleanPercentage];
        
        
    }
    return self;
}
-(void)checkClean
{
    if([self cleanPercentage] >= 100)
    {
        [[RealSourceManager shared]addNewAllCleanLocation:self.stageName andPosition:ccp(self.locationX, self.locationY)];
    }
}
-(double)cleanPercentage
{
    return  (self.garbagePercentage+self.waterPercentage)*1.0/2;
}
-(int)savedFish
{
    NSString* key = [NSString stringWithFormat:@"%@SavedFish",self.stageName];
    int value = [[[NSUserDefaults standardUserDefaults]objectForKey:key]intValue];
    return value;
}
-(int)collectedGarbage
{
    NSString* key = [NSString stringWithFormat:@"%@CollectedGarbage",self.stageName];
    int value = [[[NSUserDefaults standardUserDefaults]objectForKey:key]intValue];
    return value;
}
-(void)setCollectedGarbage:(int)collectedGarbage
{
    NSString* key = [NSString stringWithFormat:@"%@CollectedGarbage",self.stageName];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",collectedGarbage] forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)setSavedFish:(int)savedFish
{
    NSString* key = [NSString stringWithFormat:@"%@SavedFish",self.stageName];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",savedFish] forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(int)waterPercentage
{
    if(!self.isWaterEnable)
    {
        return self.garbagePercentage;
    }
    NSString* key = [NSString stringWithFormat:@"%@Water",self.stageName];
    int value = [[[NSUserDefaults standardUserDefaults]objectForKey:key]intValue];
    return value;
}
-(int)garbagePercentage
{
    if(!self.isGarbageEnable)
    {
        return self.waterPercentage;
    }
    NSString* key = [NSString stringWithFormat:@"%@Garbage",self.stageName];
    int value = [[[NSUserDefaults standardUserDefaults]objectForKey:key]intValue];
    return value;

}
-(void)setWaterPercentage:(int)waterPercentage
{
    NSString* key = [NSString stringWithFormat:@"%@Water",self.stageName];
    _waterPercentage = waterPercentage;
    if(_waterPercentage > 100)
    {
        _waterPercentage = 100;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",_waterPercentage] forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self checkClean];
}
-(void)setGarbagePercentage:(int)garbagePercentage
{
    NSString* key = [NSString stringWithFormat:@"%@Garbage",self.stageName];
    _garbagePercentage = garbagePercentage;
    if(_garbagePercentage > 100)
    {
        _garbagePercentage = 100;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",_garbagePercentage] forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self checkClean];
}

-(NSString *)stageTypeString
{
    switch (self.type) {
        case StageType_Water:
            return @"Water";
            break;
        case StageType_Garbage:
            return @"Garbage";
            break;
        case StageType_Hybrid:
            return @"Hybrid";
            break;
        default:
            break;
    }
    return @"Unknown";
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
    int returnInt = (sqrt(ox*ni*ph*20)*10)*1.0/((101 - self.garbagePercentage)*0.01);
    returnInt = self.isWaterEnable ? returnInt : returnInt/2;
    return returnInt < 2 ? returnInt : 2;
}
-(int)pollutionConstant
{
    int returnValue = ((23 - sqrt(min+ max))/2)*1.0 / ((101 - self.waterPercentage)*0.01);
    return  (self.isGarbageEnable ? returnValue : returnValue / 2);
}
-(int)randNumberOfPOllutionNumbers
{
    int diff = (max - min)*1.0/5;
    int standard = 3;
    return arc4random()%(standard*diff);
    
}
@end
