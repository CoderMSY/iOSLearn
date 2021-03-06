//
//  ATMultiThreadViewModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/30.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATMultiThreadViewModel.h"
#import "ATOperationViewController.h"

#import "ATOldCommonTableModel.h"

@implementation ATMultiThreadViewModel

- (NSArray *)getDataSource {

    NSArray *dataArr = @[@{
                             kCmn_title : kThreadText_thread,
                             kCmn_detail : @"",
                             },
                         @{
                             kCmn_title : kThreadText_GCD,
                             kCmn_detail : @"",
                             },
                         @{
                             kCmn_title : kThreadText_operation,
                             kCmn_detail : @"",
                             },
                         ];
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < dataArr.count; i ++) {
        NSDictionary *dic = dataArr[i];
        
        ATOldCommonTableModel *model = [[ATOldCommonTableModel alloc] init];
        model.title = dic[kCmn_title];
        model.detail = dic[kCmn_detail];
        model.actionName = dic[kCmn_action];
        
        [dataSource addObject:model];
    }
    
    return dataSource;
}

- (void)pushOperationViewController {
    ATOperationViewController *ctr = [[ATOperationViewController alloc] init];
    
    [self.viewController.navigationController pushViewController:ctr animated:YES];
}

@end
