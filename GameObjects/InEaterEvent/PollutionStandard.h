//
//  PollutionStandard.h
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface PollutionStandard : CCNode
- (instancetype)initWithSize:(CGSize)size;
-(void)die;
@property (nonatomic, readonly) BOOL alive;
@end
