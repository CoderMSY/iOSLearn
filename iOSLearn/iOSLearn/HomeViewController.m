//
//  HomeViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/3.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "HomeViewController.h"

static NSString *const kText_copy = @"深拷贝与浅拷贝";
static NSString *const kText_runtime = @"runtime";
static NSString *const kText_KVC = @"KVC";
static NSString *const kText_KVO = @"KVO";
static NSString *const kText_thread = @"线程";
static NSString *const kText_pool = @"autoreleasePool";
static NSString *const kText_video = @"视频";
static NSString *const kText_sort = @"排序";
static NSString *const kText_block = @"block";
static NSString *const kText_storage = @"数据持久化";
static NSString *const kText_timer = @"定时器";
@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation HomeViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"知识点";
    [self.view addSubview:self.tableView];
    
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - public methods


#pragma mark - private methods

- (void)loadDataSource {
    self.dataSource = @[kText_copy,kText_runtime,kText_KVC,kText_KVO,kText_thread,kText_pool,kText_sort,kText_block,kText_storage,kText_timer];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDataDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.dataSource[indexPath.row];
    NSString *viewCtrName;
    if ([text isEqualToString:kText_copy]) {
        viewCtrName = @"ATDeepShallowCopyViewController";
    }
    else if ([text isEqualToString:kText_runtime]) {
        viewCtrName = @"ATRuntimeViewController";
    }
    else if ([text isEqualToString:kText_KVC]) {
        viewCtrName = @"ATKVCViewController";
    }
    else if ([text isEqualToString:kText_KVO]) {
        viewCtrName = @"ATKVOViewController";
    }
    else if ([text isEqualToString:kText_thread]) {
        viewCtrName = @"ATThreadViewController";
    }
    else if ([text isEqualToString:kText_pool]) {
        viewCtrName = @"ATPoolViewController";
    }
    else if ([text isEqualToString:kText_sort]) {
        viewCtrName = @"ATSortViewController";
    }
    else if ([text isEqualToString:kText_block]) {
        viewCtrName = @"ATBlockViewController";
    }
    else if ([text isEqualToString:kText_storage]) {
        viewCtrName = @"ATStorageViewController";
    }
    else if ([text isEqualToString:kText_timer]) {
        viewCtrName = @"ATTimerViewController";
    }
    UIViewController *viewController;
    if (viewCtrName.length > 0) {
        viewController = [[NSClassFromString(viewCtrName) alloc] init];
        viewController.title = text;
    }
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - getter && setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
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
