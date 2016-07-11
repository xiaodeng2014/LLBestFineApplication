//
//  LLNavigationController.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//
#ifndef KEY_WINDOW
#define KEY_WINDOW [[UIApplication sharedApplication] keyWindow]
#endif

#ifndef kScreenW
#define kScreenW KEY_WINDOW.bounds.size.width
#endif

#ifndef kAnimateDuration
#define kAnimateDuration 0.5
#endif

#ifndef kDefaultAlapa
#define kDefaultAlapa 0.5
#endif

#ifndef kDefaultScale
#define kDefaultScale 0.95
#endif

#import "LLNavigationController.h"

@interface LLNavigationController ()

@property (nonatomic, strong) NSMutableArray *images;   //!<图片数组
@property (nonatomic, strong) UIView *backgroundView;   //!<背景
@property (nonatomic, strong) UIView *blankMaskView;    //!<面罩
@property (nonatomic, strong) UIImageView *imageView;   //!<imageView
@property (nonatomic, assign) CGPoint startPoint;       //!<开始接触点

@end

@implementation LLNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMove:)];
    [self.view addGestureRecognizer:pan];
}

- (void)panMove:(UIPanGestureRecognizer *)pan{
    if (self.viewControllers.count <= 1) return;
    CGRect vcFrame = self.view.frame;
    CGPoint location = [pan locationInView:KEY_WINDOW];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.startPoint = location;
        [self prepareView];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        CGFloat marginX = location.x - self.startPoint.x;
        marginX = marginX > kScreenW ? kScreenW : marginX;
        marginX = marginX < 0 ? 0 : marginX;
        vcFrame.origin.x = marginX;
        self.view.frame = vcFrame;
        
        CGFloat scale = kDefaultScale + marginX * 1.0 / 6400;
        scale = marginX == kScreenW ? 0.5 : scale;
        scale = marginX == 0 ? 0 : scale;
        self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
        
        CGFloat alpha = kDefaultAlapa - (1 - kDefaultAlapa) * marginX * 1.0 / kScreenW;
        alpha = marginX == kScreenW ? kDefaultAlapa : alpha;
        alpha = marginX == 0 ? 0 : alpha;
        self.blankMaskView.alpha = alpha;
    }else if (pan.state == UIGestureRecognizerStateEnded){
        CGFloat marginX = location.x - _startPoint.x;
        if (marginX > 50) {
            marginX = marginX > kScreenW ? kScreenW : marginX;
            CGFloat dur = kAnimateDuration - marginX * 1.0 / 2000;
            [UIView animateWithDuration:dur animations:^{
                [self changeFrameMaxWithView:self.view];
            } completion:^(BOOL finished) {
                [self finishPopDispose];
            }];
        }else{
            CGFloat marginX = location.x - self.startPoint.x;
            marginX = marginX > 50 ? 50 : marginX;
            marginX = marginX < 0 ? 0 : marginX;
            CGFloat dur = marginX * 1.0 / 500;
            [UIView animateWithDuration:0.1 + dur animations:^{
                [self changeFrameMinWithView:self.view];
            }];
        }
    }
}
- (void)finishPopDispose{
    [self.images removeLastObject];
    [self.backgroundView removeFromSuperview];
    [self changeFrameMinWithView:self.view];
    [super popViewControllerAnimated:NO];
}

- (void)prepareView{
    self.imageView.image = [self.images lastObject];
    [KEY_WINDOW insertSubview:self.backgroundView belowSubview:KEY_WINDOW.rootViewController.view];
    self.imageView.transform = CGAffineTransformMakeScale(kDefaultScale, kDefaultScale);
    self.blankMaskView.alpha = kDefaultAlapa;
}

- (void)changeFrameMaxWithView:(UIView *)view{
    CGRect selfF = view.frame;
    selfF.origin.x = KEY_WINDOW.bounds.size.width;
    view.frame = selfF;
    self.blankMaskView.alpha = 0;
    _imageView.transform = CGAffineTransformMakeScale(1, 1);
}

#pragma mark Frame调整最小
- (void)changeFrameMinWithView:(UIView *)view{
    CGRect selfF = view.frame;
    selfF.origin.x = 0;
    view.frame = selfF;
}

#pragma mark 创建背景
- (void)createBackgroundView{
    [self.images addObject:[self currentScreenImage]];
    if (!self.backgroundView) {
        self.backgroundView = [[UIView alloc] initWithFrame:KEY_WINDOW.bounds];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:KEY_WINDOW.bounds];
        self.imageView.backgroundColor = [UIColor clearColor];
        [self.backgroundView addSubview:_imageView];
        
        self.blankMaskView = [[UIView alloc] initWithFrame:KEY_WINDOW.bounds];
        self.blankMaskView.backgroundColor = [UIColor blackColor];
        self.blankMaskView.alpha = kDefaultAlapa;
        [self.backgroundView addSubview:self.blankMaskView];
    }
}

#pragma mark 获取当期屏幕截图
- (UIImage *)currentScreenImage{
    UIGraphicsBeginImageContextWithOptions(KEY_WINDOW.bounds.size, self.view.opaque, 0.0);
    [KEY_WINDOW.rootViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIViewController *)popCustomViewControllerAnimated:(BOOL)animated{
    [self prepareView];
    [UIView animateWithDuration:kAnimateDuration animations:^{
        [self changeFrameMaxWithView:self.view];
    } completion:^(BOOL finished) {
        [self finishPopDispose];
    }];
    return nil;
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    [self.images removeAllObjects];
    return [super popToRootViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        [self createBackgroundView];
    }
    [super pushViewController:viewController animated:animated];
}

- (NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

@end
