//
//  ATPerson.h
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/4.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ATPersonDelegate <NSObject>

- (void)personPayForFun:(NSInteger)money;

@end

@interface ATPerson : NSObject

#pragma mark -属性
@property (nonatomic,assign) id<ATPersonDelegate> delegate;
@property (nonatomic,copy) NSString *name;//姓名
@property (nonatomic,copy) NSString *sex;//性别
@property (nonatomic,assign) NSInteger age;//年龄
@property (nonatomic,assign) float height;//身高
@property (nonatomic,copy) NSString *job;//工作
@property (nonatomic,copy) NSString *native;//籍贯

#pragma mark -方法
- (void)eat;
- (void)sleep;
- (NSString *)doSomeThing;
- (NSString *)doSomeOtherThing;

//- (void)fromCity:(NSString *)city;

@end
