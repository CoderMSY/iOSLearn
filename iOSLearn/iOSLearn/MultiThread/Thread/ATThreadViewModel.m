//
//  ATThreadViewModel.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/5/11.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATThreadViewModel.h"
#import "ATCommonTableModel.h"

@implementation ATThreadViewModel

- (NSArray *)getDataSource {
    
    NSArray *dataArr = @[@{
                             kCmn_title : kThreadText_saleTicket,
                             kCmn_detail : @"",
                             },
                         @{
                             kCmn_title : kThreadText_memory,
                             kCmn_detail : @"",
                             },
                         @{
                             kCmn_title : kThreadText_threadRunLoop,
                             kCmn_detail : @"",
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
