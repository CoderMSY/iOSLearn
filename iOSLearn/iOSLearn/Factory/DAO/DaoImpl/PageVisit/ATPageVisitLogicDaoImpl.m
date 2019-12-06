//
//  ATPageVisitLogicDaoImpl.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/4.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATPageVisitLogicDaoImpl.h"
#import <BGFMDB/BGFMDB.h>
#import "ATPageVisitModel.h"

static NSString *kTableName = @"pageVisitCount";

@implementation ATPageVisitLogicDaoImpl

#pragma mark - ATPageLogicDaoProtocol

- (void)saveVisitCountWithPageClass:(NSString *)pageClass
                          pageTitle:(NSString *)pageTitle {
    if (0 == pageClass.length) {
        return;
    }
    
    dispatch_queue_t writingQueue = [self getWritingQueue];
    dispatch_async(writingQueue, ^{
        ATPageVisitModel *vModel = [[ATPageVisitModel alloc] init];
        vModel.bg_tableName = kTableName;
        vModel.pageClass = pageClass;
        vModel.pageTitle = pageTitle;
        NSString* where = [NSString stringWithFormat:@"where %@=%@ and %@=%@", bg_sqlKey(@"pageClass"), bg_sqlValue(pageClass), bg_sqlKey(@"pageTitle"),bg_sqlValue(pageTitle)];
        [ATPageVisitModel bg_findAsync:kTableName where:where complete:^(NSArray * _Nullable array) {
            if (0 == array.count) {
                vModel.visitCount = 1;
                
                [vModel bg_saveAsync:^(BOOL isSuccess) {
                    if (isSuccess) {
                        ATLog(@"新增成功");
                    }
                }];
            }
            else if (1 == array.count) {
                if ([array.firstObject isKindOfClass:[ATPageVisitModel class]]) {
                    ATPageVisitModel *findModel = (ATPageVisitModel *)array.firstObject;
                    vModel.visitCount = findModel.visitCount + 1;
                    
                    [vModel bg_updateAsyncWhere:where complete:^(BOOL isSuccess) {
                        if (isSuccess) {
                            ATLog(@"更新成功");
                        }
                    }];
                }
            }
            else {
                ATLog(@"数据出现异常请排查, 结果数：%lu", array.count);
            }
        }];
    });
}

@end
