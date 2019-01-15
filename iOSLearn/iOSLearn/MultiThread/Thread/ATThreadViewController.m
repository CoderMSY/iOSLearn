//
//  ATThreadViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/5/11.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATThreadViewController.h"
#import <Masonry/Masonry.h>

#import "ATCommonTableView.h"
#import "ATCommonTableModel.h"

#import "ATThreadViewModel.h"

@interface ATThreadViewController () <ATCommonTableViewDelegate>

@property (nonatomic, strong) ATThreadViewModel *viewModel;
@property (nonatomic, strong) ATCommonTableView *commonTableView;

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

#pragma mark - ATCommonTableViewDelegate

- (void)commonTableView:(ATCommonTableView *)commonView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ATCommonTableModel *cmnModel = self.commonTableView.dataSource[indexPath.row];
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

- (ATCommonTableView *)commonTableView {
    if (!_commonTableView) {
        _commonTableView = [[ATCommonTableView alloc] init];
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
