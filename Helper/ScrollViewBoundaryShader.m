//
//  ScrollViewBoundaryShader.m
//  PixelStarships
//
//  Created by Morris on 2/2/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "ScrollViewBoundaryShader.h"
#import "CCDirector.h"

@implementation ScrollViewBoundaryShader



-(void)visit:(CCRenderer *)renderer parentTransform:(const GLKMatrix4 *)parentTransform
{
    // Calculate world positions and get contentScaleFactor
    CGPoint worldPosition = [self convertToWorldSpace:CGPointZero];
    CGFloat s = [[CCDirector sharedDirector] contentScaleFactor];
    
    // Enable scissor test and clip by content size
    [renderer enqueueBlock:^{
        glEnable(GL_SCISSOR_TEST);
        glScissor((worldPosition.x*s), ((worldPosition.y + 5)*s), (self.contentSizeInPoints.width*self.parent.scale*s), ((self.contentSizeInPoints.height - 20)*self.parent.scale*s));
    } globalSortOrder:0 debugLabel:nil threadSafe:YES];
    
    // Call parents visit
    [super visit:renderer parentTransform:parentTransform];
    
    // Disable scissor test
    [renderer enqueueBlock:^{
        glDisable(GL_SCISSOR_TEST);
    } globalSortOrder:0 debugLabel:nil threadSafe:YES];
}
@end
