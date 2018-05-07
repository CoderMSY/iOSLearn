//
//  ATGCDViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/30.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATGCDViewController.h"

@interface ATGCDViewController ()

@end

@implementation ATGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testSerial];
    [self testConcurrent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testSerial {
    dispatch_queue_t queue = dispatch_queue_create("com.avatar.interview", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"1");
//        dispatch_sync(queue, ^{
//            NSLog(@"2");
//        });
        NSLog(@"3");
    });
    
}

- (void)testConcurrent {
    dispatch_queue_t queue2 = dispatch_queue_create("com.avatar.interview2", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"0");
    dispatch_async(queue2, ^{
        NSLog(@"1");
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"2");
//        });
        NSLog(@"3");
    });
    NSLog(@"4");
//    while (1) {
//    }
    NSLog(@"5");
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
