//
//  ATBaseNavigationController.m
//  AttendanceDemo
//
//  Created by SimonMiao on 2017/12/8.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import "ATBaseNavigationController.h"

@interface ATBaseNavigationController ()

@end

@implementation ATBaseNavigationController

#pragma mark - lifecycle methods

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.navigationBar.translucent = NO;
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UINavigationBar *navigationBar = [UINavigationBar appearance];
        navigationBar.barTintColor = [UIColor whiteColor];
        if ([navigationBar respondsToSelector:@selector(shadowImage)]) {
            [navigationBar setShadowImage:[[UIImage alloc]init]];
        }
        self.navigationBar.translucent = YES;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate{
    return [[self.viewControllers lastObject] shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

#pragma mark - public methods


#pragma mark - private methods

- (void)backLastController {
    [self popViewControllerAnimated:YES];
}

#pragma mark - getter && setter



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
