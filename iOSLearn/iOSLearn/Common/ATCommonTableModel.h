//
//  ATCommonTableModel.h
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/8.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kCmn_title = @"commonTitle";
static NSString *const kCmn_detail = @"commonDetail";
static NSString *const kCmn_action = @"commonAction";

@interface ATCommonTableModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *actionName;

@end
