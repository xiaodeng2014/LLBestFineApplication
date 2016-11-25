//
//  LLHomeDetailViewController.m
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/28.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLHomeDetailViewController.h"
#import "LLApp.h"
#import <hpple/TFHpple.h>
#import "LLContentImage.h"
#import "LLContentText.h"
#import <UIImageView+WebCache.h>
#import <UIImageView+AFNetworking.h>
#import "UIColor+YX.h"
#import "UIView+LL.h"
#import "UINavigationController+LL.h"

CGFloat const LLTopImageInitY = 35.0;
CGFloat const LLDurationAnimation = 0.8;
CGFloat const LLMarginLeftAndRight = 8;
CGFloat const LLContentMarginY = 15.0;
@interface LLHomeDetailViewController()
<
    UIScrollViewDelegate,
    CAAnimationDelegate
>

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, assign) CGRect imageInitRect;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, assign) CGFloat lastY;

@property (nonatomic, strong) NSMutableDictionary *attributes;

@end

@implementation LLHomeDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = RGBSimeValue(250);
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.frame = self.subImageRect;
    self.imageInitRect = self.subImageRect;
    self.topImageView.image = self.subImage;
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.mainScrollView addSubview:self.topImageView];

    kWeakQuoteController(weakSelf);
    [UIView animateWithDuration:LLDurationAnimation animations:^{
        kStrongQuoteController(strongSelf, weakSelf);
        if (!strongSelf) return ;
        CGRect topImageFrame = strongSelf.topImageView.frame;
        topImageFrame.size.width = LLScreenW;
        topImageFrame.origin.y = LLTopImageInitY;
        topImageFrame.origin.x = 0;
        strongSelf.topImageView.frame = topImageFrame;
    }];
    
    CGRect userImageRect = CGRectMake(LLMarginLeftAndRight, 10, 40, 40);
    self.userImageView = [[UIImageView alloc] initWithFrame:userImageRect];
    self.userImageView.image = self.userImage;
    self.userImageView.layer.cornerRadius = 8;
    self.userImageView.layer.masksToBounds = YES;
    [self.view addSubview:self.mainScrollView];
    
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.topImageView.frame) + 12, CGRectGetWidth(self.view.frame), 900);
    [self.mainScrollView addSubview:self.bottomView];
    [self.bottomView addSubview:self.userImageView];
    
    CABasicAnimation *userImageCa = [CABasicAnimation animationWithKeyPath:@"position"];
    userImageCa.fromValue = [NSValue valueWithCGPoint:CGPointMake(-CGRectGetWidth(userImageRect) * 2,  CGRectGetHeight(self.view.bounds) * 0.8)];
    userImageCa.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(userImageRect), CGRectGetMidY(userImageRect))];
    userImageCa.duration = LLDurationAnimation;
    [self.userImageView.layer addAnimation:userImageCa forKey:nil];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(LLMarginLeftAndRight, 40, 40, 40);
    [backButton setImage:[UIImage imageNamed:@"item_cancel"] forState:UIControlStateNormal];
    backButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    backButton.layer.cornerRadius = CGRectGetWidth(backButton.frame) * 0.5;
    [backButton addTarget:self action:@selector(backTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    CABasicAnimation *backButtonCaAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    backButtonCaAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-CGRectGetWidth(backButton.frame), CGRectGetMidY(backButton.frame))];
    backButtonCaAnimation.toValue = [NSValue valueWithCGPoint:backButton.center];
    backButtonCaAnimation.duration = LLDurationAnimation;
    [backButton.layer addAnimation:backButtonCaAnimation forKey:nil];
    
    CGFloat marginLeftAndRight = LLMarginLeftAndRight;
    UILabel *applicationNameLabel = ({
        CGFloat labelX = CGRectGetMaxX(self.userImageView.frame) + marginLeftAndRight;
        CGFloat labelY = userImageRect.origin.y + 2;
        CGFloat labelW = CGRectGetWidth(self.view.frame) - labelX - marginLeftAndRight;
        CGFloat labelH = 20;
        UILabel *label = [UILabel new];
        label.text = self.app.title;
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        [self.bottomView addSubview:label];
        label;
    });
    
    UILabel *subNameLabel = ({
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(applicationNameLabel.frame.origin.x, CGRectGetMaxY(applicationNameLabel.frame), CGRectGetWidth(applicationNameLabel.frame), 18);
        [self.bottomView addSubview:label];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = RGBSimeValue(80);
        label.text = self.app.sub_title;
        label;
    });
    
    CABasicAnimation *applicationNameAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    id applicaitonNameToValue = [NSValue valueWithCGPoint:applicationNameLabel.center];
    applicationNameAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-CGRectGetWidth(userImageRect),  CGRectGetHeight(self.view.bounds) * 0.6)];
    applicationNameAnimation.toValue = applicaitonNameToValue;
    applicationNameAnimation.duration = LLDurationAnimation;
    [applicationNameLabel.layer addAnimation:applicationNameAnimation forKey:nil];
    
    CABasicAnimation *subNameAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    id subNameToValue = [NSValue valueWithCGPoint:subNameLabel.center];
    subNameAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-CGRectGetWidth(userImageRect),  CGRectGetHeight(self.view.bounds) * 0.6)];
    subNameAnimation.toValue = subNameToValue;
    subNameAnimation.duration = LLDurationAnimation;
    subNameAnimation.delegate = self;
    [subNameLabel.layer addAnimation:subNameAnimation forKey:nil];
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = subNameLabel.textColor;
    
    NSMutableAttributedString *digestAttr = [[NSMutableAttributedString alloc] initWithString:self.app.digest];
    [digestAttr addAttributes:self.attributes range:NSMakeRange(0, self.app.digest.length)];
    detailLabel.attributedText = digestAttr;
    
    CGSize detailLabelSize = [self.app.digest boundingRectWithSize:CGSizeMake(LLScreenW - 2 * marginLeftAndRight, HUGE) options:NSStringDrawingUsesLineFragmentOrigin attributes:self.attributes context:nil].size;
    detailLabel.frame = CGRectMake(marginLeftAndRight, CGRectGetMaxY(self.userImageView.frame) + 50, detailLabelSize.width, detailLabelSize.height);
    [self.bottomView addSubview:detailLabel];
    
    CABasicAnimation *detailLabelAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    detailLabelAnimation.fromValue = @(CGRectGetHeight(self.view.frame) - detailLabelSize.height);
    detailLabelAnimation.toValue = @(CGRectGetMidY(detailLabel.frame));
    detailLabelAnimation.duration = LLDurationAnimation;
    [detailLabel.layer addAnimation:detailLabelAnimation forKey:nil];
    
    NSData *contentData = [self.app.content dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *hpple = [[TFHpple alloc] initWithHTMLData:contentData];
    NSArray *pArray = [hpple searchWithXPathQuery:@"//body/node()"];
    NSMutableArray *contents = [NSMutableArray array];
    for (TFHppleElement *ele in pArray) {
        if (![ele isKindOfClass:[TFHppleElement class]]) continue;
        if(ele.isTextNode){
            [contents addObject:[NSNumber numberWithFloat:LLContentMarginY]];
        }else if (ele.text.length){
            LLContentText *contentText = [[LLContentText alloc] initWithContent:ele.text tagName:ele.tagName marginLeftAndRight:marginLeftAndRight attributes:self.attributes];
            [contents addObject:contentText];
        }else{
            for (TFHppleElement *ele2 in ele.children) {
                if ([ele2.tagName isEqualToString:@"img"]) {
                    if(contents.count == 0) {
                        [contents addObject:[NSNumber numberWithFloat:LLContentMarginY]];
                    }
                    [contents addObject:[NSNumber numberWithFloat:4]];
                    CGFloat imgWidth = [ele2.attributes[@"width"] floatValue];
                    CGFloat imgHeight = [ele2.attributes[@"height"] floatValue];
                    NSString *imgUrl = ele2.attributes[@"src"];
                    LLContentImage *contentImage = [[LLContentImage alloc] initWithWith:imgWidth height:imgHeight imageUrl:imgUrl marginLeft:marginLeftAndRight];
                    [contents addObject:contentImage];
                }
            }
        }
    }
    
    self.lastY = CGRectGetMaxY(detailLabel.frame);
    for (NSUInteger i = 0; i< contents.count; ++i) {
        id contentObj = contents[i];
        if ([contentObj isKindOfClass:[LLContentText class]]) {
            if (i == 0) self.lastY += LLContentMarginY;
            [self createLabelWithContentText:contentObj];
        }else if ([contentObj isKindOfClass:[LLContentImage class]]){
            [self createLabelWithContentImage:contentObj];
        }else if ([contentObj isKindOfClass:[NSNumber class]]){
            self.lastY += [contentObj floatValue];
        }
    }
    
    UIView *bottomSepLineView = [[UIView alloc] initWithFrame:CGRectMake(marginLeftAndRight, self.lastY + marginLeftAndRight, LLScreenW - 2 * marginLeftAndRight, 0.5)];
    bottomSepLineView.backgroundColor = RGBSimeValue(235);
    [self.bottomView addSubview:bottomSepLineView];
        
    UIImageView *bottomImageView = (UIImageView *)[self.userImageView ll_duplicate];
    bottomImageView.center = CGPointMake(self.bottomView.center.x, CGRectGetMaxY(bottomSepLineView.frame) + bottomImageView.frame.size.height);
    [self.bottomView addSubview:bottomImageView];
    self.lastY = CGRectGetMaxY(bottomImageView.frame);
    self.mainScrollView.contentSize = CGSizeMake(0, self.lastY + self.bottomView.frame.origin.y + CGRectGetHeight(bottomImageView.frame));
}

