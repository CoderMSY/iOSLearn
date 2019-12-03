//
//  UILabel+ATChangeLineSpaceAndWordSpace.h
//  CPPCC_iOS
//
//  Created by SimonMiao on 2017/8/8.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ATChangeLineSpaceAndWordSpace)

/**
 *  获取行间距label的高度
 */
+ (CGSize)at_getLineSpaceForLabelText:(NSString *)text labelFont:(UIFont *)font lineSpacing:(float)lineSpacing boundSize:(CGSize)boundSize;

/**
 *  改变行间距
 */
+ (void)at_changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)at_changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)at_changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
