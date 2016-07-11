//
//  UIView+LL.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/7.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "UIView+LL.h"
#import <objc/runtime.h>

@implementation UIView (LL)

- (UIView *)ll_duplicate{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSData *layerData = [NSKeyedArchiver archivedDataWithRootObject:self.layer];
    UIView *view = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    CALayer *layer = [NSKeyedUnarchiver unarchiveObjectWithData:layerData];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self.layer class], &count);
    for (int i = 0; i < count; ++i) {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [view.layer setValue:[layer valueForKey:name] forKey:name];
    }
    return view;
}

@end
