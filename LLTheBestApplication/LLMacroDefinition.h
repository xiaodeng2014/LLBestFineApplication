//
//  LLMacroDefinition.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/23.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#ifndef LLMacroDefinition_h
#define LLMacroDefinition_h

//1.弱、强引用控制器
#define kWeakQuoteController(weakSelf) __weak __typeof(self) weakSelf = self
#define kStrongQuoteController(strongSelf, weakSelf) __strong __typeof(weakSelf) strongSelf = weakSelf

//2.打印
#ifndef LLDevLog
#ifdef DEBUG
#define LLDevLog(...) NSLog(__VA_ARGS__)
#else
#define LLDevLog(...) do { } while (0)
#endif
#endif //LLDevLog

//3.屏幕的宽高
#define LLScreenW [UIScreen mainScreen].bounds.size.width
#define LLScreenH [UIScreen mainScreen].bounds.size.height

//4.RGB
#define RGB(r, g, b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBSimeValue(rgb)   [UIColor colorWithRed:rgb/255.0 green:rgb/255.0 blue:rgb/255.0 alpha:1.0]
#define RGBA(r, g, b, a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#endif

