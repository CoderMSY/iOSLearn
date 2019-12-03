//
//  ATThreadViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/5/11.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATThreadViewController.h"
#import <Masonry/Masonry.h>

#import "ATOldCommonTableView.h"
#import "ATOldCommonTableModel.h"

#import "ATThreadViewModel.h"

@interface ATThreadViewController () <ATOldCommonTableViewDelegate>

@property (nonatomic, strong) ATThreadViewModel *viewModel;
@property (nonatomic, strong) ATOldCommonTableView *commonTableView;

@end

@implementation ATThreadViewController

#pragma mark - lifecycle methods

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

- (void)dealloc {
    
}



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
    if ([cmnModel.title isEqualToString:kThreadText_saleTicket]) {
        viewCtrName = @"ATThreadSaleTicketViewController";
    }
    else if ([cmnModel.title isEqualToString:kThreadText_memory]) {
        viewCtrName = @"ATThreadMemoryViewController";
    }
    else if ([cmnModel.title isEqualToString:kThreadText_threadRunLoop]) {
        viewCtrName = @"ATThreadRunLoopViewController";
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

- (ATThreadViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ATThreadViewModel alloc] init];
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
