//
//  LLHomeViewController.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLHomeViewController.h"
#import "LLHomeCollectionViewCell.h"
#import "LLHomeData.h"
#import "LLHomeDataManager.h"
#import "LLGlobalConfig.h"
#import "LLProgressHUD.h"
#import <UIImageView+WebCache.h>
#import "LLRefreshView.h"
#import "UIColor+YX.h"
#import "LLHomeDetailViewController.h"
#import "LLBottomCollectionView.h"
#import "LLBottomCollectionViewCell.h"

NSInteger const kCountBottomLogo = 7;
CGFloat const kBottomLogoViewHeight = 60;
CGFloat const kBottomMarginX = 8;
CGFloat const kLogoImageMargin = 2;

@interface LLHomeViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    LLRefreshViewDelegate
>

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *changeColorView;
@property (weak, nonatomic) IBOutlet UILabel *dataTitleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionView;
@property (strong, nonatomic) LLHomeData *homeData;
@property (strong, nonatomic) NSMutableDictionary *homeParams;
@property (strong, nonatomic) LLBottomCollectionView *collectionView;
@property (strong, nonatomic) LLRefreshView *freshHeader;
@property (strong, nonatomic) LLRefreshView *freshFooter;
@property (assign, nonatomic) NSUInteger currentIndex;
@property (weak, nonatomic) UICollectionViewCell *collectionViewCell;

@end

@implementation LLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LLGlobalConfig *c = [LLGlobalConfig copy];
    LLGlobalConfig *c4 = [LLGlobalConfig mutableCopy];
    LLGlobalConfig *c2 = [LLGlobalConfig new];
    LLGlobalConfig *c3 = [LLGlobalConfig defaultConfig];
    NSLog(@"%p -- %p -- %p - %p", c, c2, c3, c4);
    return;
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"LLHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LLHomeCollectionViewCellReusedIdentifier"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, LLScreenH - 160);
    flowLayout.minimumLineSpacing = 0;
    self.homeCollectionView.collectionViewLayout = flowLayout;
    self.homeCollectionView.pagingEnabled = YES;
    self.homeCollectionView.showsHorizontalScrollIndicator = NO;
    
    self.freshFooter = [[LLRefreshView alloc] initWithCollectionView:self.homeCollectionView freshViewType:LLFreshViewTypeFooter];
    self.freshFooter.delegate = self;
    
    self.freshHeader = [[LLRefreshView alloc] initWithCollectionView:self.homeCollectionView freshViewType:LLFreshViewTypeHeader];
    self.freshHeader.delegate = self;
    
    [self netWorkDataWithHeaderFresh:YES];
    [LLProgressHUD showInView:self.navigationController.view];
}

#pragma mark 刷新的代理
- (void)refreshWithView:(LLRefreshView *)view freshType:(LLFreshViewType)freshType{
    if (freshType == LLFreshViewTypeFooter) {   //尾部刷新
        [self netWorkDataWithHeaderFresh:NO];
    }else if (freshType == LLFreshViewTypeHeader){ //头部刷新
        [self netWorkDataWithHeaderFresh:YES];
    }
}

#pragma mark get network data
- (void)netWorkDataWithHeaderFresh:(BOOL)headerFresh{
    kWeakQuoteController(weakSelf);
    if (headerFresh) self.homeParams[@"page"] = @(1);
    NSMutableDictionary *params = self.homeParams;
    [LLHomeDataManager findHomeDataWithParams:params header:nil callBackSuccess:^(LLHomeData *homeData) {
        kStrongQuoteController(strongSelf, weakSelf);
        if (!strongSelf) return;
        [LLProgressHUD hideInView:strongSelf.navigationController.view];
        if (headerFresh) {
            [strongSelf.freshHeader endRefresh];
        } else {
            [strongSelf.freshFooter endRefresh];
        }
        if (headerFresh) {
            strongSelf.homeData = homeData;
        }else{
            strongSelf.homeData.has_next = homeData.has_next;
            [strongSelf.homeData.apps addObjectsFromArray:homeData.apps];
        }
        strongSelf.homeParams[@"page"] = @([self.homeParams[@"page"] intValue] + 1);
        [strongSelf.homeCollectionView reloadData];
        [strongSelf disposeBottomViewsWithHomeData:homeData];
    } callBackFailure:^(NSError *error) {
        kStrongQuoteController(strongSelf, weakSelf);
        if (!strongSelf) return;
        [LLProgressHUD hideInView:strongSelf.navigationController.view];
    }];
}

