//
//  ATDeepShallowCopyViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/3.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATDeepShallowCopyViewController.h"
#import "Student.h"

@interface ATDeepShallowCopyViewController ()

@end

@implementation ATDeepShallowCopyViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int arrayName[4] = {10,20,30,40};
    /**
     1.(&arrayName + 1)：&arrayName是数组的地址（等价于指向arrayName数组的指针）
     2.增加 1 会往后移动16个字节，开始是4个字节的位置，移动后就是16个字节后面的位置（也就是目前位置是20个字节）
     3.最后又赋值给，int类型的指针p（int类型占4个字节）
     4.所以(p - 1)就是减去4个字节，变成为16个字节的位置，输出的*(p - 1)值为40
     */
    
    int *p = (int *)(&arrayName + 1);
    NSLog(@"%d",*(p - 1));
    NSLog(@"%p %p", arrayName, arrayName + 1);
    NSLog(@"%p %p", &arrayName, &arrayName + 1);
    //数组名 :表示数组首元素的地址，相当于一个指向数组首元素的指针
    
    /**
     1. arrayName 与 &arrayName
     arrayName 是数组名，所以打印出来是数组首元素的地址
     &arrayName 含义就是数组的地址（等价于指向arrayName数组的指针），因为没增加1，所以数组的地址就是数组首元素的地址所以 arrayName <->&arrayName 打印出的地址是一样的
     
     链接：https://www.jianshu.com/p/605858e5bcf3
     */
    
//    [self showLog];
    [self showArrCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public methods


#pragma mark - private methods

- (void)showLog {
    Student *stu1 = [[Student alloc] init];
    stu1.name = @"John";
    stu1.age = @"23";
    NSLog(@"stu1:%@ %@ %@",stu1, stu1.name, stu1.age);
    
    Student *stu2 = stu1.copy;
    NSLog(@"stu2:%@ %@ %@",stu2, stu1.name, stu2.age);
    
    Student *stu3 = stu1;
    NSLog(@"stu3:%@ %@ %@",stu3, stu1.name, stu3.age);
}

- (void)showArrCopy {
    /**
     copy 和 mutableCopy要实现对应的协议，一般自定义对象，只要实现copy熟悉就可以了。
     NSCopying协议与NSMutableCopying的区别主要是在于，返回的对象是否是可变类型的。如NSArray
     
     */
    NSArray *titleArr = @[@"1",@"2",@"3"];
    NSLog(@"titleArr:%@",titleArr);
    NSArray *copyTitleArr = titleArr.copy;
    
    NSLog(@"copyTitleArr:%@",copyTitleArr);
    
    NSMutableArray *mutCopyTitleArr = titleArr.mutableCopy;
    NSLog(@"mutCopyTitleArr:%@",mutCopyTitleArr);
    
    
    NSLog(@"titleArr = %p copyTitleArr = %p mutCopyTitleArr = %p", titleArr, copyTitleArr, mutCopyTitleArr);
    
    titleArr = @[@"1"];
    NSLog(@"titleArr:%@",titleArr);
    NSLog(@"copyTitleArr:%@",copyTitleArr);
    

//    [mutCopyTitleArr addObject:@"4"];
    
//    NSLog(@"mutCopyTitleArr:%@",mutCopyTitleArr);
    
    NSString *string = @"汉斯哈哈哈";
    // 没有产生新对象
    NSString *copyString = [string copy];
    // 产生新对象
    NSMutableString *mutableCopyString = [string mutableCopy];
    
    NSLog(@"string = %p copyString = %p mutableCopyString = %p", string, copyString, mutableCopyString);
    
    NSLog(@"string = %@ copyString = %@", string, copyString);
    NSString *tempString = string;
    string = @"123456";
    NSLog(@"string = %@ copyString = %@ tempString = %@", string, copyString, tempString);
    NSLog(@"string = %p copyString = %p tempString = %p", string, copyString, tempString);
    
    id tempCopyStr = [mutableCopyString copy];
//    [tempMutCopyStr appendString:@"modify"];copy返回的是不可变对象，mstr2不能被修改，因此会发生崩溃
    NSLog(@"不可变字符串%p - %@\r\n", tempCopyStr, tempCopyStr);
    
    if ([tempCopyStr isKindOfClass:[NSMutableString class]]) {
        NSLog(@"可变字符串%p - %@\r\n", tempCopyStr, tempCopyStr);
        NSMutableString *tempMutCopyStr = (NSMutableString *)tempCopyStr;
        
        NSLog(@"%p - %@\r\n", tempMutCopyStr, tempMutCopyStr);
    }
    else {
        
    }
}

#pragma mark - getter && setter

/**
 1.读写权限：readonly,readwrite(默认)
 2.原子性: atomic(默认)，nonatomic。atomic读写线程安全，但效率低，而且不是绝对的安全，比如如果修饰的是数组，那么对数组的读写是安全的，但如果是操作数组进行添加移除其中对象的还，就不保证安全了。
 3.引用计数：

 retain/strong
 assign：修饰基本数据类型，修饰对象类型时，不改变其引用计数，会产生悬垂指针，修饰的对象在被释放后，assign指针仍然指向原对象内存地址，如果使用assign指针继续访问原对象的话，就可能会导致内存泄漏或程序异常
 weak：不改变被修饰对象的引用计数，所指对象在被释放后，weak指针会自动置为nil
 copy：分为深拷贝和浅拷贝
 浅拷贝：对内存地址的复制，让目标对象指针和原对象指向同一片内存空间会增加引用计数
 深拷贝：对对象内容的复制，开辟新的内存空间

 源对象类型        拷贝类型         目标对象类型 拷贝类型(深/浅)
 mutable对象      copy                不可变            深拷贝
 mutable对象      mutableCopy  可变                深拷贝
 immutable对象  copy                不可变            浅拷贝
 immutable对象  mutableCopy  可变                深拷贝
 
 可变对象的copy和mutableCopy都是深拷贝
 不可变对象的copy是浅拷贝，mutableCopy是深拷贝
 copy方法返回的都是不可变对象

 @property (nonatomic, copy) NSMutableArray * array;这样写有什么影响？
 因为copy方法返回的都是不可变对象，所以array对象实际上是不可变的，如果对其进行可变操作如添加移除对象，则会造成程序crash

 作者：Theendisthebegi
 链接：https://www.jianshu.com/p/e70bac443cf2
 来源：简书
*/

@end
