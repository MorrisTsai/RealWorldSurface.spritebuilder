//
//  GameMainController.h
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "GameMainScene.h"
#import "StandardGameObject.h"

@interface GameMainController : CCNode
-(void)registerObjects:(NSArray*)objects;
-(void)registerObject:(StandardGameObject*)object;
-(void)registerGameMainScene:(GameMainScene*)gameMainScene;
-(void)gameStart;
-(void)gameEnd;
-(void)unregisterObject:(StandardGameObject*)object;
-(void)removeGarbage;
-(void)worldNextFrame;
-(void)gamePause;
-(void)gameResume;




+(GameMainController*)shared;
@end
