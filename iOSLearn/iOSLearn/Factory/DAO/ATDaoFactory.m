//
//  ATDaoFactory.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/4.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATDaoFactory.h"
#import <BGFMDB/BGFMDB.h>
#import "ATPageVisitLogicDaoImpl.h"

@interface ATDaoFactory ()

@property (nonatomic, strong) ATPageVisitLogicDaoImpl *visitDaoImpl;

@end

@implementation ATDaoFactory

static ATDaoFactory *daoFactory;

#pragma mark - lifecycle methods

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        daoFactory = [[[self class] alloc] init];
    });

    return daoFactory;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *homePath = NSHomeDirectory();
        ATLog(@"#####工厂单例初始化啦#####:%@",homePath);
        
//        ATUserModel *userModel = [[ATCurrentUserMgr shareInstance] getCurrentUserModel];
        [self setDBNameWithUserId:@"123"];
    }
    return self;
}

#pragma mark - public methods

- (id<ATPageVisitLogicDaoProtocol>)getVisitDao {
    return self.visitDaoImpl;
}

#pragma mark - private methods

- (void)setDBNameWithUserId:(NSString *)userId {
    NSString *dbName;
    if (0 == userId.length) {
//        return;
        dbName = @"temp";//!<临时数据库
    }
    
#if AT_DEV
    dbName = [NSString stringWithFormat:@"%@_%@",@"dev",userId];//测试数据库
#else
    dbName = [NSString stringWithFormat:@"%@_%@",@"product",userId];//正式数据库
#endif
    
    bg_setDebug(NO);//BGFMDB日志信息
    bg_setSqliteName(dbName);
}


#pragma mark - getter && setter

- (ATPageVisitLogicDaoImpl *)visitDaoImpl {
    if (!_visitDaoImpl) {
        _visitDaoImpl = [[ATPageVisitLogicDaoImpl alloc] init];
    }
    return _visitDaoImpl;
}

@end
