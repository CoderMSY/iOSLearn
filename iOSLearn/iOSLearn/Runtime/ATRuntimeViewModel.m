//
//  ATRuntimeViewModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/8.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATRuntimeViewModel.h"
#import <objc/runtime.h>
#import "ATDetailCodeViewController.h"
#import "ATPerson.h"

#import "ATCommonTableModel.h"

@implementation ATRuntimeViewModel

- (void)function1ItemClicked {
    NSLog(@"=================================================================");
    unsigned int count;
    
    //获取成员变量的数组的指针
    Ivar *ivars = class_copyIvarList([ATPerson class], &count);
    
    for (int i=0 ; i<count; i++) {
        Ivar ivar = ivars[i];
        //根据ivar获得其成员变量的名称
        const char *name = ivar_getName(ivar);
        //C的字符串转OC的字符串
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d == %@",i,key);
    }
    // 记得释放
    free(ivars);
    
    //如果你的成员私有,也可以获取到 比如_education
}

- (NSString *)getCodeContent {
//    Method method = class_getInstanceMethod([ATRuntimeViewModel class], @selector(function1ItemClicked));
//    IMP imp = method_getImplementation(method);
//
//    char *name = method_getTypeEncoding(method);
    
//    NSString *code = [NSString stringWithUTF8String:name];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.md" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *content = [[NSString alloc] initWithData:data
                                    encoding:NSUTF8StringEncoding];
    if (content == nil)
    {
        content = [[NSString alloc] initWithData:data
                                        encoding:NSASCIIStringEncoding];
    }
    
    
    return content;
}




- (NSArray *)getDataSource {
    NSArray *dataArr = @[@{
                             kCmn_title : kRuntimeText_1,
                             kCmn_detail : @"class_copyIvarList",
                             kCmn_action : @"function1ItemClicked"
                             },
                         @{
                             kCmn_title : kRuntimeText_2,
                             kCmn_detail : @"class_copyPropertyList",
                             kCmn_action : @"function2ItemClicked"
                             },
                         @{
                             kCmn_title : kRuntimeText_3,
                             kCmn_detail : @"class_copyMethodList",
                             kCmn_action : @"function3ItemClicked"
                             },
                         @{
                             kCmn_title : kRuntimeText_4,
                             kCmn_detail : @"class_copyProtocolList",
                             kCmn_action : @"function4ItemClicked"
                             },
                         @{
                             kCmn_title : kRuntimeText_5,
                             kCmn_detail : @"object_setIvar",
                             kCmn_action : @"function5ItemClicked"
                             },
                         @{
                             kCmn_title : kRuntimeText_6,
                             kCmn_detail : @"method_exchangeImplementations",
                             kCmn_action : @"function6ItemClicked"
                             },
                         @{
                             kCmn_title : kRuntimeText_7,
                             kCmn_detail : @"class_addMethod",
                             kCmn_action : @"function7ItemClicked"
                             },
                         @{
                             kCmn_title : kRuntimeText_8,
                             kCmn_detail : @"",
                             kCmn_action : @"function8ItemClicked"
                             },
                         @{
                             kCmn_title : kRuntimeText_9,
                             kCmn_detail : @"",
                             kCmn_action : @"function9ItemClicked"
                             },
                         ];
    
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < dataArr.count; i ++) {
        NSDictionary *dic = dataArr[i];
        
        ATCommonTableModel *model = [[ATCommonTableModel alloc] init];
        model.title = dic[kCmn_title];
        model.detail = dic[kCmn_detail];
        model.actionName = dic[kCmn_action];
        
        [dataSource addObject:model];
    }
    
    return dataSource;
}

- (void)presentDetailCodeViewCtrWithCode:(NSString *)codeText {
    ATDetailCodeViewController *ctr = [[ATDetailCodeViewController alloc] init];
    ctr.codeContent = codeText;
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:ctr];
    
    [self.viewController presentViewController:navCtr animated:YES completion:nil];
}

@end
