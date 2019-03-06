//
//  ATPerson+addProperty.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/4.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATPerson+addProperty.h"
#import <objc/runtime.h>

@implementation ATPerson (addProperty)

char eName;

- (void)setEnglishName:(NSString *)englishName {
//    objc_setAssociatedObject(self, &eName, englishName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, @selector(englishName), englishName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)englishName {
//    return objc_getAssociatedObject(self, &eName);
    return objc_getAssociatedObject(self, @selector(englishName));
}

- (void)setSchoolName:(NSString *)schoolName {
    objc_setAssociatedObject(self, @selector(schoolName), schoolName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)schoolName {
    return objc_getAssociatedObject(self, @selector(schoolName));
}

@end
