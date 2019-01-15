//
//  ATOperationModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/30.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATOperationModel.h"

@implementation ATOperationModel

- (void)modifyWithName:(NSString *)name {
    //    NSParameterAssert(name);
    self.name = name;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[ATOperationModel class]]) {
        return NO;
    }
    
    ATOperationModel *objectModel = (ATOperationModel *)object;
    
    return self.hash == objectModel.hash;
}

- (NSUInteger)hash {
    return [self.name hash] ^ [self.birthday hash];
}


@end
