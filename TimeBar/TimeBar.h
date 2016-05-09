//
//  TimeBar.h
//  VicRun
//
//  Created by Morris on 9/05/2016.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface TimeBar : CCNode
- (instancetype)initWithSize:(CGSize)size;
-(void)setCatPositionWithCurrentTime:(int)currentTime andMaxTime:(int)maxTime;
@end
