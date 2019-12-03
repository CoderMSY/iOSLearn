//
//  ATMultiThreadViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/13.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATMultiThreadViewController.h"
#import <Masonry/Masonry.h>

#import "ATMultiThreadViewModel.h"
#import "ATOldCommonTableView.h"
#import "ATOldCommonTableModel.h"

@interface ATMultiThreadViewController () <ATOldCommonTableViewDelegate>

@property (nonatomic, strong) ATMultiThreadViewModel *viewModel;
@property (nonatomic, strong) ATOldCommonTableView *commonTableView;

@end

@implementation ATMultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.commonTableView];
    [self initConstraints];
    
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lifecycle methods


#pragma mark - public methods


#pragma mark - private methods

- (void)initConstraints {
    [self.commonTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)loadDataSource {
    NSArray *dataSource = [self.viewModel getDataSource];
    self.commonTableView.dataSource = dataSource;
}

#pragma mark - ATOldCommonTableViewDelegate

- (void)commonTableView:(ATOldCommonTableView *)commonView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ATOldCommonTableModel *cmnModel = self.commonTableView.dataSource[indexPath.row];
    NSString *viewCtrName;
    if ([cmnModel.title isEqualToString:kThreadText_thread]) {
        viewCtrName = @"ATThreadViewController";
    }
    else if ([cmnModel.title isEqualToString:kThreadText_GCD]) {
        viewCtrName = @"ATGCDViewController";
    }
    else if ([cmnModel.title isEqualToString:kThreadText_operation]) {
        viewCtrName = @"ATOperationViewController";
    }
    
    UIViewController *viewController;
    if (viewCtrName.length > 0) {
        viewController = [[NSClassFromString(viewCtrName) alloc] init];
        viewController.title = cmnModel.title;
    }
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - getter && setter

- (ATMultiThreadViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ATMultiThreadViewModel alloc] init];
        _viewModel.viewController = self;
    }
    return _viewModel;
}

- (ATOldCommonTableView *)commonTableView {
    if (!_commonTableView) {
        _commonTableView = [[ATOldCommonTableView alloc] init];
        _commonTableView.delegate = self;
    }
    return _commonTableView;
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
