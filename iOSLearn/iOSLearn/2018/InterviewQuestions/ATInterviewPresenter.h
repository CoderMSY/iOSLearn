//
//  ATInterviewPresenter.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATBasePresenter.h"
#import "ATInterviewPresenterIO.h"

static NSString * _Nonnull const kText_uiInfo = @"UI相关：";
static NSString * _Nonnull const kText_ocCharacter = @"Objective_C语言特性";

NS_ASSUME_NONNULL_BEGIN

@interface ATInterviewPresenter : ATBasePresenter <ATInterviewPresenterInput>

@property (nonatomic, weak) id <ATInterviewPresenterOutput>output;

@end

NS_ASSUME_NONNULL_END
