//
//  LLContentText.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/5.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLContentText : NSObject

@property (nonatomic, copy) NSString *text;                     //!<文字内容
@property (nonatomic, assign, readonly) CGSize textSize;        //!<文字尺寸
@property (nonatomic, strong, readonly) NSDictionary<NSString *, id> *attributes;
@property (nonatomic, assign) CGFloat marginY;                  //!<间距

- (instancetype)initWithContent:(NSString *)content tagName:(NSString *)tagName marginLeftAndRight:(CGFloat)marginLeftAndRight attributes:(NSMutableDictionary<NSString *, id> *)attributes;

@end
