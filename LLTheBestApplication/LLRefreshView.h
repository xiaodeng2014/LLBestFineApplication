//
//  LLRefreshView.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/27.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    LLFreshViewTypeHeader,
    LLFreshViewTypeFooter
}LLFreshViewType;

typedef enum{
    LLFreshStateNormal,
    LLFreshStateRefreshing
}LLFreshState;

@class LLRefreshView;

@protocol LLRefreshViewDelegate <NSObject>

@optional
- (void)refreshWithView:(LLRefreshView *)view freshType:(LLFreshViewType)freshType;

@end

@interface LLRefreshView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) LLFreshViewType type;


@property (nonatomic, weak) id<LLRefreshViewDelegate> delegate;

- (void)endRefresh;


- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
                         freshViewType:(LLFreshViewType)freshViewType;




@end
