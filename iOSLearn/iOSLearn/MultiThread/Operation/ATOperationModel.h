//
//  ATOperationModel.h
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/30.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATOperationModel : NSObject

- (void)modifyWithName:(NSString *)name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *birthday;

@end
