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
{
    BOOL playingScratch;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        playingScratch = NO;
    }
    return self;
}
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


-(void)buttonEffect
{
    
}
-(void)playMenuMusic
{
     [[OALSimpleAudio sharedInstance]playBg:@"mainMenu1.wav" loop:YES];
}
-(void)playMapMusic
{
    [[OALSimpleAudio sharedInstance]playBg:@"mainMenu2.wav" loop:YES];
}

-(void)jumpEffect
{
    [[OALSimpleAudio sharedInstance]playEffect:@"jump.wav"];
}
-(void)pickEffect
{
    [[OALSimpleAudio sharedInstance]playEffect:@"pick.wav"];
    
}
-(void)scratchEffect
{
    if(!playingScratch)
    {
        [[OALSimpleAudio sharedInstance]playEffect:@"scratch.mp3"];
        playingScratch = YES;
        [self scheduleBlock:^(CCTimer* timer){
            playingScratch = NO;
        }delay:0.2];
    }
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