#pragma mark 处理下面的View
- (void)disposeBottomViewsWithHomeData:(LLHomeData *)homeData{
    if (!self.collectionView) {
        CGFloat bottomCollectionH = 115;
        CGFloat bottomCollectionY = LLScreenH - bottomCollectionH * 0.54;
        CGFloat bottomCollectionX = kBottomMarginX;
        CGFloat bottomCollectionW = LLScreenW - kBottomMarginX;
        self.collectionView = [[LLBottomCollectionView alloc] initWithFrame:CGRectMake(bottomCollectionX, bottomCollectionY, bottomCollectionW, bottomCollectionH) apps:self.homeData.apps];
        [self.view addSubview:self.collectionView];
        [self backgroundColorAnimationWithApp:self.homeData.apps[0] rippleEffect:YES];
    }else{
        self.collectionView.apps = self.homeData.apps;
    }
    kWeakQuoteController(weakSelf);
    [self.collectionView finishDisplayCell:^(UICollectionViewCell *cell, NSIndexPath *indexPath) {
        kStrongQuoteController(strongSelf, weakSelf);
        if (!strongSelf) return;
        if (strongSelf.currentIndex == indexPath.item) {
            strongSelf.collectionViewCell = cell;
            [strongSelf transFormLogoViewLogoView:cell isReset:NO];
        }
    }];
}

- (void)transFormLogoViewLogoView:(UIView *)logoView isReset:(BOOL)isReset{
    [UIView animateWithDuration:0.25 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (isReset) {
            logoView.transform = CGAffineTransformIdentity;
        }else{
            logoView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(logoView.frame) + 15);
        }
    } completion:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger currentIndex = scrollView.contentOffset.x / self.homeCollectionView.frame.size.width;
    [self transFormLogoViewLogoView:self.collectionViewCell isReset:YES];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
    self.collectionViewCell = [self.collectionView cellForItemAtIndexPath:indexPath];
    [self transFormLogoViewLogoView:self.collectionViewCell isReset:NO];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    if (currentIndex == self.currentIndex) {
        [self transFormLogoViewLogoView:self.collectionViewCell isReset:YES];
        kWeakQuoteController(weakSelf);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf transFormLogoViewLogoView:self.collectionViewCell isReset:NO];
        });
    }else{
        [self backgroundColorAnimationWithApp:self.homeData.apps[currentIndex] rippleEffect:NO];
    }
    self.currentIndex = currentIndex;
}

#pragma mark - CollectionView Delegate And DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.homeData.apps.count;
}

- (LLHomeCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LLHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LLHomeCollectionViewCellReusedIdentifier forIndexPath:indexPath];
    LLApp *app = [self.homeData.apps objectAtIndex:indexPath.row];
    cell.app = app;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LLHomeDetailViewController *detailVc = [LLHomeDetailViewController new];
    LLApp *app = [self.homeData.apps objectAtIndex:indexPath.row];
    LLHomeCollectionViewCell *cell = (LLHomeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    detailVc.subImage = cell.subImageView.image;
    
    CGRect subImageRect = [cell.subImageView convertRect:cell.subImageView.frame toView:self.navigationController.view];
    subImageRect.origin.y -= 54;
    detailVc.subImageRect = subImageRect;
    detailVc.app  = app;
    LLBottomCollectionViewCell *cellCollection = (LLBottomCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    detailVc.userImage = cellCollection.avtarImageView.image;
    [self.navigationController pushViewController:detailVc animated:NO];
}

#pragma mark - 背景色改变
- (void)backgroundColorAnimationWithApp:(LLApp *)app rippleEffect:(BOOL)rippleEffect{
    if (rippleEffect) {
        self.changeColorView.backgroundColor = [UIColor colorWithColorString:app.recommanded_background_color];
        CATransition *ca = [CATransition animation];
        ca.type = @"rippleEffect";
        ca.subtype = kCATransitionFromLeft;
        ca.duration = 0.8;
        [self.changeColorView.layer addAnimation:ca forKey:nil];
    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.8];
        self.changeColorView.backgroundColor = [UIColor colorWithColorString:app.recommanded_background_color];
        [UIView commitAnimations];
    }
}

#pragma mark - 延迟加载
- (NSMutableDictionary *)homeParams{
    if (!_homeParams) {
        _homeParams = [NSMutableDictionary dictionaryWithDictionary:[LLGlobalConfig defaultConfig].defaultRequestParams];
    }
    return _homeParams;
}

@end
