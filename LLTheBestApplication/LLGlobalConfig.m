//
//  LLGlobalConfig.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLGlobalConfig.h"

static id _sharedObj = nil;

@implementation LLGlobalConfig

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObj = [super allocWithZone:zone];
    });
    return _sharedObj;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObj = [super init];
    });
    return _sharedObj;
}

+ (instancetype)defaultConfig{
    if (_sharedObj == nil) {
        _sharedObj = [[self alloc] init];
    }
    return _sharedObj;
}

- (id)copyWithZone:(NSZone *)zone{
    return _sharedObj;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return _sharedObj;
}

+ (id)copyWithZone:(struct _NSZone *)zone{
    return _sharedObj;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return _sharedObj;
}

- (NSString *)homeUrlString{
    return [self.domain stringByAppendingString:@"api/apps/app/daily"];
}

- (NSString *)domain{
    if (!_domain.length) {
        _domain = [NSString stringWithFormat:@"http://zuimeia.com/"];
    }
    return _domain;
}

- (NSDictionary *)defaultRequestParams{
    return @{@"appVersion" : [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey],
             @"openUDID" : @"d41d8cd98f00b204e9800998ecf8427ee0178597",
             @"page_size" : @"20",
             @"platform" : @"1",
             @"resolution" : NSStringFromCGSize([UIScreen mainScreen].bounds.size),
             @"systemVersion" : [UIDevice currentDevice].systemVersion,
             @"page" : @(1)};
}

@end
