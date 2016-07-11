//
//  LLCommentData.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLBaseModel.h"
#import "LLComment.h"

@interface LLCommentData : LLBaseModel

@property (nonatomic, assign) BOOL has_next;
@property (nonatomic, strong) NSMutableArray<LLComment *> *data; //<!评论的对象

@end
