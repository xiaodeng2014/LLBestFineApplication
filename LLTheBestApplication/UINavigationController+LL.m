//
//  UINavigationController+LL.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/8.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "UINavigationController+LL.h"

@implementation UINavigationController (LL)

- (UIViewController *)popCustomViewControllerAnimated:(BOOL)animated{
    return [self popViewControllerAnimated:animated];
}

@end
