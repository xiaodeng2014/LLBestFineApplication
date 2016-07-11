//
//  LLHomeDetailViewController.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/28.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLApp;

@interface LLHomeDetailViewController : UIViewController

@property (nonatomic, strong) UIImage *subImage;
@property (nonatomic, assign) CGRect subImageRect;

@property (nonatomic, strong) UIImage *userImage;

@property (nonatomic, strong) LLApp *app;

@end
