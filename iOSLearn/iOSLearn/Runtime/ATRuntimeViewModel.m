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
    NSArray *dataSource = @[kRuntimeText_1,
                            kRuntimeText_2,
                            kRuntimeText_3,
                            kRuntimeText_4,
                            kRuntimeText_5,
                            kRuntimeText_6,
                            kRuntimeText_7,
                            kRuntimeText_8,
                            kRuntimeText_9];
    return dataSource;
}

- (void)presentDetailCodeViewCtrWithCode:(NSString *)codeText {
    ATDetailCodeViewController *ctr = [[ATDetailCodeViewController alloc] init];
    ctr.codeContent = codeText;
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:ctr];
    
    [self.viewController presentViewController:navCtr animated:YES completion:nil];
}

@end
