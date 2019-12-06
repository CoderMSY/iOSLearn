//
//  ATBaseLogicDaoImpl.h
//  XCData
//
//  Created by SimonMiao on 2019/6/25.
//  Copyright © 2019 avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATBaseLogicDaoImpl : NSObject

/// 获取串行队列
- (dispatch_queue_t)getWritingQueue;
- (NSString *)getCacheBasePath;
- (void)createDirectoryAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
