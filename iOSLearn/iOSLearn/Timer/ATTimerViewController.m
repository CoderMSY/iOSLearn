//
//  ATTimerViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/5/2.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATTimerViewController.h"

@interface ATTimerViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation ATTimerViewController

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 1000; i ++) {
        [self.array addObject:@(i)];
    }
    
//    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(doSomething) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//    [self.timer fire];
    [self doSomething];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)doSomething {
//    static NSInteger i = 0;
//    NSLog(@"循环啦:%ld",(long)i++);
    
    for (NSNumber *i in self.array.copy) {
//        @autoreleasepool {
            if (99 == i.integerValue) {
                [self.array removeObject:i];
            }
            else {
                NSString *str = [NSString stringWithFormat:@"current number : %@",i];
                NSLog(@"%@",str);
            }
//        }
    }
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
