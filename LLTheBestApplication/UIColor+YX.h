//
//  UIView+LL.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/7.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YX)

/**
 *  根据颜色值字符串返回对应的颜色
 *
 *  @param colorstring 颜色字符串，带不带#号都可以
 *
 *  @return 返回对应字符串颜色对象，如果颜色字符串表示格式不正确，将返回[UIColor clearColor]
 */
+ (UIColor *)colorWithColorString:(NSString *)colorstring;

/**
 *  根据颜色和尺寸生成图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return 图片对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  根据颜色、内嵌文字来生成图片
 *
 *  @param color       颜色
 *  @param size        尺寸
 *  @param innerString 内嵌文字
 *  @param attributes  文字样式attribute
 *
 *  @return 返回图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size innerString:(NSString *)innerString attributes:(NSDictionary<NSString *, id> *)attributes;
@end
