//
//  ATKVCViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/26.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATKVCViewController.h"
#import "ATStudentKVCModel.h"

@interface ATKVCViewController ()

@end

@implementation ATKVCViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
//    mutDic setObject:<#(nonnull id)#> forKey:<#(nonnull id<NSCopying>)#>
//    [mutDic setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>]
    NSString *str = @"China";
//    [str setValue:@"America" forKey:@"name"];
    NSLog(@"%@",str);
    
    ATStudentKVCModel *kvcModel = [ATStudentKVCModel new];
    [kvcModel setValue:@"你好" forKey:@"name"];
    NSString *name = [kvcModel valueForKey:NSStringFromSelector(@selector(name))];
    NSLog(@"%@",name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)configOne:(NSString *)one two:(NSString *)two three:(NSString *)three {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
