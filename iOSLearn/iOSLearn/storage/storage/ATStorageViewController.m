//
//  ATStorageViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/28.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATStorageViewController.h"
//#import <Masonry/Masonry.h>

#import "ATKeyedArchiverModel.h"

@interface ATStorageViewController ()

@end

@implementation ATStorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /**
     对于一些规律性的，量级比较大的数据，又有规律可循的数据，我们可以选择建表或者使用Apple提供的CoreData进行持久化的存储！
     
     那么如果数据的量级不是很大，没有必要动用数据库或者是CoreData这种大规模的杀伤性武器的时候，而且又对数据的安全性和持久性有那么些要求的时候，我们最好去选择对象序列化这种中等杀伤性工具了！
     链接：https://www.jianshu.com/p/2beb453fb9d3
     */
    UIBarButtonItem *archiveItem = [[UIBarButtonItem alloc] initWithTitle:@"归档" style:UIBarButtonItemStylePlain target:self action:@selector(archiveObject)];
    UIBarButtonItem *unarchiveItem = [[UIBarButtonItem alloc] initWithTitle:@"解档" style:UIBarButtonItemStylePlain target:self action:@selector(unarchiveObject)];
    self.navigationItem.rightBarButtonItems = @[archiveItem,unarchiveItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)archiveObject {
    //只有遵守了NSCoding协议的类才可以用NSKeyedArchiver归档和NSKeyedUnarchiver解档，如果对象是NSString、NSDictionary、NSArray、NSData、NSNumber等类型，可以直接用NSKeyedArchiver归档和NSKeyedUnarchiver解档～
    ATKeyedArchiverModel *model = [[ATKeyedArchiverModel alloc] init];
    model.name = @"cathy";
    model.age = 18;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 这个文件后缀可以是任意的，只要不与常用文件的后缀重复即可，我喜欢用data
    NSString *filePath = [path stringByAppendingPathComponent:@"student.data"];
    // 归档
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}

- (void)unarchiveObject {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"student.data"];
    // 解档
    ATKeyedArchiverModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@----%ld", model.name, model.age);
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
