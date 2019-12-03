//
//  ATViewRelatedPresenterIO.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ATViewRelatedPresenterInput <NSObject>

@optional
- (void)fetchDataSourceWithInfoArr:(NSArray *)infoArr;

@end

@protocol ATViewRelatedPresenterOutput <NSObject>

@optional
- (void)renderDataSource:(NSArray *)dataSource;

@end

NS_ASSUME_NONNULL_END
