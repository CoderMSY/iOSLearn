//
//  ATPageLogicDaoProtocol.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/4.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ATPageVisitLogicDaoProtocol <NSObject>

- (void)saveVisitCountWithPageClass:(NSString *)pageClass
                          pageTitle:(NSString *)pageTitle;

@end

NS_ASSUME_NONNULL_END
