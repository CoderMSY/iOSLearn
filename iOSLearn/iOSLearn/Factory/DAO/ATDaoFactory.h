//
//  ATDaoFactory.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/4.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATPageVisitLogicDaoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#define _Dao [ATDaoFactory sharedInstance]

@interface ATDaoFactory : NSObject

+ (instancetype)sharedInstance;

- (id<ATPageVisitLogicDaoProtocol>)getVisitDao;

@end

NS_ASSUME_NONNULL_END
