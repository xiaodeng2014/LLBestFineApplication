//
//  LLBaseModel.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLBaseModel.h"
#import <YYModel.h>

@implementation LLBaseModel

+ (instancetype)modelWithJson:(id)json{
    return [self yy_modelWithJSON:json];
}

+ (NSArray *)modelArrayWithJson:(id)json{
    return [NSArray yy_modelArrayWithClass:[self class] json:json];
}


// 直接添加以下代码即可自动完成 (归档用)
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

- (NSUInteger)hash {
    return [self yy_modelHash];
}

- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}

- (NSString *)toJsonString{
    return [self yy_modelToJSONString];
}

- (id)toJsonObject{
    return [self yy_modelToJSONObject];
}

@end
