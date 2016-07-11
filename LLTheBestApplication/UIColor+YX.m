//
//  UIView+LL.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/7.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "UIColor+YX.h"

@implementation UIColor (YX)

+ (UIColor *)colorWithColorString:(NSString *)colorstring{
    if (colorstring.length < 6) return [UIColor clearColor];
    if (![colorstring hasPrefix:@"#"]) {
        colorstring = [NSString stringWithFormat:@"#%@", colorstring];
    }
    if (colorstring.length != 7) return [UIColor clearColor];
    NSString *colorstr = [colorstring substringFromIndex:1];
    if (![self isLegal:colorstr]) return [UIColor clearColor];
    
    // 转换成标准16进制数
    long colorLong = strtoul([[NSString stringWithFormat:@"0x%@", colorstr] cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    
    int R = (colorLong & 0xFF0000 )>> 16;
    int G = (colorLong & 0x00FF00 )>> 8;
    int B = colorLong & 0x0000FF;
    
    UIColor *wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    
    return wordColor;
}

+ (BOOL)isLegal:(NSString *)colorstr{
    NSString * regex = @"^[A-Fa-f0-9]{6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:colorstr];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    return [self imageWithColor:color size:size innerString:nil attributes:nil];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size innerString:(NSString *)innerString attributes:(NSDictionary<NSString *, id> *)attributes{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    if (innerString.length && attributes) {
        CGSize stringSize = [innerString sizeWithAttributes:attributes];
        stringSize.width = MIN(stringSize.width, size.width);
        CGRect stringRect = CGRectMake((size.width - stringSize.width) * 0.5, (size.height - stringSize.height) * 0.5, stringSize.width, stringSize.height);
        [innerString drawInRect:stringRect withAttributes:attributes];
    }
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
