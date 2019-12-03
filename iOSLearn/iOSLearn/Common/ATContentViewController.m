//
//  ATContentViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATContentViewController.h"
#import <Masonry/Masonry.h>

@interface ATContentViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ATContentViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.textView];
    [self initConstraints];
}

#pragma mark - public methods

- (void)setContent:(NSString *)content {
    _content = content;
    
    self.textView.text = content;
}

#pragma mark - private methods

- (void)initConstraints {
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - getter && setter

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.editable = NO;
        _textView.font = [UIFont systemFontOfSize:22];
    }
    return _textView;
}

@end
