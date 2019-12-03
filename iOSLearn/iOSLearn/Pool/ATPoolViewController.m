//
//  ATPoolViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/12.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "ATPoolViewController.h"
#import <Masonry/Masonry.h>
#import <YYKit/UIImage+YYAdd.h>
#import "UILabel+ATHelper.h"
#import "UIButton+ATHelper.h"

static NSString *const kPoolKey_urlCount = @"poolKey_urlCount";

@interface ATPoolViewController ()
{
    NSInteger _urlCount;
    BOOL _isNeedPool;
}
@property (nonatomic, strong) UILabel *showLab;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ATPoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNumber *countNum = [[NSUserDefaults standardUserDefaults] objectForKey:kPoolKey_urlCount];
    _urlCount = countNum.integerValue;
    self.showLab.text = [NSString stringWithFormat:@"循环次数：%@",countNum.stringValue];
    
    _isNeedPool = YES;
    [self createSubView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createSubView {
    [self.view addSubview:self.showLab];
    [self.view addSubview:self.textView];
    
    UIButton *addBtn = [UIButton at_buttonWithTarget:self action:@selector(addCount:) titleFont:[UIFont systemFontOfSize:17] titleColor:[UIColor whiteColor] title:@"添加"];
    UIImage *redImg = [UIImage imageWithColor:[UIColor redColor]];
    [addBtn setBackgroundImage:redImg forState:UIControlStateNormal];
    addBtn.layer.cornerRadius = 5;
    addBtn.layer.masksToBounds = YES;
    
    [self.view addSubview:addBtn];
    UIButton *deleteBtn = [UIButton at_buttonWithTarget:self action:@selector(deleteCount:) titleFont:[UIFont systemFontOfSize:17] titleColor:[UIColor whiteColor] title:@"减少"];
    UIImage *brownImg = [UIImage imageWithColor:[UIColor brownColor]];
    [deleteBtn setBackgroundImage:brownImg forState:UIControlStateNormal];
    deleteBtn.layer.cornerRadius = 5;
    deleteBtn.layer.masksToBounds = YES;
    [self.view addSubview:deleteBtn];
    
    UIButton *needPoolBtn = [UIButton at_buttonWithTarget:self action:@selector(needPoolBtnClicked:) titleFont:[UIFont systemFontOfSize:17] titleColor:[UIColor whiteColor] title:@"需要autoreleasePool"];
    [needPoolBtn setTitle:@"不需要autoreleasePool" forState:UIControlStateSelected];
    UIImage *blueImg = [UIImage imageWithColor:[UIColor blueColor]];
    [needPoolBtn setBackgroundImage:blueImg forState:UIControlStateNormal];
    needPoolBtn.layer.cornerRadius = 5;
    needPoolBtn.layer.masksToBounds = YES;
    [self.view addSubview:needPoolBtn];
    
    [self.showLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(50);
        make.right.mas_equalTo(self.view).offset(-50);
        make.height.mas_equalTo(40);
    }];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showLab.mas_bottom).offset(30);
        make.left.mas_equalTo(self.showLab);
        make.size.mas_equalTo(self.showLab);
    }];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addBtn.mas_bottom).offset(30);
        make.left.mas_equalTo(self.showLab);
        make.size.mas_equalTo(self.showLab);
    }];
    [needPoolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(deleteBtn.mas_bottom).offset(30);
        make.left.mas_equalTo(self.showLab);
        make.size.mas_equalTo(self.showLab);
        make.bottom.mas_lessThanOrEqualTo(self.view);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(needPoolBtn.mas_bottom).offset(30);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.bottom.mas_equalTo(self.view).offset(-15);
    }];
}

- (void)addCount:(UIButton *)btn {
    _urlCount = _urlCount + 10;
    [self dealWithData];
}

