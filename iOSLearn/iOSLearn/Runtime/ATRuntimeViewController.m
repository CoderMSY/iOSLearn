//
//  ATRuntimeViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/4.
//  Copyright © 2018年 Avatar. All rights reserved.
//  参考：https://www.jianshu.com/p/51d33d8f63e9

#import "ATRuntimeViewController.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
#import <UIAlertController+Blocks/UIAlertController+Blocks.h>

#import "ATCommonTableView.h"
#import "ATRuntimeViewModel.h"
#import "ATCommonTableModel.h"

#import "ATPerson.h"
#import "ATPerson+addProperty.h"

@interface ATRuntimeViewController () <ATCommonTableViewDelegate, ATPersonDelegate>

@property (nonatomic, strong) ATCommonTableView *commonTableView;
@property (nonatomic, strong) ATRuntimeViewModel *viewModel;

@property (nonatomic, strong) ATPerson *student;

@end

@implementation ATRuntimeViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.commonTableView];
    [self initConstraints];
    
    [self loadDataSource];
    
    self.student.englishName = @"Simon Miao";
    NSLog(@"Student English name is %@",self.student.englishName);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public methods


#pragma mark - private methods

- (void)initConstraints {
    [self.commonTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)loadDataSource {
    NSArray *dataSource = [self.viewModel getDataSource];
    self.commonTableView.dataSource = dataSource;
}

- (void)function1ItemClicked {
    NSLog(@"=================================================================");
    unsigned int count;

    // 拷贝成员变量列表。返回的一个Ivar列表的指针
    Ivar *ivars = class_copyIvarList([ATPerson class], &count);
    
    for (int i=0 ; i<count; i++) {
        Ivar ivar = ivars[i];
        //根据ivar获得其成员变量的名称
        const char *name = ivar_getName(ivar);
        //C的字符串转OC的字符串
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d == %@",i,key);
    }
    // 释放资源
    free(ivars);
    //如果你的成员私有,也可以获取到 比如_education
}

- (void)function2ItemClicked {
    NSLog(@"=================================================================");
    unsigned int count;
    
    //获得指向该类所有属性的指针
    objc_property_t *properties = class_copyPropertyList([ATPerson class], &count);
    
    for (int i=0 ; i<count; i++) {
        //获得该类的一个属性的指针
        objc_property_t property = properties[i];
        //获取属性的名称
        const char *name = property_getName(property);
        //将C的字符串转为OC字符串
        NSString *key = [NSString stringWithUTF8String:name];
        
        NSLog(@"%d == %@",i,key);
    }
    // 记得释放
    free(properties);
}

- (void)function3ItemClicked {
    NSLog(@"=================================================================");
    unsigned int count;
    //获取指向该类的所有方法的数组指针
    Method *methods = class_copyMethodList([ATPerson class], &count);
    
    for (int i = 0; i < count; i ++) {
        //获取该类的一个方法的指针
        Method method = methods[i];
        //获取方法
        SEL methodSEL = method_getName(method);
        //将方法转换为C字符串
        const char *name = sel_getName(methodSEL);
        //将C字符串转为OC字符串
        NSString *methodName = [NSString stringWithUTF8String:name];
        //获取方法参数个数
        int arguments = method_getNumberOfArguments(method);
        
        NSLog(@"%d == %@ %d",i,methodName,arguments);
    }
    
    free(methods);
    
    //runtime中一个方法最少有两个参数分别是 id self,SEL _cmd。
}

//4. 获取类遵循的全部协议
- (void)function4ItemClicked {
    NSLog(@"=================================================================");
    unsigned int count;
    
    //获取指向该类遵循的所有协议的数组指针
    __unsafe_unretained Protocol **protocols = class_copyProtocolList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        //获取该类遵循的一个协议指针
        Protocol *protocol = protocols[i];
        //获取C字符串协议名
        const char *name = protocol_getName(protocol);
        //C字符串转OC字符串
        NSString *protocolName = [NSString stringWithUTF8String:name];
        NSLog(@"%d == %@",i,protocolName);
    }
    //记得释放
    free(protocols);
}

