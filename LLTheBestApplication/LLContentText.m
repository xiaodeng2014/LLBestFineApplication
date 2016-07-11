//
//  LLContentText.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/5.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLContentText.h"

@implementation LLContentText

- (instancetype)initWithContent:(NSString *)content tagName:(NSString *)tagName marginLeftAndRight:(CGFloat)marginLeftAndRight attributes:(NSMutableDictionary<NSString *, id> *)attributes{
    if (self = [super init]) {
        NSMutableDictionary *attr = attributes;
        if ([@"h2" isEqualToString:tagName]) {
            attr = [NSMutableDictionary dictionaryWithDictionary:attributes];
            attr[NSFontAttributeName] = [UIFont systemFontOfSize:18.0];
            attr[NSForegroundColorAttributeName] = RGBSimeValue(0);
            _marginY = 15;
        }
        _text = content;
        _attributes = attr;
        _textSize = [content boundingRectWithSize:CGSizeMake(LLScreenW - marginLeftAndRight * 2, HUGE) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    }
    return self;
}


@end
