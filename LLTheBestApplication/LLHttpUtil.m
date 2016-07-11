//
//  LLHttpUtil.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLHttpUtil.h"
#import <AFNetworking.h>

@implementation LLHttpUtil

+ (void)postWithURLString:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header success:(Success)success failure:(Failure)failure{
    [self requestWithMethod:@"POST" url:url params:params header:header success:success failure:failure];
}

+ (void)getWithURLString:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header success:(Success)success failure:(Failure)failure{
    [self requestWithMethod:@"GET" url:url params:params header:header success:success failure:failure];
}

+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header success:(Success)success failure:(Failure)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
#if DEBUG
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
#endif
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    for (NSString *key in header) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    if ([@"POST" isEqualToString:method]) {
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
#if DEBUG
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                LLDevLog(@"back Network Data = %@ -- %@", str, url);
#endif
                success(json);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }else if ([@"GET" isEqualToString:method]){
        [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if (success) {
#if DEBUG
                NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                LLDevLog(@"back Network Data = %@ -- %@", str, url);
#endif
                success(json);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
