//
//  LLGlobalConfig.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//  获取单例对象

#import <Foundation/Foundation.h>

@interface LLGlobalConfig : NSObject

/**
 *  获取单例对象
 *
 *  @return 返回实例
 */
+ (instancetype)defaultConfig;

@property (nonatomic, strong) NSString *domain;                             //!<请求的主域名，比如https://www.baidu.com/
@property (nonatomic, strong, readonly) NSString *homeUrlString;            //!<首页的url请求地址
@property (nonatomic, strong, readonly) NSDictionary *defaultRequestParams; //!<默认的请求参数


@end
