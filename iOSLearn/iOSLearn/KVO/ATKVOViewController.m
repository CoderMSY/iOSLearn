//
//  ATKVOViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/9.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATKVOViewController.h"
#import "ATKVOModel.h"

@interface ATKVOViewController ()

@property (weak, nonatomic) IBOutlet UILabel *oldLab;
@property (weak, nonatomic) IBOutlet UILabel *freshLab;

@property (nonatomic, strong) ATKVOModel *kvoModel;

@end

@implementation ATKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.kvoModel = [[ATKVOModel alloc] init];
    
    NSLog(@"%@",NSStringFromSelector(@selector(kvoNum)));
    
    /*1.注册对象myKVO为被观察者:
     option中，
     NSKeyValueObservingOptionOld 以字典的形式提供 “初始对象数据”;
     NSKeyValueObservingOptionNew 以字典的形式提供 “更新后新的数据”;
     */
    [self.kvoModel addObserver:self forKeyPath:NSStringFromSelector(@selector(kvoNum)) options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    /* 3.移除KVO */
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(kvoNum)) context:nil];
}

- (IBAction)addBtnClicked:(UIButton *)sender {
    
    self.kvoModel.kvoNum = self.kvoModel.kvoNum + 1;
}

/* 2.只要object的keyPath属性发生变化，就会调用此回调方法，进行相应的处理：UI更新：*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.kvoModel) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(kvoNum))]) {
            self.oldLab.text = [NSString stringWithFormat:@"旧值为:%@",[change valueForKey:@"old"]];
            self.freshLab.text = [NSString stringWithFormat:@"新值为:%@",[change valueForKey:@"new"]];
            
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
