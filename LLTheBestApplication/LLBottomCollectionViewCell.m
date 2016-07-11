//
//  LLBottomCollectionViewCell.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/7/6.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLBottomCollectionViewCell.h"
#import "LLApp.h"
#import <UIImageView+WebCache.h>

@interface LLBottomCollectionViewCell()

@end

@implementation LLBottomCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    static NSString *collectionViewIdentifier = @"LLBottomCollectionViewCellReusedID";
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UINib *nib = [UINib nibWithNibName:@"LLBottomCollectionViewCell" bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:collectionViewIdentifier];
    });
    return [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewIdentifier forIndexPath:indexPath];
}

- (void)setApp:(LLApp *)app{
    _app = app;
    [self.avtarImageView sd_setImageWithURL:[NSURL URLWithString:app.icon_image] placeholderImage:[UIImage imageNamed:@"loading_9"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avtarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 8;
    self.avtarImageView.layer.cornerRadius = self.layer.cornerRadius;
    self.avtarImageView.layer.masksToBounds = YES;
}

@end
