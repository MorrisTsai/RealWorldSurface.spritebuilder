//
//  SoundManager.m
//  RealWorldSurface
//
//  Created by Morris on 4/7/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "SoundManager.h"
static SoundManager* sharedManager;
@implementation SoundManager


-(void)playBackgroundMusic
{
     [[OALSimpleAudio sharedInstance]playBg:@"Monkey-Island-Band_Looping.mp3" loop:YES];
}
-(void)pauseBackgroundMusic
{
    [OALSimpleAudio sharedInstance].bgPaused = YES;
}
-(void)resumeBackgroundMusic
{
    [OALSimpleAudio sharedInstance].bgPaused = NO;
}






+(SoundManager *)shared
{
    if(!sharedManager)
    {
        sharedManager = [[SoundManager alloc]init];
    }
    return sharedManager;
}

@end
