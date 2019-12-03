//
//  ATInterviewPresenter.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATInterviewPresenter.h"
#import "ATCommonTableData.h"
#import "ATQuestionModel.h"

@implementation ATInterviewPresenter

#pragma mark - ATInterviewPresenterInput

- (void)fetchDataSource {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"ATInterviewQuestions.json" ofType:@""];
    NSData *JSONData=[NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    ATQuestionModel *uiInfoQModel = (ATQuestionModel *)[ATQuestionModel decodeFromDic:dataDic[@"uiInfo"]];
    ATQuestionModel *ocCharacterQModel = (ATQuestionModel *)[ATQuestionModel decodeFromDic:dataDic[@"ocCharacter"]];
    
    NSArray *rowArrs = @[
        @{
            kRow_title : uiInfoQModel.title ? : @"",
            kRow_detailTitle : uiInfoQModel.detail ? : @"",
            kRow_extraInfo : uiInfoQModel
        },
        @{
            kRow_title : ocCharacterQModel.title ? : @"",
            kRow_detailTitle : ocCharacterQModel.detail ? : @"",
            kRow_extraInfo : ocCharacterQModel
        }
    ];
    NSDictionary *sectionDic = @{
        kSec_rowContent : rowArrs,
        kSec_headerHeight : @(15.0),
        kSec_footerHeight : @(15.0),
    };
    NSArray *sectionArr = [ATCommonTableSection sectionsWithData:@[sectionDic]];
    
    [self.output renderDataSource:sectionArr];
}

@end
