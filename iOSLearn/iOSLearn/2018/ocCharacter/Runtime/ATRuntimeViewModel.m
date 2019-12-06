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
#import "ATRuntimePerson.h"

#import "ATCommonTableData.h"

@implementation ATRuntimeViewModel

- (void)function1ItemClicked {
    NSLog(@"=================================================================");
    unsigned int count;
    
    //获取成员变量的数组的指针
    Ivar *ivars = class_copyIvarList([ATRuntimePerson class], &count);
    
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
    NSArray *rowArr = @[
        @{
            kRow_title : kRuntimeText_1,
            kRow_detailTitle : @"class_copyIvarList",
            kRow_extraInfo : @"function1ItemClicked"
        },
        @{
            kRow_title : kRuntimeText_2,
            kRow_detailTitle : @"class_copyPropertyList",
            kRow_extraInfo : @"function2ItemClicked"
        },
        @{
            kRow_title : kRuntimeText_3,
            kRow_detailTitle : @"class_copyMethodList",
            kRow_extraInfo : @"function3ItemClicked"
        },
        @{
            kRow_title : kRuntimeText_4,
            kRow_detailTitle : @"class_copyProtocolList",
            kRow_extraInfo : @"function4ItemClicked"
        },
        @{
            kRow_title : kRuntimeText_5,
            kRow_detailTitle : @"object_setIvar",
            kRow_extraInfo : @"function5ItemClicked"
        },
        @{
            kRow_title : kRuntimeText_6,
            kRow_detailTitle : @"method_exchangeImplementations",
            kRow_extraInfo : @"function6ItemClicked"
        },
        @{
            kRow_title : kRuntimeText_7,
            kRow_detailTitle : @"class_addMethod",
            kRow_extraInfo : @"function7ItemClicked"
        },
        @{
            kRow_title : kRuntimeText_8,
            kRow_detailTitle : @"",
            kRow_extraInfo : @"function8ItemClicked"
        },
        @{
            kRow_title : kRuntimeText_9,
            kRow_detailTitle : @"",
            kRow_extraInfo : @"function9ItemClicked"
        }
    ];
    
    NSMutableArray *rowList = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < rowArr.count; i ++) {
        NSDictionary *dic = rowArr[i];
        
        NSMutableDictionary *rowDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        rowDic[kRow_cellClass] = @"ATRuntimeCell";
        
        [rowList addObject:rowDic];
    }
    
    NSDictionary *sectionDic = @{
        kSec_rowContent : rowList,
        kSec_headerHeight : @(15.0),
        kSec_footerHeight : @(15.0),
    };
    NSArray *sectionArr = [ATCommonTableSection sectionsWithData:@[sectionDic]];
    
    return sectionArr;
}

- (void)presentDetailCodeViewCtrWithCode:(NSString *)codeText {
    ATDetailCodeViewController *ctr = [[ATDetailCodeViewController alloc] init];
    ctr.codeContent = codeText;
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:ctr];
    
    [self.viewController presentViewController:navCtr animated:YES completion:nil];
}

@end