#pragma mark 根据文字创建指定的Label
- (void)createLabelWithContentText:(LLContentText *)contentText{
    self.lastY += contentText.marginY;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(LLMarginLeftAndRight, self.lastY, contentText.textSize.width, contentText.textSize.height)];
    label.numberOfLines = 0;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:contentText.text attributes:contentText.attributes];
    label.attributedText = attr;
    [self.bottomView addSubview:label];
    self.lastY = CGRectGetMaxY(label.frame);
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue = @(self.view.frame.size.height * 2);
    animation.toValue = @(CGRectGetMidY(label.frame));
    animation.duration = LLDurationAnimation;
    [label.layer addAnimation:animation forKey:nil];
}

#pragma mark 根据图片对象创建指定的ImageView
- (void)createLabelWithContentImage:(LLContentImage *)contentImage{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(LLMarginLeftAndRight, self.lastY, contentImage.realWidth, contentImage.realHeight)];
    [self.bottomView addSubview:imageView];
    
    UIImage *placeHolderImage = [UIColor imageWithColor:[UIColor whiteColor] size:imageView.frame.size innerString:@"最美应用" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:contentImage.imageUrl] placeholderImage:placeHolderImage];
    
    self.lastY = CGRectGetMaxY(imageView.frame);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.toValue = @(CGRectGetMidY(imageView.frame));
    animation.fromValue = @(self.view.frame.size.height * 2);
    animation.duration = LLDurationAnimation;
    [imageView.layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.bottomView.backgroundColor = self.view.backgroundColor;
}

- (void)backTouch{
    [self.navigationController popCustomViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat coefficient = 1.2;
    CGRect topImageFrame = self.topImageView.frame;
    CGFloat topImageY = LLTopImageInitY + scrollView.contentOffset.y * 0.9;
    if (topImageY <= LLTopImageInitY) {
        topImageFrame.size.height = self.imageInitRect.size.height - scrollView.contentOffset.y * coefficient;
        topImageY = LLTopImageInitY + scrollView.contentOffset.y * coefficient;
    }else{
        topImageY = LLTopImageInitY + scrollView.contentOffset.y - scrollView.contentOffset.y * 0.2;
    }
    topImageFrame.origin.y = topImageY;
    self.topImageView.frame = topImageFrame;
}

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _mainScrollView.contentSize = CGSizeMake(0, 1000);
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor clearColor];
    }
    return _mainScrollView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (NSMutableDictionary *)attributes{
    if (!_attributes) {
        _attributes = [NSMutableDictionary dictionaryWithCapacity:2];
        _attributes[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        _attributes[NSForegroundColorAttributeName] = RGBSimeValue(80);
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 6;
        paragraphStyle.paragraphSpacing = 2;
        _attributes[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    return _attributes;
}

@end
