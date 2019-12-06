//
//  ATStatistics.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/4.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATStatistics.h"
#import "ATBaseViewController.h"
#import "ATDaoFactory.h"

NSString const *TJPVKey = @"PV";
NSString const *TJEventKey = @"Event";
NSString const *TJEventIDKey = @"EventID";
NSString const *TJEventConfigKey = @"EventConfig";
NSString const *TJSelectorStrKey = @"selectorStr";
NSString const *TJTargetKey = @"target";

@interface ATStatistics ()

@property (nonatomic,strong,readwrite) NSDictionary *configureData;

@end

@implementation ATStatistics

static ATStatistics *instance = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ATStatistics new];
    });

    return instance;
}

+ (void)configureDataWithJSONFile:(NSString *)jsonFilePath {
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    [ATStatistics shareInstance].configureData = dic;

    if ([ATStatistics shareInstance].configureData) {
        [self setUp];
    }
}


+ (void)configureDataWithPlistFile:(NSString *)plistFileName {
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistFileName ofType:@"plist"]];
    [ATStatistics shareInstance].configureData = dic;

    if ([ATStatistics shareInstance].configureData) {
        [self setUp];
    }

}


+ (void)setUp {
    [self configController];
//    [self configEvents];
}

#pragma mark PVConfig - - - -

+ (void)configController {
    [ATBaseViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo>info) {
        [self PPhandlePV:info status:ATPageStatus_enter];
    } error:nil];

    [ATBaseViewController aspect_hookSelector:@selector(viewDidDisappear:) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo>info) {
        [self PPhandlePV:info status:ATPageStatus_leave];
        
        //调用的实例对象
//        id instance = info.instance;
        //原始的方法
//        id invocation = info.originalInvocation;
        //参数
//        id arguments = info.arguments;
        //原始的方法，再次调用
//        [invocation invoke];
        
    } error:nil];
    
//    for (NSString *vcName in [[TJ shareInstance].configureData[TJPVKey] allKeys]) {
//
//        Class target = NSClassFromString(vcName);
//
//        [target aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo>info) {
//            [self PPhandlePV:info status:TJPV_ENTER];
//        } error:nil];
//
//        [target aspect_hookSelector:@selector(viewDidDisappear:) withOptions:AspectPositionAfter usingBlock:^(id <AspectInfo>info) {
//            [self PPhandlePV:info status:TJPV_LEAVE];
//        } error:nil];
//    }
    
}



+ (void)PPhandlePV:(id<AspectInfo>)info status:(ATPageStatus)status {
    if (ATPageStatus_enter == status) {
        id instance = info.instance;
        if ([instance isKindOfClass:[ATBaseViewController class]]) {
//            NSString *className = NSStringFromClass([[info instance] class]);
//            ATLog(@"className:%@ status:%ld", className, (long)status);
            ATBaseViewController *viewCtr = (ATBaseViewController *)instance;
            
            [[_Dao getVisitDao] saveVisitCountWithPageClass:NSStringFromClass([instance class])
                                                  pageTitle:viewCtr.title];
        }
        
    }
}

#pragma mark EventConfig - - - -

+ (void)configEvents{

    NSDictionary *eventsDic = [ATStatistics shareInstance].configureData[TJEventKey];
    NSArray *events =[eventsDic allValues];
    for (NSDictionary *dic in events) {
        NSInteger EventID = [dic[TJEventIDKey] integerValue];
        NSArray *eventConfigs = [dic[TJEventConfigKey] allValues];
        for (NSDictionary *eventConfig in eventConfigs) {
            NSString *selectorStr = eventConfig[TJSelectorStrKey];
            NSString *targetClass = eventConfig[TJTargetKey];
            Class target =NSClassFromString(targetClass);
            SEL selector = NSSelectorFromString(selectorStr);

//                [target aspect_hookSelector:selector withOptions:TJAspectPositionBefore usingBlock:^(id<TJAspectInfo> data){
//                    [self PPHandleEvent:data EventID:EventID];
//                } error:nil];
            [target aspect_hookSelector:selector withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>info) {
                [self PPHandleEvent:info EventID:EventID];
            } error:nil];
        }
    }


}

+ (void)PPHandleEvent:(id<AspectInfo>)info EventID:(NSInteger)eventId {
    ATLog(@"PPHandleEvent:%@ EventID:%ld", info, (long)eventId);
}

@end
