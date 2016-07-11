//
//  LLHttpUtil.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(id json);
typedef void (^Failure)(NSError *error);

@interface LLHttpUtil : NSObject

/**
 *  GET请求
 *
 *  @param url     请求的地址
 *  @param params  请求的参数
 *  @param header  请求头参数，没有就传nil
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)getWithURLString:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header success:(Success)success failure:(Failure)failure;

/**
 *  POST请求
 *
 *  @param url     请求的url
 *  @param params  请求的参数
 *  @param header  请求头参数，没有就传nil
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)postWithURLString:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header success:(Success)success failure:(Failure)failure;

@end
