//
//  ATThreadViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/13.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATThreadViewController.h"
#import "ATTestModel.h"

@interface ATThreadViewController ()

@end

@implementation ATThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ATTestModel *firstModel = [[ATTestModel alloc] init];
    firstModel.name = @"1";
    firstModel.birthday = @(12);
    ATTestModel *secondModel = [[ATTestModel alloc] init];
    secondModel.name = @"1";
    secondModel.birthday = @(12);
    if ([firstModel isEqual:secondModel]) {
        NSLog(@"相同");
    }
    else {
        NSLog(@"不同");
    }
    ATTestModel *thirdModel = [[ATTestModel alloc] init];
    [thirdModel modifyWithName:nil];
    
    NSLog(@"isMainThread：%d currentThread:%@",[NSThread isMainThread],[NSThread currentThread]);
    
    //1 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
//   [NSOperationQueue mainQueue];
    //https://www.jianshu.com/p/0bbfbc41d181
    //2.1 创建操作1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务1-正在下载图片1----%@",[NSThread currentThread]);
    }];
    //2.2 创建操作2
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务1-正在下载图片2----%@",[NSThread currentThread]);
    }];
    //2.3 创建操作3
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务1-正在下载图片3----%@",[NSThread currentThread]);
    }];
    
    //3.1 加入队列方式1
    [queue addOperation:operation1];
    //3.2 加入队列方式2
    [queue addOperations:@[operation2,operation3] waitUntilFinished:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
