//
//  ATGCDViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/30.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATGCDViewController.h"
#import "Foo.h"

@interface ATGCDViewController ()

@end

@implementation ATGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testSerial];
//    [self testConcurrent];
//    [self testS];
//    [self testSemaphote];
    
//    [self dispatchTest1];
//    [self performSerial];
    
//    [self asyncConcurrent];
//    [self syncMain];
    
    [self gcdResident];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gcdResident {
//    dispatch_queue_t queue = dispatch_queue_create("标识符", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 300 ; i++) {
        dispatch_async(queue, ^(void) {
            [[Foo new] test];
//            sleep(2.0);
//            NSLog(@"%@",[NSThread currentThread]);
            NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"");
        });
    }
}

- (void)syncMain{
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"---start---");
    //使用同步函数封装三个任务
    dispatch_sync(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    NSLog(@"---end---");
}
/**
 * 异步执行 + 并行队列
 * 异步执行意味着
 
 可以开启新的线程
 
 任务可以先绕过不执行，回头再来执行
 
 并行队列意味着
 
 任务之间不需要排队，且具有同时被执行的“权利”
 
 两者组合后的结果
 
 开了三个新线程
 
 函数在执行时，先打印了start和end，再回头执行这三个任务
 
 这三个任务是同时执行的，没有先后，所以打印结果是“任务3-->任务2-->任务1”
 

 */
- (void)asyncConcurrent{
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("标识符", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"---start---");
    
    //使用异步函数封装三个任务
    dispatch_async(queue, ^{
        NSLog(@"任务1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3---%@", [NSThread currentThread]);
    });
    
    NSLog(@"---end---");
}

- (void)performSerial {
    dispatch_queue_t queue = dispatch_queue_create("com.avatar.interview", DISPATCH_QUEUE_SERIAL);
    
    for (NSInteger i = 0; i < 1000; i ++) {
        dispatch_async(queue, ^{
            NSLog(@"%ld, for in dispatch_async serial_queue, current thread = %@", (long)i, [NSThread currentThread]);
        });
    }
}

- (void)dispatchTest1 {
    //链接：https://www.jianshu.com/p/7eaedfc8f8f6
    for (NSInteger i = 0; i< 60 ; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self dispatchTask:i];
            NSLog(@"%ld, for in dispatch_async global_queue, current thread = %@", (long)i, [NSThread currentThread]);
        });
    }
}

- (void)dispatchTask:(NSInteger)index {
    //模拟耗时操作，比如DB,网络，文件读写等等
    sleep(30);
    NSLog(@"----:%ld",index);
}

- (void)testSemaphote {
    dispatch_semaphore_t signal;
    signal = dispatch_semaphore_create(1);
    __block long x = 0;
    NSLog(@"0_x:%ld",x);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        NSLog(@"waiting");
        x = dispatch_semaphore_signal(signal);
        NSLog(@"1_x:%ld",x);
        
        sleep(2);
        NSLog(@"waking");
        x = dispatch_semaphore_signal(signal);
        NSLog(@"2_x:%ld",x);
    });
    //    dispatch_time_t duration = dispatch_time(DISPATCH_TIME_NOW, 1*1000*1000*1000); //超时1秒
    //    dispatch_semaphore_wait(signal, duration);
    
    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"3_x:%ld",x);
    
    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"wait 2");
    NSLog(@"4_x:%ld",x);
    
    x = dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    NSLog(@"wait 3");
    NSLog(@"5_x:%ld",x);
}

- (void)testS {
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    dispatch_queue_t queue = dispatch_queue_create("com.avatar.interview", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"start date:%@",[NSDate date]);
    for (NSInteger i = 0; i < 3000; i ++) {
        dispatch_async(queue, ^{
            NSLog(@"%ld, for in dispatch_async concurrentQueue1, current thread = %@", (long)i, [NSThread currentThread]);
            //First, 66 == 64 (the maximum GCD thread pool size) + the main thread + some other random non-GCD thread.
            //http://stackoverflow.com/questions/7213845/number-of-threads-created-by-gcd
//            dispatch_semaphore_signal(semaphore);
            if (2999 == i) {
                NSLog(@"end date:%@",[NSDate date]);
            }
        });
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    /**
    dispatch_async(queue, ^{
        NSLog(@"1, for in dispatch_async concurrentQueue1, current thread = %@", [NSThread currentThread]);
//        NSLog(@"run task 3");
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(queue, ^{
        NSLog(@"2, for in dispatch_async concurrentQueue1, current thread = %@", [NSThread currentThread]);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(queue, ^{
        NSLog(@"3, for in dispatch_async concurrentQueue1, current thread = %@", [NSThread currentThread]);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_async(queue, ^{
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"4, for in dispatch_async concurrentQueue1, current thread = %@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
     */
}

/**
 笔试同步队列
 */
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

/**
 笔试同步队列
 */
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
