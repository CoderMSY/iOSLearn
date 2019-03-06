//
//  ATBaseViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/3.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATBaseViewController.h"

@interface ATBaseViewController ()

@end

@implementation ATBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@ willAppear,%s,%d",NSStringFromClass(self.class),__FUNCTION__,__LINE__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"-------------->%@,%s,%d",NSStringFromClass(self.class),__FUNCTION__,__LINE__);
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
