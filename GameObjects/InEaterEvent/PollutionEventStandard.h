//
//  PollutionEventStandard.h
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "StandardGameObject.h"
#import "StandCreature.h"

@interface PollutionEventStandard : StandardGameObject
- (instancetype)initWithSize:(CGSize)size andNumber:(int)numbers;
- (BOOL)creatrueCollide:(StandCreature*)creature;
@end
