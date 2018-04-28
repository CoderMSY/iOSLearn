//
//  ATSortViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/27.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATSortViewController.h"
#import <Masonry/Masonry.h>

#import "ATSortViewModel.h"
#import "ATCommonTableView.h"
#import "ATCommonTableModel.h"

@interface ATSortViewController () <ATCommonTableViewDelegate>

@property (nonatomic, strong) ATSortViewModel *viewModel;
@property (nonatomic, strong) ATCommonTableView *commonTableView;

@end

@implementation ATSortViewController

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


/**
 冒泡排序
 */
- (void)functionBubbleSort {
    NSMutableArray *arr_M = [NSMutableArray arrayWithObjects:@1,@4,@2,@3,@5,nil];
    
    //遍历`数组的个数`次
    /*
     i = 0 的时候，j的相邻两个位置都要比较排一下位置：
     j = 0 的时候：arr_M = 41235
     j = 1 的时候：arr_M = 42135
     j = 2 的时候：arr_M = 42315
     j = 3 的时候：arr_M = 42351
     
     i = 1;
     ……  ……
     */
    for (int i = 0; i < arr_M.count; ++i) {
        
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        for (int j = 0; j < arr_M.count-1; ++j) {
            
            //根据索引的`相邻两位`进行`比较`
            if (arr_M[j] < arr_M[j+1]) {
                
                [arr_M exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                NSLog(@"%@",arr_M);
            }
            
        }
    }
    
    NSLog(@"冒泡排序 最终结果：%@",arr_M);
}


/**
 选择排序
 */
- (void)functionSelectionSort {
    NSMutableArray *arr_M = [NSMutableArray arrayWithObjects:@1,@4,@2,@3,@5,nil];
    
    
    for (int i = 0; i < arr_M.count; i++) {
        
        for (int j = i + 1; j < arr_M.count; j++) {
            
            if (arr_M[i] < arr_M[j]) {
                
                [arr_M exchangeObjectAtIndex:i withObjectAtIndex:j];
                NSLog(@"%@",arr_M);
            }
            
        }
    }
    
    NSLog(@"选择排序 最终结果%@",arr_M);
}

#pragma mark - ATCommonTableViewDelegate

- (void)commonTableView:(ATCommonTableView *)commonView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ATCommonTableModel *cmnModel = self.commonTableView.dataSource[indexPath.row];
    if (cmnModel.actionName.length > 0) {
        SEL sel = NSSelectorFromString(cmnModel.actionName);
        if ([self respondsToSelector:sel]) {
            AT_SuppressPerformSelectorLeakWarning([self performSelector:sel]);
        }
        else {
            NSLog(@"方法未找到，请显示");
        }
    }
    else {
        NSLog(@"请传入方法名");
    }
}


#pragma mark - getter && setter

- (ATSortViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ATSortViewModel alloc] init];
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
