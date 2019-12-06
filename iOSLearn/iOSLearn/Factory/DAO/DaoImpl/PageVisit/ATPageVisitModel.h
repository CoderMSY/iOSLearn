//
//  ATPageVisitModel.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/4.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATPageVisitModel : NSObject

@property (nonatomic, copy) NSString *pageClass;
@property (nonatomic, copy) NSString *pageTitle;
@property (nonatomic, assign) NSInteger visitCount;

@end

NS_ASSUME_NONNULL_END
