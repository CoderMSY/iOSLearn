//
//  ATRuntimePerson.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/4.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATRuntimePerson.h"
#import <objc/runtime.h>

@interface ATRuntimePerson () <NSCoding>
{
    NSString *_testName;
}
@property (nonatomic,copy) NSString *education;//学历 私有变量

@end

@implementation ATRuntimePerson

//@synthesize testName = _testName;
@dynamic testName;

- (void)eat{
}

- (void)sleep{
    NSLog(@"抓紧睡觉");
}

-(NSString *)doSomeThing{
    return @"我要去爬山";
}

- (NSString *)doSomeOtherThing{
    return @"我要去唱歌";
}

//- (void)fromCity:(NSString *)city {
//    
//}

- (void)setTestName:(NSString *)testName {
    _testName = testName;
}

- (NSString *)testName {
    return _testName;
}



@end
