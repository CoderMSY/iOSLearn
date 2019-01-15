//
//  ATThreadSaleTicketViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/5/11.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATThreadSaleTicketViewController.h"

@interface ATThreadSaleTicketViewController ()
{
    NSInteger _ticketCount;//!<总票数
    NSInteger _gzSaleCount;
    NSInteger _bjSaleCount;
    
    NSThread * _window1;
    NSThread * _window2;
}

@end

@implementation ATThreadSaleTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ticketCount = 50;
    _gzSaleCount = 0;
    _bjSaleCount = 0;
    
//    [self configSaleThread];
    [self configSaleThreadOnRunLoop];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(threadExitNotice:) name:NSThreadWillExitNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSThreadWillExitNotification object:nil];
    //引起内存泄漏，导致无法进入dealloc方法，
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(saleTicket) onThread:_window1 withObject:nil waitUntilDone:NO];
//    [self performSelector:@selector(saleTicket) onThread:_window2 withObject:nil waitUntilDone:NO];
}

#pragma mark - notice

- (void)threadExitNotice:(NSNotification *)notice {
//    NSLog(@"%@",notice.object);
    NSLog(@"%@",[NSThread currentThread]);
}

#pragma mark - private method

- (void)configSaleThread {
    NSThread * window1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    window1.name = @"北京售票窗口";
    [window1 start];
    
    NSThread * window2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    window2.name = @"广州售票窗口";
    [window2 start];
}

#pragma mark - add runLoop
- (void)configSaleThreadOnRunLoop {
    NSThread * window1 = [[NSThread alloc] initWithTarget:self selector:@selector(thread1) object:nil];
    [window1 start];
    _window1 = window1;
    
//    NSThread * window2 = [[NSThread alloc] initWithTarget:self selector:@selector(thread2) object:nil];
//    [window2 start];
//    _window2 = window2;
}

- (void)thread1 {
    [NSThread currentThread].name = @"北京售票窗口";
    @autoreleasepool {
        NSRunLoop * runLoop1 = [NSRunLoop currentRunLoop];
//            [runLoop1 runUntilDate:[NSDate date]]; //一直运行
        //如果注释了下面这一行，子线程中的任务并不能正常执行
        [runLoop1 addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop1 run];
    }
}
- (void)thread2 {
    [NSThread currentThread].name = @"广州售票窗口";
    
    @autoreleasepool {
        NSRunLoop * runLoop2 = [NSRunLoop currentRunLoop];
        [runLoop2 runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10.0]]; //自定义运行时间
//        [runLoop2 addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
//        [runLoop2 run];
    }
}

// 线程启动后，执行saleTicket，执行完毕后就会退出，为了模拟持续售票的过程，我们需要给它加一个循环
- (void)saleTicket {
    while (1) {
        @synchronized(self) {
            //如果还有票，继续售卖
            if (_ticketCount > 0) {
                _ticketCount --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", _ticketCount, [NSThread currentThread].name]);
                
                if ([[NSThread currentThread].name isEqualToString:@"北京售票窗口"]) {
                    _bjSaleCount ++;
                }
                else {
                    _gzSaleCount ++;
                }
                [NSThread sleepForTimeInterval:0.2];
            }
            //如果已卖完，关闭售票窗口
            else {
                NSLog(@"%@",[NSThread currentThread]);
                if ([[NSThread currentThread].name isEqualToString:@"北京售票窗口"]) {
                    NSLog(@"北京卖出：%ld",_bjSaleCount);
                }
                else {
                    NSLog(@"广州卖出：%ld",_gzSaleCount);
                }
                
                if ([NSThread currentThread].isCancelled) {
//                    [NSThread exit];
                    break;
                }
                else {
                    //给当前线程标记为取消状态
                    [[NSThread currentThread] cancel];
                    //停止当前线程的runLoop
                    CFRunLoopStop(CFRunLoopGetCurrent());
                }
            }
        }
    }
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
