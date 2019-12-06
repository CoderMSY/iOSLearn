//
//  ATPageVisitModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/4.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATPageVisitModel.h"
#import <BGFMDB/BGFMDB.h>

@implementation ATPageVisitModel

#pragma mark - BGFMDB

+ (NSArray *)bg_unionPrimaryKeys {
    return @[@"pageClass", @"pageTitle"];
}

//+ (NSArray *)bg_uniqueKeys {
//    return @[@"pageClass", @"pageTitle"];
//}

@end
