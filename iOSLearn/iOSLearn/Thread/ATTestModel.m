//
//  ATTestModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/16.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATTestModel.h"

@implementation ATTestModel

- (void)modifyWithName:(NSString *)name {
//    NSParameterAssert(name);
    self.name = name;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[ATTestModel class]]) {
        return NO;
    }
    
    ATTestModel *objectModel = (ATTestModel *)object;
    
    return self.hash == objectModel.hash;
}

- (NSUInteger)hash {
    return [self.name hash] ^ [self.birthday hash];
}

@end
