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
-(void)playMapMusic;

-(void)playMenuMusic;

-(void)jumpEffect;
-(void)buttonEffect;
-(void)pickEffect;
-(void)scratchEffect;

+(SoundManager*)shared;
@end
