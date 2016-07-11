//
//  LLComment.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLComment : LLBaseModel

@property (nonatomic, assign) BOOL is_on_cover;         //!<是否在封面上
@property (nonatomic, copy) NSString *author_bgcolor;   //!<作者背景
@property (nonatomic, copy) NSString *created_at;       //!<创建时间
@property (nonatomic, copy) NSString *updated_at;       //!<更新时间
@property (nonatomic, copy) NSString *author_gender;    //!<性别
@property (nonatomic, copy) NSString *content;          //!<内容
@property (nonatomic, copy) NSString *author_name;      //!<作者名
@property (nonatomic, copy) NSString *author_career;    //!<职业生涯
@property (nonatomic, assign) NSInteger author_id;      //!<作者ID
@property (nonatomic, assign) NSInteger article;
@property (nonatomic, copy) NSString *author_avatar_url;//!<作者头像
@property (nonatomic, assign) NSInteger comment_id;     //!<评论ID


@end
