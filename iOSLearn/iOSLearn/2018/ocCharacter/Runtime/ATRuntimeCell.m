//
//  ATRuntimeCell.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/3.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATRuntimeCell.h"
#import "ATCommonTableData.h"

@implementation ATRuntimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    style = UITableViewCellStyleSubtitle;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView addSubview:self.];
//        [self.contentView addSubview:self.];
//
//        [self initConstraints];
    }
    
    return self;
}

#pragma mark - ATTableViewCellProtocol

- (void)refreshData:(ATCommonTableRow *)rowData tableView:(UITableView *)tableView {
    self.textLabel.text = rowData.title;
    if (rowData.detailTitle) {
        self.detailTextLabel.text = rowData.detailTitle;
    }
}

@end