/** 5. 动态改变成员变量
 * 可以修改成员变量的值，比如讲person的名字从张三 改成李四。
 */
- (void)function5ItemClicked {
    NSLog(@"=================================================================");
    self.student.name = @"张三";
    
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.student class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        
        if ([name isEqualToString:@"_name"]) {
            object_setIvar(self.student, var, @"李四");
//            object_setIvar(<#id  _Nullable obj#>, <#Ivar  _Nonnull ivar#>, <#id  _Nullable value#>)
            break;
        }
    }
    free(ivar);
    
    // 结果变成了 李四
    NSLog(@"student name: %@",self.student.name);
}

//动态交换类两个方法
- (void)function6ItemClicked {
    Method m1 = class_getInstanceMethod([ATPerson class], @selector(doSomeThing));
    Method m2 = class_getInstanceMethod([ATPerson class], @selector(doSomeOtherThing));
    
    method_exchangeImplementations(m1, m2);
    
    // 发现两个方交换了
    NSLog(@"student do something:%@",[self.student doSomeThing]);
    NSLog(@"student do doSomeOtherThing:%@",[self.student doSomeOtherThing]);
    
    // 运行时修改的是类，不是单一对象 一次修改 在下次编译前一直有效。
    ATPerson *student2 = [ATPerson new];
    NSLog(@"student do something:%@",[student2 doSomeThing]);
    NSLog(@"student do doSomeOtherThing:%@",[student2 doSomeOtherThing]);
    
    
    // 也可以在类目中添加自己方法去替换 类 或者系统类的方法
    
    [self.student sleep];
    
    //查看上面的结果发现 doSomeThing和doSomeOtherThing交换了。
}

/** 动态添加新方法
 */
- (void)function7ItemClicked {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    class_addMethod([self.student class], @selector(fromCity:), (IMP)fromCityAnswer, "v@:@");
    if ([self.student respondsToSelector:@selector(fromCity:)]) {
        //Method method = class_getInstanceMethod([self.xiaoMing class], @selector(guess));
        [self.student performSelector:@selector(fromCity:) withObject:@"洛杉矶"];
    #pragma clang diagnostic pop
    } else{
        NSLog(@"无法告诉你我从哪儿来");
    }
    
    
    /**
     (IMP) fromCityAnswer 意思是fromCityAnswer的地址指针;
     "v@:" 意思是，v代表无返回值void，如果是i则代表int；@代表 id sel; : 代表 SEL _cmd;
     “v@:@” 意思是，一个参数的没有返回值。
     */
}

#pragma mark RunTime代码

void fromCityAnswer(id self,SEL _cmd,NSString *str){
    
    NSLog(@"我来自:%@",str);
}

#pragma mark - ATCommonTableViewDelegate

- (void)commonTableView:(ATCommonTableView *)commonView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ATCommonTableModel *cmnModel = self.commonTableView.dataSource[indexPath.row];
    if (cmnModel.actionName.length > 0) {
        SEL sel = NSSelectorFromString(cmnModel.actionName);
        if ([self respondsToSelector:sel]) {
            AT_SuppressPerformSelectorLeakWarning([self performSelector:sel]);
        }
        else {
            NSLog(@"方法未找到，请显示");
        }
    }
    else {
        NSLog(@"请传入方法名");
    }
}

#pragma mark - ATPersonDelegate

- (void)personPayForFun:(NSInteger)money {
    
}

#pragma mark - getter && setter

- (ATCommonTableView *)commonTableView {
    if (!_commonTableView) {
        _commonTableView = [[ATCommonTableView alloc] init];
        _commonTableView.delegate = self;
    }
    return _commonTableView;
}

- (ATRuntimeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ATRuntimeViewModel alloc] init];
        _viewModel.viewController = self;
    }
    return _viewModel;
}

- (ATPerson *)student {
    if (!_student) {
        _student = [[ATPerson alloc] init];
        _student.delegate = self;
    }
    return _student;
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
