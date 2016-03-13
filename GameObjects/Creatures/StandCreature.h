//
//  StandCreature.h
//  RealWorldSurface
//
//  Created by Morris on 3/13/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "StandardGameObject.h"

@interface StandCreature : StandardGameObject
@property CCSprite* myView;
- (instancetype)initWithSize:(CGSize)size;
- (void)die;

@end
