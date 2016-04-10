//
//  SoundManager.h
//  RealWorldSurface
//
//  Created by Morris on 4/7/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface SoundManager : CCNode

-(void)playBackgroundMusic;
-(void)resumeBackgroundMusic;
-(void)pauseBackgroundMusic;



+(SoundManager*)shared;
@end
