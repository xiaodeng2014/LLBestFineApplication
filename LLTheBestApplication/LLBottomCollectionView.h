//
//  LLBottomCollectionView.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/6.
//  Copyright © 2016年 Apollo. All rights reserved.
//
typedef void(^LLBottomCollectionViewDidDisplayCell)(UICollectionViewCell *cell, NSIndexPath *indexPath);

#import <UIKit/UIKit.h>
@class LLApp;


@interface LLBottomCollectionView : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame apps:(NSMutableArray<LLApp *> *)apps;

@property (nonatomic, strong) NSMutableArray<LLApp *> *apps;

- (void)finishDisplayCell:(LLBottomCollectionViewDidDisplayCell)finishDisplayCell;

@end
