//
//  LLContentImage.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/5.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLContentImage : NSObject

@property (nonatomic, assign) CGFloat width;                //!<原始的宽度
@property (nonatomic, assign) CGFloat height;               //!<原始的高度
@property (nonatomic, assign, readonly) CGFloat realWidth;            //!<要展示的宽度
@property (nonatomic, assign, readonly) CGFloat realHeight;           //!<要展示的高度
@property (nonatomic, copy) NSString *imageUrl;             //!<图片的链接

/**
 *  快速创建LLContentImage对象
 *
 *  @param width      图片的宽度
 *  @param height     图片的高度
 *  @param imageUrl   链接
 *  @param marginLeft 距离边缘的间隙，用于计算显示的真实尺寸
 *
 *  @return 对象
 */
- (instancetype)initWithWith:(CGFloat)width height:(CGFloat)height imageUrl:(NSString *)imageUrl marginLeft:(CGFloat)marginLeft;

@end
