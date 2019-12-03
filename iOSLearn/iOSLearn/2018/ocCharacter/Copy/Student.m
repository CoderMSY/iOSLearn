//
//  Student.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/3.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "Student.h"

@interface Student () <NSCopying>

@end

@implementation Student

- (id)copyWithZone:(NSZone *)zone {
    Student *model = [[self.class allocWithZone:zone] init];
    model.name = self.name;
    model.age = self.age;
    
    return model;
}

@end
