//
//  ATRuntimeViewModel.h
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/8.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATBaseViewModel.h"
#import "ATRuntimeDefine.h"

@interface ATRuntimeViewModel : ATBaseViewModel

- (NSArray *)getDataSource;

- (void)function1ItemClicked;
- (NSString *)getCodeContent;

- (void)presentDetailCodeViewCtrWithCode:(NSString *)codeText;

@end
