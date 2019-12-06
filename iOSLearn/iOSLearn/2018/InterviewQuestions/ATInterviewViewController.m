//
//  ATInterviewViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/11/28.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATInterviewViewController.h"
#import <Masonry/Masonry.h>
#import "ATCommonTableView.h"
#import "ATTableViewProtocol.h"
#import "ATCommonTableData.h"
#import "ATInterviewPresenter.h"
#import "ATQuestionModel.h"

#import "ATViewRelatedController.h"
#import "ATAlgorithmViewController.h"

@interface ATInterviewViewController () <ATInterviewPresenterOutput, ATTableViewProtocol>

@property (nonatomic, strong) ATInterviewPresenter *presenter;
@property (nonatomic, strong) ATCommonTableView *listView;

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation ATInterviewViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"2018";
    
    [self.view addSubview:self.listView];
    [self initConstraints];
    
    [self.presenter fetchDataSource];
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

#pragma mark - ATInterviewPresenterOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - ATTableViewProtocol

- (void)at_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ATCommonTableSection *sectionModel = self.listView.dataSource[indexPath.section];
    ATCommonTableRow *rowModel = sectionModel.rows[indexPath.row];
//    NSString *viewCtrName;
//    NSArray *infoArr;
//    if ([rowModel.title isEqualToString:kText_uiInfo]) {
//        viewCtrName = @"ATViewRelatedController";
//
//        infoArr = @[
//            @{
//                kRow_title : kText_uiInfo_0
//            },
//            @{
//                kRow_title : kText_uiInfo_1,
//                kRow_detailTitle : kText_uiInfo_detail_1
//            },
//            @{
//                kRow_title : kText_uiInfo_2,
//                kRow_detailTitle : kText_uiInfo_detail_2
//            },
//            @{
//                kRow_title : kText_uiInfo_3,
//                kRow_detailTitle : kText_uiInfo_detail_3
//            }
//        ];
//    }
//    else if ([rowModel.title isEqualToString:kText_ocCharacter]) {
//        viewCtrName = @"ATViewRelatedController";
//        infoArr = @[
//            @{
//                kRow_title : kText_ocCharacter_0
//            },
//            @{
//                kRow_title : kText_ocCharacter_1
//            },
//            @{
//                kRow_title : kText_ocCharacter_2
//            },
//            @{
//                kRow_title : kText_ocCharacter_3
//            },
//            @{
//                kRow_title : kText_ocCharacter_4
//            },
//            @{
//                kRow_title : kText_ocCharacter_5
//            },
//            @{
//                kRow_title : kText_ocCharacter_6
//            }
//        ];
//    }
//    else {
//        NSLog(@"未找到对应的控制器");
//
//        return;
//    }
    
    if (![rowModel.extraInfo isKindOfClass:[ATQuestionModel class]]) {
    }
    
    ATQuestionModel *qModel = (ATQuestionModel *)rowModel.extraInfo;
    
    UIViewController *viewController;
    if (qModel.controller.length > 0) {
        viewController = [[NSClassFromString(qModel.controller) alloc] init];
        viewController.title = rowModel.title;
    }
    else {
        ATLog(@"未找到对应的控制器");
        
        return;
    }
    
    if ([viewController isKindOfClass:[ATViewRelatedController class]]) {
        ATViewRelatedController *viewRelatedCtr = (ATViewRelatedController *)viewController;
        viewRelatedCtr.questionList = qModel.list;
    }
    else if ([viewController isKindOfClass:[ATAlgorithmViewController class]]) {
        ATAlgorithmViewController *algorithmCtr = (ATAlgorithmViewController *)viewController;
        algorithmCtr.questionList = qModel.list;
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

- (ATInterviewPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[ATInterviewPresenter alloc] init];
        _presenter.output = self;
    }
    return _presenter;
}

@end
