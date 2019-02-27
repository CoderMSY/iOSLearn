//
//  ATStoreArchiverViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/2/26.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATStoreArchiverViewController.h"

@interface ATStoreArchiverViewController ()

@end

@implementation ATStoreArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"file.archiver"];
    
    //归档（序列化）
    NSArray *archiveAry = @[@"jereh",@"ios"];
    if ([NSKeyedArchiver archiveRootObject: archiveAry toFile:filePath]) {
        NSLog(@"Archiver  success");
    }
    
    //解归档（反序列化）
    NSArray *unArchiveAry = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",unArchiveAry);
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
