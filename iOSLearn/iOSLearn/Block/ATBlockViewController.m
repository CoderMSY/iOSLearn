//
//  ATBlockViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/27.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATBlockViewController.h"

int global_i = 1;

static int static_global_j = 2;

@interface ATBlockViewController ()

@end

@implementation ATBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testGlobal];
    [self testBlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testBlock {
    int i = 10;//i为__block变量，可在block中重新赋值
    void (^blk)(void) = ^{
        NSLog(@"In block, i = %d", i);
    };
    i = 20;
    blk();//打印: In block, i = 20
    NSLog(@"i = %d", i);//打印：i = 20
}

- (void)testGlobal {
    static int static_k = 3;
    int val = 4;
    
    void (^myBlock)(void) = ^{
        global_i ++;
        static_global_j ++;
        static_k ++;
        NSLog(@"Block中 global_i = %d,static_global_j = %d,static_k = %d,val = %d",global_i,static_global_j,static_k,val);
    };
    
    global_i ++;
    static_global_j ++;
    static_k ++;
    val ++;
    NSLog(@"Block外 global_i = %d,static_global_j = %d,static_k = %d,val = %d",global_i,static_global_j,static_k,val);
    
    myBlock();
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
