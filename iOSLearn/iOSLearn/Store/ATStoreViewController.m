//
//  ATStoreViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/2/26.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATStoreViewController.h"

static NSString *const kTextStore_archiver = @"归档";

@interface ATStoreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation ATStoreViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"数据持久化";
    [self.view addSubview:self.tableView];
    
    [self loadDataSource];
    [self createWeakPointer];
}

#pragma mark - public methods


#pragma mark - private methods

- (void)loadDataSource {
    self.dataSource = @[kTextStore_archiver];
    [self.tableView reloadData];
}

- (void)createWeakPointer {
    //初始化一个弱引用数组对象
    NSPointerArray *pointerArray = [NSPointerArray weakObjectsPointerArray];
    for (NSInteger i = 0; i < 10; i ++) {
        NSObject *obj = [NSObject new];
        [pointerArray addPointer:(__bridge void * _Nullable)(obj)];
    }
    ///输出数组中的所有对象,如果没有对象会输出一个空数组
    NSArray *array = pointerArray.allObjects;
    NSLog(@"array:%@", array);
    //输出数组中的元素个数,包括NULL
    NSLog(@"%lu", (unsigned long)pointerArray.count);//此时输出:10,因为NSObject在for循环之后就被释放了
    //先数组中添加一个NULL
    [pointerArray addPointer:NULL];
    NSLog(@"%lu", (unsigned long)pointerArray.count);
    //清空数组中的所有NULL,注意:经过测试如果直接compact是无法清空NULL,需要在compact之前,调用一次[_weakPointerArray addPointer:NULL],才可以清空
    [pointerArray compact];
    NSLog(@"%lu", (unsigned long)pointerArray.count);//输出:0
    
    //注意:如果直接往_weakPointerArray中添加对象,那么addPointer方法执行完毕之后,NSObject会直接被释放掉
    [pointerArray addPointer:(__bridge void * _Nullable)([NSObject new])];
    NSLog(@"%@",[pointerArray allObjects]);//输出:空数组 NSPointArray[2401:115640] ()
    
    //应该这样添加对象
    NSObject *obj = [NSObject new];
    [pointerArray addPointer:(__bridge void * _Nullable)obj];
    NSLog(@"%@",[pointerArray allObjects]);////输出:NSPointArray[2401:115640] ("<NSObject: 0x600000b61fd0>")
    /**
     NSMapTable 对应 NSDictionary ； NSHashTable 对应 NSSet ； NSPointerArray 对应 NSArray 
     */
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDataDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.dataSource[indexPath.row];
    NSString *viewCtrName;
    if ([text isEqualToString:kTextStore_archiver]) {
        viewCtrName = @"ATStoreArchiverViewController";
    }
    else {
        NSLog(@"未找到对应的控制器");
    }
    
    UIViewController *viewController;
    if (viewCtrName.length > 0) {
        viewController = [[NSClassFromString(viewCtrName) alloc] init];
        viewController.title = text;
    }
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
#pragma mark - getter && setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

@end
