//
//  ATCommonTableView.h
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/7.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ATCommonTableView;
@class ATCommonTableModel;
@protocol ATCommonTableViewDelegate <NSObject>

- (void)commonTableView:(ATCommonTableView *)commonView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ATCommonTableView : UIView

@property (nonatomic, weak) id <ATCommonTableViewDelegate>delegate;
@property (nonatomic, strong) NSArray <ATCommonTableModel *>*dataSource;

@end
