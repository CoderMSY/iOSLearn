//
//  ATAlgorithmPresenterIO.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/5.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ATAlgorithmPresenterInput <NSObject>

- (void)fetchDataSourceWithList:(NSArray *)list;

@end

@protocol ATAlgorithmPresenterOutput <NSObject>

- (void)renderDataSource:(NSArray *)dataSource;

@end

NS_ASSUME_NONNULL_END
