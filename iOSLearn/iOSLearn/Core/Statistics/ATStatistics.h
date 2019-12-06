//
//  ATStatistics.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/4.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Aspects/Aspects.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString const *TJPVKey;
extern NSString const *TJEventKey;
extern NSString const *TJEventIDKey;
extern NSString const *TJEventConfigKey;
extern NSString const *TJSelectorStrKey;
extern NSString const *TJTargetKey;


typedef NS_ENUM(NSInteger, ATPageStatus){
    ///离开页面
    ATPageStatus_leave = 0,
    ///进入页面
    ATPageStatus_enter = 1
};

@interface ATStatistics : NSObject

@property (nonatomic, strong, readonly) NSDictionary *configureData;


/**
 生成单例的方法

 @return 单例对象
 */
+ (instancetype)shareInstance;


/**
 通过json配置文件导入配置信息
json配置文件或plist配置文件只导入一个就好了
 @param jsonFilePath json文件沙盒路径
 */
+ (void)configureDataWithJSONFile:(NSString *)jsonFilePath;


/**
 通过plist配置文件导入配置信息
json配置文件或plist配置文件只导入一个就好了
 @param plistFileName plist文件名字（不带后缀名）
 */
+ (void)configureDataWithPlistFile:(NSString *)plistFileName;


/**
 处理PV
这个方法需要开发者重载进行具体的操作
 @param data 页面信息
 @param status 进入或离开页面的状态
 */
+ (void)PPhandlePV:(id<AspectInfo>)data status:(ATPageStatus)status;


/**
 处理事件
这个方法需要开发者重载进行具体的操作
 @param data 事件信息
 @param eventId 事件ID
 */
+ (void)PPHandleEvent:(id<AspectInfo>)data EventID:(NSInteger)eventId;

@end

NS_ASSUME_NONNULL_END