- (void)deleteCount:(UIButton *)btn {
    if (_urlCount < 0) {
        _urlCount = 0;
    }
    else {
        _urlCount = _urlCount - 10;
        if (_urlCount < 0) {
            _urlCount = 0;
        }
    }
    
    [self dealWithData];
}

- (void)needPoolBtnClicked:(UIButton *)btn {
    btn.selected = !btn.isSelected;
    
    _isNeedPool = !btn.isSelected;
}

- (void)dealWithData {
    NSNumber *countNum = [NSNumber numberWithInteger:_urlCount];
    [[NSUserDefaults standardUserDefaults] setObject:countNum forKey:kPoolKey_urlCount];
    self.showLab.text = [NSString stringWithFormat:@"循环次数：%@",countNum.stringValue];
    
    [self loadDataSource];
}

- (void)loadDataSource {
    NSURL *tempUrl = [NSURL URLWithString:@"https://www.baidu.com/"];
    NSMutableArray *urlArrs = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < _urlCount; i ++) {
        [urlArrs addObject:tempUrl.copy];
    }
    for (NSURL *url in urlArrs) {
        if (_isNeedPool) {
            @autoreleasepool {
                NSString *urlStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
                NSInteger index = [urlArrs indexOfObject:url];
                NSLog(@"index%ld:%@",(long)index, urlStr);
            }
        }
        else {
            NSString *urlStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            NSInteger index = [urlArrs indexOfObject:url];
            NSLog(@"index%ld:%@",(long)index, urlStr);
        }
    }
}

#pragma mark - lifecycle methods


#pragma mark - public methods


#pragma mark - private methods


#pragma mark - getter && setter

- (UILabel *)showLab {
    if (!_showLab) {
        _showLab = [UILabel at_labelWithTextColor:[UIColor blueColor] font:[UIFont systemFontOfSize:17]];
        _showLab.textAlignment = NSTextAlignmentCenter;
        _showLab.layer.cornerRadius = 5;
        _showLab.layer.borderWidth = 1.0;
        _showLab.layer.borderColor = [UIColor blueColor].CGColor;
    }
    return _showLab;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor blackColor];
        _textView.textColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.text = @"1.NSAutoreleasePool是什么？\n实际上是个对象引用计数自动处理器，在官方文档中被称为是一个类。它的组织是个栈，总是存在一个栈顶pool，每创建一个pool，就往栈里压，并替换栈顶；drain 消息，则就弹出栈顶的 pool。\n解析：\n1.如果 for 中没有自动释放池的参与，那么每次创建的临时对fileContents，一直在其中处于存活状态，(系统的)自动释放池需等线程执行下一次事件循环时才会清空释放，也就意味着会有新的(临时)对象不断产生；\n结果：\n所占内存持续上涨，所有对象都要等 for 循环结束才会释放。\n所有临时对象释放后，内存用量又会突然下降。\n2.如例中所示，把 for 循环创建对象的操作放在“@autoreleasepool { }”括号里，那么，创建的新对象就放在我们新建的自动释放池里，而不是系统的主池里。这样做的好处是：减少这个峰值，因为系统会在块的末尾把某些对象(例如这些临时对象)回收掉。\n3.可以看到，自动释放池机制就像“栈”一样，创建好自动释放池后，就将其推入栈中，从栈中弹出，也就相当与清空释放池；向对象执行 autoreleasepool，相当于将其放入栈顶的池里。\n 注意：与NSAutoreleasepool对比\n 1.NSAutoreleasepool 对象 为 MRC 的写法，这种写法不会在每次执行完 for 循环时清空释放，而是可能会执行 n 次循环才清空一次自动释放池，因此通常偶尔需要清空池的情况才创建。\n 2.而@autoreleasepool 是每次循环时都会建立并清空自动释放池，所以@autoreleasepool 会比 NSAutoreleasepool 对象更加轻量级。使用范围更广。\n 3.总结：ARC 下新语法 @autoreleasepool 的好处：括号即是作用范围。";
    }
    return _textView;
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
