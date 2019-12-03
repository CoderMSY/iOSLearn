//
//  ATViewRelatedController.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/11/28.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATViewAndLayerController.h"

@interface ATViewAndLayerController ()

@end

@implementation ATViewAndLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 100)];
    imageView.userInteractionEnabled = YES;//has set YES
    imageView.backgroundColor = [UIColor grayColor];
//    imageView.clipsToBounds = NO;
    [self.view addSubview:imageView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, imageView.frame.size.height, 100, 50)];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"Click Me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickedButton) forControlEvents:UIControlEventTouchDown];
    [imageView addSubview:button];
    
    NSLog(@"imageView.userInteractionEnabled :%d", imageView.userInteractionEnabled);
}

- (void)didClickedButton
{
    NSLog(@"按钮点击了");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"Alert" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alertView show];
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
