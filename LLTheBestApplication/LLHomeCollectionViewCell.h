//
//  LLHomeCollectionViewCell.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLApp;

UIKIT_EXTERN NSString * const LLHomeCollectionViewCellReusedIdentifier;

@interface LLHomeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *subImageView;
@property (nonatomic, strong) LLApp *app;

@end
