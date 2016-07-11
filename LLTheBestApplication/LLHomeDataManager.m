//
//  LLHomeDataManager.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLHomeDataManager.h"
#import "LLHomeData.h"
#import "LLHttpUtil.h"
#import "LLGlobalConfig.h"

@implementation LLHomeDataManager

+ (void)findHomeDataWithParams:(NSDictionary *)params
                        header:(NSDictionary *)header
               callBackSuccess:(LLHomeDataSuccess)callBackSuccess
               callBackFailure:(LLHomeDataFailure)callBackFailure{
    NSString *urlString = [LLGlobalConfig defaultConfig].homeUrlString;
    [LLHttpUtil getWithURLString:urlString
                          params:params
                          header:header
                         success:^(NSDictionary *json) {
        if (!json || ![json isKindOfClass:[NSDictionary class]]) {
            if (callBackSuccess) {
                callBackSuccess(nil);
            }
            return;
        }
        if (callBackSuccess) {
            LLHomeData *homeData = [LLHomeData modelWithJson:json[@"data"]];
            callBackSuccess(homeData);
        }
    } failure:^(NSError *error) {
        if (callBackFailure) {
            callBackFailure(error);
        }
    }];
}

@end
