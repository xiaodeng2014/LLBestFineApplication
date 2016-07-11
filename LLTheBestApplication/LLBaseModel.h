//
//  LLBaseModel.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLBaseModel : NSObject<NSCoding, NSCopying>

/**
 *  根据json转模型
 *
 *  @param json json对象
 *
 *  @return 返回对象实例
 */
+ (instancetype)modelWithJson:(NSDictionary *)json;

/**
 *  根据json对象（json字符串或者NSDictionary）转成数组集合
 *
 *  @param json json字符串、NSDictionary
 *
 *  @return 返回一个装着模型的数组
 */
+ (NSArray *)modelArrayWithJson:(id)json;

/**
 *  把对象转成字符串
 *
 *  @return json字符串
 */
- (NSString *)toJsonString;

/**
 *  返回json对象
 *
 *  @return 把模型实例转成json对象
 */
- (id)toJsonObject;

@end
