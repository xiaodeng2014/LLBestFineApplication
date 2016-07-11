//
//  LLBottomCollectionView.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/6.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLBottomCollectionView.h"
#import "LLBottomCollectionViewCell.h"

@interface LLBottomCollectionView()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

@property (nonatomic, assign) CGFloat itemMargin;
@property (nonatomic, assign) CGFloat itemVisableCount;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic, copy) LLBottomCollectionViewDidDisplayCell finishCell;

@end

@implementation LLBottomCollectionView

- (instancetype)initWithFrame:(CGRect)frame apps:(NSMutableArray<LLApp *> *)apps{
    UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
    if (self = [super initWithFrame:frame collectionViewLayout:flow]) {
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = NO;
        self.apps = apps;
        self.itemMargin = 2;
        self.itemVisableCount = 7;
        
        CGFloat itemH = 60;
        CGFloat itemW = (CGRectGetWidth(frame) - (_itemVisableCount - 1) * _itemMargin) / _itemVisableCount;
        CGFloat topInset = frame.size.height - itemH;
        self.itemSize = CGSizeMake(itemW, itemH);
        flow.sectionInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumLineSpacing = self.itemMargin;
        flow.itemSize = CGSizeMake(itemW, itemH);
        self.collectionViewLayout = flow;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.apps.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LLBottomCollectionViewCell *cell = [LLBottomCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath];
    cell.app = self.apps[indexPath.item];
    if (self.finishCell) {
        self.finishCell(cell, indexPath);
    }
    return cell;
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated{
    NSArray<NSIndexPath *> *selectedIndexPaths = [self indexPathsForSelectedItems];
    if (selectedIndexPaths.count) {
        int moveIndex = (int)ceil(self.itemVisableCount / 2.0);
        NSIndexPath *indexPath = selectedIndexPaths.firstObject;
        if (indexPath.item >= moveIndex) {
            contentOffset.x = (indexPath.item - moveIndex + 1) * (self.itemMargin + self.itemSize.width);
        }
        self.selectedIndexPath = indexPath;
    }
    [super setContentOffset:contentOffset animated:animated];
}

- (void)setContentSize:(CGSize)contentSize{
    contentSize.width += (self.itemSize.width + self.itemMargin) * (int)ceilf(self.itemVisableCount / 2.0);;
    [super setContentSize:contentSize];
}

- (void)finishDisplayCell:(LLBottomCollectionViewDidDisplayCell)finishDisplayCell{
    self.finishCell = finishDisplayCell;
}

- (void)setApps:(NSMutableArray<LLApp *> *)apps{
    _apps = apps;
    [self reloadData];
}

@end
