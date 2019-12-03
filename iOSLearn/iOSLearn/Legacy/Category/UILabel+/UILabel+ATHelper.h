//
//  UILabel+ATHelper.h
//  CPPCC_iOS
//
//  Created by SimonMiao on 2017/5/23.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ATHelper)

+ (UILabel *)at_labelWithTextColor:(UIColor *)color font:(UIFont *)font;
+ (UILabel *)at_labelWithTextColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text;

@end
