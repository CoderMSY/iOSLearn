//
//  ATQuestionModel.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATQuestionModel : ATBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *controller;
@property (nonatomic, copy) NSArray <ATQuestionModel *>*list;

@end

NS_ASSUME_NONNULL_END
