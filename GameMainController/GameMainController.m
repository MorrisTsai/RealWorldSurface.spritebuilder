//
//  GameMainController.m
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "GameMainController.h"
#import "StandardGameObject.h"
static GameMainController* sharedController;
@implementation GameMainController
{
    NSMutableArray* allObject;
    NSMutableArray* garbageObjects;
    GameMainScene* mainScene;
    
    int gameCounter;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        allObject = [NSMutableArray array];
        garbageObjects = [NSMutableArray array];
        gameCounter = 0;
    }
    return self;
}
-(void)registerObjects:(NSArray*)objects
{
    [allObject addObjectsFromArray:objects];
}
-(void)registerObject:(StandardGameObject*)object
{
    [allObject addObject:object];
}
-(void)registerGameMainScene:(GameMainScene*)gameMainScene
{
    mainScene = gameMainScene;
}
-(void)gameStart
{
    gameCounter = 0;
    [self schedule:@selector(worldNextFrame) interval:0.01];
}
-(void)gameEnd
{
    [self unschedule:@selector(worldNextFrame)];
}
-(void)unregisterObject:(StandardGameObject*)object
{
    [garbageObjects addObject:object];
}
-(void)removeGarbage
{
    [allObject removeObjectsInArray:garbageObjects];
    for(StandardGameObject* thisObject in allObject)
    {
        [thisObject removeFromParentAndCleanup:YES];
    }
    [garbageObjects removeAllObjects];
}
-(void)worldNextFrame
{
    [self removeGarbage];
    [mainScene frameTick];
    for(int i = 0 ;  i < [allObject count];i++)
    {
        StandardGameObject* object  = [allObject objectAtIndex:i];
        [object nextFrame];
    }
}

+(GameMainController *)shared
{
    if(!sharedController)
    {
        sharedController = [[GameMainController alloc]init];
    }
    return sharedController;
}
@end
