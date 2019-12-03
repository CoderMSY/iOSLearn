//
//  ATViewRelatedPresenter.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATViewRelatedPresenter.h"
#import "ATCommonTableData.h"
#import "ATQuestionModel.h"

@implementation ATViewRelatedPresenter

#pragma mark - ATViewRelatedPresenterInput

- (void)fetchDataSourceWithInfoArr:(NSArray *)infoArr {
    NSMutableArray *rowArrs = [NSMutableArray arrayWithCapacity:0];
    for (ATQuestionModel *qModel in infoArr) {
        NSMutableDictionary *rowDic = [NSMutableDictionary dictionary];
        rowDic[kRow_title] = qModel.title;
        rowDic[kRow_extraInfo] = qModel;
        
        [rowArrs addObject:rowDic];
    }
    
    NSDictionary *sectionDic = @{
        kSec_rowContent : rowArrs,
        kSec_headerHeight : @(15.0),
        kSec_footerHeight : @(15.0),
    };
    NSArray *sectionArr = [ATCommonTableSection sectionsWithData:@[sectionDic]];
    
    [self.output renderDataSource:sectionArr];
}

@end
