//
//  RunningCharacter.m
//  RealWorldSurface
//
//  Created by Morris on 3/12/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import "RunningCharacter.h"

@implementation RunningCharacter
{
    BOOL isJumping;
    CCSprite* aniSprite;
}
- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.myView = [CCSprite spriteWithImageNamed:@"cat_run(5).png"];
       // self.myView.flipX = YES;
        isJumping = NO;
        [self addChild:self.myView];
        self.contentSize = size;//CGSizeMake(50, 50);
        self.myView.scaleX = size.width*1.3/self.myView.contentSize.width;
        self.myView.scaleY = size.height*1.05/self.myView.contentSize.height;
        self.myView.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        self.anchorPoint = ccp(0.5, 0.5);
    }
    return self;
}
-(void)onEnter
{
    [super onEnter];
    [self buildWaterDropAnimation];
    [self initCharacterData];
    [self buildSelfAnimation];
}

-(void)damaged:(int)damage
{
    self.hp -= damage;
    
}
-(void)healed:(int)heal
{
    self.hp += heal;
}
-(void)setHp:(int)hp
{
    _hp = hp;
    if(hp < 0 )
    {
        _hp = 0;
    }
    else if (hp > self.maxHp)
    {
        _hp = self.maxHp;
    }
}
-(void)buildSelfAnimation
{
    NSMutableArray* aniFrames = [NSMutableArray array];
    CCSprite* sp1 = [CCSprite spriteWithImageNamed:@"cat_run(1).png"];
    CCSprite* sp2 =[CCSprite spriteWithImageNamed:@"cat_run(2).png"];
    CCSprite* sp3 =[CCSprite spriteWithImageNamed:@"cat_run(3).png"];
    CCSprite* sp4 =[CCSprite spriteWithImageNamed:@"cat_run(4).png"];
    
    CCSprite* sp5 = [CCSprite spriteWithImageNamed:@"cat_run(5).png"];
    CCSprite* sp6 =[CCSprite spriteWithImageNamed:@"cat_run(6).png"];
    CCSprite* sp7 =[CCSprite spriteWithImageNamed:@"cat_run(7).png"];
    CCSprite* sp8 =[CCSprite spriteWithImageNamed:@"cat_run(8).png"];
    [aniFrames addObject:sp1.spriteFrame];
    [aniFrames addObject:sp2.spriteFrame];
    [aniFrames addObject:sp3.spriteFrame];
    [aniFrames addObject:sp4.spriteFrame];
     [aniFrames addObject:sp5.spriteFrame];
     [aniFrames addObject:sp6.spriteFrame];
     [aniFrames addObject:sp7.spriteFrame];
     [aniFrames addObject:sp8.spriteFrame];
    
    CCAnimation* animation = [CCAnimation animationWithSpriteFrames:aniFrames delay:0.2];
   // aniSprite = [CCSprite spriteWithImageNamed:@"Water_drop_1.png"];
    CCActionAnimate* actionAni = [CCActionAnimate actionWithAnimation:animation];
    CCActionRepeatForever* rp = [CCActionRepeatForever actionWithAction:actionAni];
   // aniSprite.scale = self.myView.scaleX*2;
    [self.myView runAction:rp];

}
-(void)buildWaterDropAnimation
{
    NSMutableArray* aniFrames = [NSMutableArray array];
    CCSprite* sp1 = [CCSprite spriteWithImageNamed:@"Water_drop_1.png"];
    CCSprite* sp2 =[CCSprite spriteWithImageNamed:@"Water_drop_2.png"];
    CCSprite* sp3 =[CCSprite spriteWithImageNamed:@"Water_drop_3.png"];
    CCSprite* sp4 =[CCSprite spriteWithImageNamed:@"Water_drop_4.png"];
    [aniFrames addObject:sp1.spriteFrame];
    [aniFrames addObject:sp2.spriteFrame];
    [aniFrames addObject:sp3.spriteFrame];
    [aniFrames addObject:sp4.spriteFrame];

    CCAnimation* animation = [CCAnimation animationWithSpriteFrames:aniFrames delay:0.2];
    aniSprite = [CCSprite spriteWithImageNamed:@"Water_drop_1.png"];
    CCActionAnimate* actionAni = [CCActionAnimate actionWithAnimation:animation];
    CCActionRepeatForever* rp = [CCActionRepeatForever actionWithAction:actionAni];
    aniSprite.scale = self.myView.scaleX*2;
    [aniSprite runAction:rp];
    [self addChild:aniSprite];
    aniSprite.position = ccp(self.contentSize.width, self.contentSize.height - 5);
   // CCActionAnimate* ani = [CCActionAnimate]
}
-(void)jump
{
    if(!isJumping)
    {
        isJumping = YES;
        aniSprite.visible = NO;
        CCActionJumpBy* jb = [CCActionJumpBy actionWithDuration:0.5 position:ccp(0, 0) height:100 jumps:1];
        [self runAction:jb];
        [self scheduleBlock:^(CCTimer* timer){
            isJumping = NO;
            aniSprite.visible = YES;
        }delay:0.5];
    }
}
-(void)initCharacterData;
{
    self.maxHp = 3;
    self.hp = self.maxHp;
    self.speed = 1;
    self.ammunition = 10;
    self.doubleJump = YES;
    self.invincible = NO;
    self.boostSpeed = NO;
    self.powerRege = NO;
}
@end
