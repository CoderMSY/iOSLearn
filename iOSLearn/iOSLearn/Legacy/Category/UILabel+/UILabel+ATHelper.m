//
//  UILabel+ATHelper.m
//  CPPCC_iOS
//
//  Created by SimonMiao on 2017/5/23.
//  Copyright © 2017年 avatar. All rights reserved.
//

#import "UILabel+ATHelper.h"

@implementation UILabel (ATHelper)

+ (UILabel *)at_labelWithTextColor:(UIColor *)color font:(UIFont *)font
{
    UILabel *label = [self at_labelWithTextColor:color font:font text:nil];
    return label;
}

+ (UILabel *)at_labelWithTextColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    if (text) {
        label.text = text;
    }
    
    return label;
}

@end
