//
//  ATSortViewModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/27.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATSortViewModel.h"
#import "ATCommonTableModel.h"

@implementation ATSortViewModel

- (NSArray *)getDataSource {
    NSArray *dataArr = @[@{
                             kCmn_title : kSortText_bubble,
                             kCmn_detail : @"",
                             kCmn_action : @"functionBubbleSort"
                             },
                         @{
                             kCmn_title : kSortText_selection,
                             kCmn_detail : @"",
                             kCmn_action : @"functionSelectionSort"
                             },
                         ];
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < dataArr.count; i ++) {
        NSDictionary *dic = dataArr[i];
        
        ATCommonTableModel *model = [[ATCommonTableModel alloc] init];
        model.title = dic[kCmn_title];
        model.detail = dic[kCmn_detail];
        model.actionName = dic[kCmn_action];
        
        [dataSource addObject:model];
    }
    
    return dataSource;
}

@end
