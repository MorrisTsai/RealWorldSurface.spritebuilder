//
//  RealSourceManager.h
//  RealWorldSurface
//
//  Created by Morris on 4/2/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RealSourceManager : NSObject <NSXMLParserDelegate>
{
    NSOperationQueue* operationQueue;
}
@property (nonatomic,strong) NSArray* dailyStages;

#pragma mark Client Method
-(NSArray*)getSubRegionArrayByAreaId:(NSString*)areaId;
-(NSMutableArray *)getAll100PercentCleanLocation;
-(void)addNewAllCleanLocation:(NSString*)name andPosition:(CGPoint)position;


#pragma mark Server Method;
-(void)checkDataNumberFromServerWithCompletionHandler: (void (^)(BOOL errorMessage)) completionHandler;
-(void)listAllRegionFromServerWithCompletionHandler: (void (^)(BOOL errorMessage)) completionHandler;
-(void)listDataWithAreaId:(NSString*)areaId  withCompletionHandler: (void (^)(BOOL errorMessage)) completionHandler;
-(void)listDailyStageFromServerWithCompletionHandler: (void (^)(BOOL errorMessage)) completionHandler;
+(RealSourceManager*)shared;
@end
