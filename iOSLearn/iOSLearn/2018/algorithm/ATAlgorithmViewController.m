//
//  ATAlgorithmViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/5.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATAlgorithmViewController.h"
#import <Masonry/Masonry.h>

#import "ATCommonTableView.h"
#import "ATTableViewProtocol.h"
#import "ATCommonTableData.h"
#import "ATAlgorithmPresenter.h"
#import "ATQuestionModel.h"

@interface ATAlgorithmViewController () <ATAlgorithmPresenterOutput, ATTableViewProtocol>

@property (nonatomic, strong) ATCommonTableView *listView;
@property (nonatomic, strong) ATAlgorithmPresenter *presenter;

@end

@implementation ATAlgorithmViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.listView];
    [self initConstraints];
    
    [self.presenter fetchDataSourceWithList:self.questionList];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

/// 给定字符串 "hello,world",实现将其反转。输出结果：dlrow,olleh
- (void)charReverse
{
    NSString * string = @"hello,world";
    
    NSLog(@"%@",string);
    
    NSMutableString * reverString = [NSMutableString stringWithString:string];
    
    for (NSInteger i = 0; i < (string.length + 1)/2; i++) {
        NSString *targetStr = [string substringWithRange:NSMakeRange(i, 1)];
        NSString *changeStr = [string substringWithRange:NSMakeRange(string.length - i - 1, 1)];
        ATLog(@"targetStr:%@, changeStr:%@", targetStr, changeStr);
        
        [reverString replaceCharactersInRange:NSMakeRange(i, 1) withString:[string substringWithRange:NSMakeRange(string.length - i - 1, 1)]];
        
        [reverString replaceCharactersInRange:NSMakeRange(string.length - i - 1, 1) withString:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSLog(@"reverString:%@",reverString);
    
    //C
    char ch[100];
    memcpy(ch, [string cStringUsingEncoding:NSUTF8StringEncoding], [string length]);

   //设置两个指针，一个指向字符串开头，一个指向字符串末尾
    char * begin = ch;
    
    char * end = ch + strlen(ch) - 1;
   
//遍历字符数组，逐步交换两个指针所指向的内容，同时移动指针到对应的下个位置，直至begin>=end
    while (begin < end) {
        
        char temp = *begin;
        
        *(begin++) = *end;
        
        *(end--) = temp;
    }
    
    NSLog(@"reverseChar[]:%s",ch);
}

- (void)functionItemClicked1 {
    
}

- (void)functionItemClicked2 {
    
}

#pragma mark - ATAlgorithmPresenterOutput

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
        
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else {
        switch (indexPath.row) {
            case 0:
                [self charReverse];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - getter && setter

- (ATCommonTableView *)listView {
    if (!_listView) {
        _listView = [[ATCommonTableView alloc] init];
    }
    return _listView;
}

- (ATAlgorithmPresenter *)presenter {
    if (!_presenter) {
        _presenter = [[ATAlgorithmPresenter alloc] init];
        _presenter.output = self;
    }
    return _presenter;
}

@end
