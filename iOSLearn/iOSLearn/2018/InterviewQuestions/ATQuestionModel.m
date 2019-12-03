//
//  ATQuestionModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATQuestionModel.h"

@implementation ATQuestionModel

+ (ATBaseModel *)decodeFromDic:(NSDictionary *)dic {
    ATQuestionModel *model = [self mj_objectWithKeyValues:dic];
    
    return model;
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"list" : NSStringFromClass([ATQuestionModel class])
    };
}

@end
