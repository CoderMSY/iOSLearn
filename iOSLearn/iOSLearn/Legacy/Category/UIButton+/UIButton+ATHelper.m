//
//  UIButton+ATHelper.m
//  CPPCC_iOS
//
//  Created by SimonMiao on 2017/5/24.
//  Copyright © 2017年 atatar. All rights reserved.
//

#import "UIButton+ATHelper.h"
#import "UIControl+ATFixMultiClick.h"

@implementation UIButton (ATHelper)

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title {
    UIButton *btn = [self at_buttonWithTarget:target action:action titleFont:font titleColor:color title:title isAcceptEventInterval:YES];
    
    return btn;
}

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title
            isAcceptEventInterval:(BOOL)isAcceptEventInterval {
    UIButton *btn = [self at_buttonWithTarget:target action:action imageNamed:nil titleFont:font titleColor:color title:title isAcceptEventInterval:isAcceptEventInterval];
    
    return btn;
}

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName  {
    UIButton *btn = [self at_buttonWithTarget:target action:action imageNamed:imageName isAcceptEventInterval:YES];
    
    return btn;
}

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
            isAcceptEventInterval:(BOOL)isAcceptEventInterval {
    UIButton *btn = [self at_buttonWithTarget:target action:action imageNamed:imageName titleFont:nil titleColor:nil title:nil isAcceptEventInterval:isAcceptEventInterval];
    
    return btn;
}

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                      borderColor:(UIColor *)bordercolor {
    UIButton *btn = [self at_buttonWithTarget:target action:action imageNamed:imageName borderColor:bordercolor isAcceptEventInterval:YES];
    
    return btn;
}

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                      borderColor:(UIColor *)bordercolor
            isAcceptEventInterval:(BOOL)isAcceptEventInterval {
    UIButton *btn = [self at_buttonWithTarget:target action:action imageNamed:imageName borderColor:bordercolor borderWidth:1 titleFont:nil titleColor:nil title:nil isAcceptEventInterval:isAcceptEventInterval];
    
    return btn;
}

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                      borderColor:(UIColor *)bordercolor
                      borderWidth:(CGFloat)borderWidth
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title {
    UIButton *btn = [self at_buttonWithTarget:target action:action imageNamed:imageName borderColor:bordercolor borderWidth:borderWidth titleFont:font titleColor:color title:title isAcceptEventInterval:YES];
    
    return btn;
}

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                      borderColor:(UIColor *)bordercolor
                      borderWidth:(CGFloat)borderWidth
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title
            isAcceptEventInterval:(BOOL)isAcceptEventInterval {
    UIButton *btn= [self at_buttonWithTarget:target action:action imageNamed:imageName titleFont:font titleColor:color title:title isAcceptEventInterval:isAcceptEventInterval];
    btn.layer.borderColor = bordercolor.CGColor;
    btn.layer.borderWidth = borderWidth;
    
    return btn;
}

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title {
    UIButton *btn = [self at_buttonWithTarget:target
                                       action:action
                                   imageNamed:imageName
                                    titleFont:font
                                   titleColor:color
                                        title:title
                        isAcceptEventInterval:YES];
    return btn;
}

+ (UIButton *)at_buttonWithTarget:(id)target
                           action:(SEL)action
                       imageNamed:(NSString *)imageName
                        titleFont:(UIFont *)font
                       titleColor:(UIColor *)color
                            title:(NSString *)title
            isAcceptEventInterval:(BOOL)isAcceptEventInterval {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 设置图片
    if (imageName && imageName.length > 0) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        
    }
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    if (isAcceptEventInterval) {
        btn.at_acceptEventInterval = 1.0;//!<默认防止重复点击时间为1.0秒
    }
    
    return btn;
}

@end
