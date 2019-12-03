//
//  ATViewRelatedPresenter.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATBasePresenter.h"
#import "ATViewRelatedPresenterIO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATViewRelatedPresenter : ATBasePresenter <ATViewRelatedPresenterInput>

@property (nonatomic, weak) id <ATViewRelatedPresenterOutput> output;

@end

NS_ASSUME_NONNULL_END
