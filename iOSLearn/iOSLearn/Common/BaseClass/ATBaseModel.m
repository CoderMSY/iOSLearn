//
//  ATBaseModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATBaseModel.h"

@implementation ATBaseModel

+ (ATBaseModel *)decodeFromDic:(NSDictionary *)dic {
    NSLog(@"子类请实现转模型方法");
    return nil;
}

+ (NSArray *)decodeFromArray:(NSArray *)list {
    NSLog(@"子类请实现转模型数组方法");
    
    return nil;
}

@end
