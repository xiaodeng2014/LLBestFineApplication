//
//  LLRefreshView.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/27.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLRefreshView.h"

NSString *const LLFreshPathContentOffset = @"contentOffset";
NSString *const LLFreshPathContentSize = @"contentSize";
NSString *const LLFreshPathPanState = @"state";

@interface LLRefreshView()

@property (weak, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) LLFreshViewType freshType;
@property (assign, nonatomic) CGFloat bottomOffset;
@property (assign, nonatomic) CGSize viewSize;
@property (assign, nonatomic) LLFreshState freshState;

@end

@implementation LLRefreshView

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView freshViewType:(LLFreshViewType)freshViewType{
    if (self = [super init]) {
        self.bottomOffset = 20.0;
        self.viewSize = CGSizeMake(20.0, 20.0);
        self.imageView = [[UIImageView alloc] init];
        self.collectionView = collectionView;
        self.freshType = freshViewType;

        [self.collectionView addObserver:self forKeyPath:LLFreshPathContentSize options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self.collectionView addObserver:self forKeyPath:LLFreshPathContentOffset options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self.collectionView.panGestureRecognizer addObserver:self forKeyPath:LLFreshPathPanState options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        self.frame = CGRectMake(0, 0, _viewSize.width, self.viewSize.height);
        
        self.imageView.bounds = self.bounds;
        [self addSubview:self.imageView];
        [self.collectionView addSubview:self];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint newPoint = [[change objectForKey:@"new"] CGPointValue];
        if (newPoint.x < - 30) {
            if (self.freshState != LLFreshStateRefreshing) {
                self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", abs((int)newPoint.x % 16) + 1]];
            }
        }else if (newPoint.x - (self.collectionView.contentSize.width - LLScreenW) > 30){
            if (self.freshState != LLFreshStateRefreshing) {
                self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", (int)newPoint.x % 16 + 1]];
            }
        }
    }else if ([keyPath isEqualToString:@"contentSize"]){
        if (self.freshState != LLFreshStateRefreshing && !self.imageView.isAnimating) {
            CGRect footerFrame = self.frame;
            if (self.freshType == LLFreshViewTypeFooter) {
                footerFrame.origin.x = self.collectionView.contentSize.width + 20;
                if (footerFrame.origin.x < self.collectionView.frame.size.width) {
                    footerFrame.origin.x = self.collectionView.frame.size.width + 20;
                }
            }else if (self.freshType == LLFreshViewTypeHeader){
                footerFrame.origin.x = -30;
            }
            footerFrame.origin.y = (CGRectGetHeight(self.collectionView.frame) - CGRectGetHeight(self.bounds)) * 0.5;
            self.frame = footerFrame;
        }
    }else if ([keyPath isEqualToString:@"state"]){
        UIGestureRecognizerState panState = [change[@"new"] integerValue];
        if (panState == UIGestureRecognizerStateEnded) {
            if ((self.collectionView.contentOffset.x + LLScreenW) - self.collectionView.contentSize.width > 30) {
                self.freshState = LLFreshStateRefreshing;
            }else if (self.collectionView.contentOffset.x < -30){
                self.freshState = LLFreshStateRefreshing;
            }
        }
    }
}

- (void)dealloc{
    [self.collectionView removeObserver:self forKeyPath:@"contentSize"];
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)setFreshState:(LLFreshState)freshState{
    _freshState = freshState;
    if (freshState == LLFreshStateRefreshing) {
        [self beginRefresh];
    }else if (freshState == LLFreshStateNormal){
        [self endRefresh];
    }
}

- (void)endRefresh{
    if (!self.imageView.isAnimating || LLFreshStateNormal == self.freshState) return;
    kWeakQuoteController(weakSelf);
    [UIView animateWithDuration:0.25 animations:^{
        kStrongQuoteController(strongSelf, weakSelf);
        CGRect selfFrame = strongSelf.frame;
        if (self.freshType == LLFreshViewTypeHeader) {
            selfFrame.origin.x -= 60;
        }else if(self.freshType == LLFreshViewTypeFooter){
            selfFrame.origin.x += 60;
        }
        strongSelf.frame = selfFrame;
    } completion:^(BOOL finished) {
        kStrongQuoteController(strongSelf, weakSelf);
        [strongSelf.imageView stopAnimating];
        
    }];
    self.freshState = LLFreshStateNormal;
}

- (void)beginRefresh{
    if (self.imageView.isAnimating) return;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect selfFrame = self.frame;
        if (self.freshType == LLFreshViewTypeHeader) {
            selfFrame.origin.x += 60;
        }else{
            selfFrame.origin.x -= 60;
        }
        self.frame = selfFrame;
    }];
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:16];
    for (int i = 1; i <= 16; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d", i]];
        if (image) [images addObject:image];
    }
    self.imageView.animationImages = images;
    self.imageView.animationDuration = 1.0;
    self.imageView.animationRepeatCount = HUGE;
    [self.imageView startAnimating];
    if ([self.delegate respondsToSelector:@selector(refreshWithView:freshType:)]) {
        if (self.freshType == LLFreshViewTypeHeader && self.collectionView.contentOffset.x <= 30) {
            [self.delegate refreshWithView:self freshType:LLFreshViewTypeHeader];
        }else if (self.freshType == LLFreshViewTypeFooter && (self.collectionView.contentOffset.x + LLScreenW) - self.collectionView.contentSize.width >= 0){
            [self.delegate refreshWithView:self freshType:LLFreshViewTypeFooter];
        }
        
    }
}

@end
