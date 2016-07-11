//
//  LLApp.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLApp.h"

@implementation LLApp


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"app_id" : @"id",
             @"commentData" : @"comments"};
}

@end
