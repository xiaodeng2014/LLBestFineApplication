//
//  LLApp.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLBaseModel.h"
#import "LLCommentData.h"

@interface LLApp : LLBaseModel

@property (nonatomic, copy) NSString *qrcode_image;     //!<二维码
@property (nonatomic, copy) NSString *author_gender;    //!<性别
@property (nonatomic, copy) NSString *create_time;      //!<创建时间
@property (nonatomic, assign) NSInteger app_id;         //<!主键ID
@property (nonatomic, strong) LLCommentData *commentData; //!<评论对象
@property (nonatomic, copy) NSString *digest;           //!<文字描述
@property (nonatomic, copy) NSString *title;            //!<标题
@property (nonatomic, copy) NSString *sub_title;        //!<副标题
@property (nonatomic, copy) NSString *download_url;     //!<AppStore下载链接
@property (nonatomic, copy) NSString *icon_image;       //!<用户头像地址
@property (nonatomic, copy) NSString *content;          //!<详情页内容
@property (nonatomic, copy) NSString *update_time;      //!<更新时间
@property (nonatomic, copy) NSString *author_username;  //!<作者名称
@property (nonatomic, copy) NSString *recommanded_date; //!<推荐日期
@property (nonatomic, copy) NSString *recommanded_background_color;//!<背景色
@property (nonatomic, copy) NSString *author_avatar_url;//!<作者头像
@property (nonatomic, copy) NSString *tags;             //!<标签
@property (nonatomic, copy) NSString *author_bgcolor;   //!<作者背景色
@property (nonatomic, copy) NSString *publish_date;     //!<发布日期
@property (nonatomic, copy) NSString *author_career;    //!<作者的职业
@property (nonatomic, copy) NSString *cover_image;      //!<封面图片地址
@property (nonatomic, assign) NSInteger author_id;      //!<作者的ID


@end
