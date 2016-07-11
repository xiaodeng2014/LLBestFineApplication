//
//  LLProgressHUD.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLProgressHUD.h"
#import "LLLoadingImageView.h"

@implementation LLProgressHUD

+ (void)showInView:(UIView *)view{
    if (!view) view = [UIApplication sharedApplication].keyWindow;
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[LLLoadingImageView class]]) {
            return;
        }
    }
    LLLoadingImageView *firstImgaeView = [LLLoadingImageView new];
    UIImage *loadingImage = [UIImage imageNamed:@"loading_1"];
    [firstImgaeView setImage:loadingImage];
    firstImgaeView.frame = CGRectMake(0, 0, loadingImage.size.width, loadingImage.size.height);
    firstImgaeView.center = view.center;
    [view addSubview:firstImgaeView];
    int imageCount = 16;
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:imageCount];
    for (int i = 1; i <= imageCount; ++i){
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", i]]];
    }
    [firstImgaeView setAnimationImages:imageArray];
    firstImgaeView.animationDuration = imageCount / 30.0;
    firstImgaeView.animationRepeatCount = HUGE;
    [firstImgaeView startAnimating];
}

+ (void)hideInView:(UIView *)view{
    if (!view) view = [UIApplication sharedApplication].keyWindow;
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[LLLoadingImageView class]]) {
            [subView removeFromSuperview];return;
        }
    }
}

@end
