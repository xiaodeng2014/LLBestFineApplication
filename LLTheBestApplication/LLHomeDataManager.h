//
//  LLHomeDataManager.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLHomeData;

typedef void (^LLHomeDataSuccess) (LLHomeData *homeData);
typedef void (^LLHomeDataFailure) (NSError *error);

@interface LLHomeDataManager : NSObject

+ (void)findHomeDataWithParams:(NSDictionary *)params header:(NSDictionary *)header callBackSuccess:(LLHomeDataSuccess)callBackSuccess callBackFailure:(LLHomeDataFailure)callBackFailure;

@end
