//
//  UIButton+ATHelper.h
//  CPPCC_iOS
//
//  Created by SimonMiao on 2017/5/24.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ATHelper)

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title;
/**
 初始化按钮

 @param target 点击事件的响应者
 @param action 按钮点击方法
 @param font 按钮标题字号
 @param color 按钮标题颜色
 @param title 按钮标题大小
 @param isAcceptEventInterval 是否接受事件点击间隔
 @return 按钮对象
 */
+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title
            isAcceptEventInterval:(BOOL)isAcceptEventInterval;

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName;
+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
            isAcceptEventInterval:(BOOL)isAcceptEventInterval;

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                      borderColor:(UIColor *)bordercolor;
+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                      borderColor:(UIColor *)bordercolor
            isAcceptEventInterval:(BOOL)isAcceptEventInterval;

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                      borderColor:(UIColor *)bordercolor
                      borderWidth:(CGFloat)borderWidth
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title;
+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                      borderColor:(UIColor *)bordercolor
                      borderWidth:(CGFloat)borderWidth
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title
            isAcceptEventInterval:(BOOL)isAcceptEventInterval;

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title;
+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title
            isAcceptEventInterval:(BOOL)isAcceptEventInterval;

@end
