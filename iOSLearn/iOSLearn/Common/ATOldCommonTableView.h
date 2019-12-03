//
//  ATOldCommonTableView.h
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/7.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ATOldCommonTableView;
@class ATOldCommonTableModel;
@protocol ATOldCommonTableViewDelegate <NSObject>

- (void)commonTableView:(ATOldCommonTableView *)commonView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ATOldCommonTableView : UIView

@property (nonatomic, weak) id <ATOldCommonTableViewDelegate>delegate;
@property (nonatomic, strong) NSArray <ATOldCommonTableModel *>*dataSource;

@end
