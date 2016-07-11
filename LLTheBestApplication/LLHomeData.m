//
//  LLHomeData.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLHomeData.h"

@implementation LLHomeData

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"apps" : [LLApp class]};
}

@end
