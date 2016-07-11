//
//  LLBottomCollectionViewCell.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/6.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLApp;

@interface LLBottomCollectionViewCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) LLApp *app;
@property (weak, nonatomic) IBOutlet UIImageView *avtarImageView;

@end
