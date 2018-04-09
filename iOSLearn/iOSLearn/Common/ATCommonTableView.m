//
//  ATCommonTableView.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/7.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATCommonTableView.h"
#import <Masonry/Masonry.h>

#import "ATCommonTableModel.h"

@interface ATCommonTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ATCommonTableView

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.tableView];
        
        [self initConstaints];
    }
    return self;
}


#pragma mark - public methods

- (void)setDataSource:(NSArray<ATCommonTableModel *> *)dataSource {
    _dataSource = dataSource;
    
    [self.tableView reloadData];
}

#pragma mark - private methods

- (void)initConstaints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ATCommonTableModel *model = self.dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = model.title;
    if (model.detail) {
        cell.detailTextLabel.text = model.detail;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(commonTableView:didSelectRowAtIndexPath:)]) {
        [_delegate commonTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - getter && setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

@end
