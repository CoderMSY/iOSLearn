//
//  ATAlgorithmPresenter.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/5.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATBasePresenter.h"
#import "ATAlgorithmPresenterIO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ATAlgorithmPresenter : ATBasePresenter <ATAlgorithmPresenterInput>

@property (nonatomic, weak) id <ATAlgorithmPresenterOutput>output;

@end

NS_ASSUME_NONNULL_END
