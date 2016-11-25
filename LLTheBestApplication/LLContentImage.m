//
//  LLContentImage.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/5.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLContentImage.h"

@implementation LLContentImage

- (instancetype)initWithWith:(CGFloat)width height:(CGFloat)height imageUrl:(NSString *)imageUrl marginLeft:(CGFloat)marginLeft{
    if (self = [super init]) {
        self.width = width;
        self.height = height;
        self.imageUrl = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _realWidth = LLScreenW - marginLeft * 2;
        if (self.width >= 0.1) {
            _realHeight = self.height * _realWidth / self.width;
        }
        
    }
    return self;
}

@end
