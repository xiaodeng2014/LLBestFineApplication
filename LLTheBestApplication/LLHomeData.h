//
//  LLHomeData.h
//  LLTheBestApplication
//
//  Created by Apollo on 16/6/22.
//  Copyright © 2016年 Apollo. All rights reserved.
//

#import "LLBaseModel.h"
#import "LLApp.h"

@interface LLHomeData : LLBaseModel

@property (nonatomic, assign) BOOL has_next;    //!<是否有下一页
@property (nonatomic, strong) NSMutableArray<LLApp *> *apps;    //!<App数据

@end
