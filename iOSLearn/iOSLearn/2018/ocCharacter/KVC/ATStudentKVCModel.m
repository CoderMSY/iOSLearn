//
//  ATStudentKVOModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/26.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATStudentKVCModel.h"

@implementation ATStudentKVCModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    ATLog(@"undefinedKey:%@ value:%@", key, value);
}

- (id)valueForUndefinedKey:(NSString *)key {
    ATLog(@"undefinedKey:%@", key);
    return nil;
}

@end
