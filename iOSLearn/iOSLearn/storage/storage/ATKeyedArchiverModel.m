//
//  ATKeyedArchiverModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/28.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATKeyedArchiverModel.h"

@interface ATKeyedArchiverModel () <NSCoding>


@end

@implementation ATKeyedArchiverModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.age = [aDecoder decodeIntegerForKey:@"age"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
