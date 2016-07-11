//
//  LLHomeCollectionViewCell.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLHomeCollectionViewCell.h"
#import "LLApp.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+YX.h"

NSString * const LLHomeCollectionViewCellReusedIdentifier = @"HomeReusedIdentifier";

@interface LLHomeCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorUsernameLabel;
@property (weak, nonatomic) IBOutlet UIView *mainContainView;

@end

@implementation LLHomeCollectionViewCell

- (void)awakeFromNib{
    self.digestLabel.preferredMaxLayoutWidth = LLScreenW - 20;
    self.mainContainView.layer.cornerRadius = 6;
}

- (void)setApp:(LLApp *)app{
    _app = app;
    self.titleLabel.text = app.title;
    self.subTitleLabel.text = app.sub_title;
    self.digestLabel.text = app.digest;
    self.authorUsernameLabel.text = app.author_username;
    
    UIImage *placeHolderImage = [UIColor imageWithColor:[UIColor whiteColor] size:self.subImageView.bounds.size innerString:@"最美应用" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    
    [self.subImageView sd_setImageWithURL:[NSURL URLWithString:app.cover_image] placeholderImage:placeHolderImage];
}

@end
