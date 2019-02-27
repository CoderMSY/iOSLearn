//
//  ATStoreViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/2/26.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATStoreViewController.h"

static NSString *const kTextStore_archiver = @"归档";

@interface ATStoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation ATStoreViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"数据持久化";
    [self.view addSubview:self.tableView];
    
    [self loadDataSource];
}

#pragma mark - public methods


#pragma mark - private methods

- (void)loadDataSource {
    self.dataSource = @[kTextStore_archiver];
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
    if ([text isEqualToString:kTextStore_archiver]) {
        viewCtrName = @"ATStoreArchiverViewController";
    }
    else {
        NSLog(@"未找到对应的控制器");
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

@end
