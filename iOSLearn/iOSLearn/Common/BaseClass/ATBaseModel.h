//
//  ATBaseModel.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATBaseModel : NSObject

+ (ATBaseModel *)decodeFromDic:(NSDictionary *)dic;

+ (NSArray *)decodeFromArray:(NSArray *)list;

@end

NS_ASSUME_NONNULL_END
