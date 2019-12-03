//
//  ATViewAndLayerController.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/11/28.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATViewRelatedController.h"
#import <Masonry/Masonry.h>

#import "ATCommonTableView.h"
#import "ATTableViewProtocol.h"
#import "ATCommonTableData.h"
#import "ATViewRelatedPresenter.h"
#import "ATQuestionModel.h"

#import "ATContentViewController.h"

@interface ATViewRelatedController () <ATViewRelatedPresenterOutput, ATTableViewProtocol>

@property (nonatomic, strong) ATCommonTableView *listView;
@property (nonatomic, strong) ATViewRelatedPresenter *presenter;

@end

@implementation ATViewRelatedController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.listView];
    [self initConstraints];
    
    [self.presenter fetchDataSourceWithInfoArr:self.questionList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - public methods


#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - ATViewRelatedPresenterOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - ATTableViewProtocol

- (void)at_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ATCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    ATCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
        
    if (![rowModel.extraInfo isKindOfClass:[ATQuestionModel class]]) {
        return;
    }
    ATQuestionModel *qModel = (ATQuestionModel *)rowModel.extraInfo;
    
    UIViewController *viewController;
    if (qModel.controller.length > 0) {
        viewController = [[NSClassFromString(qModel.controller) alloc] init];
        viewController.title = rowModel.title;
    }
    
    if ([viewController isKindOfClass:[ATContentViewController class]]) {
        ATContentViewController *contentCtr = (ATContentViewController *)viewController;
        contentCtr.content = qModel.detail;
    }
    
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - getter && setter

- (ATCommonTableView *)listView {
    if (!_listView) {
        _listView = [[ATCommonTableView alloc] init];
    }
    return _listView;
}

- (ATViewRelatedPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[ATViewRelatedPresenter alloc] init];
        _presenter.output = self;
    }
    return _presenter;
}

@end
