//
//  ATTabBarControllerConfig.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/11/28.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATTabBarControllerConfig.h"
#import "ATBaseNavigationController.h"

typedef NS_ENUM(NSInteger, ATTabBabConfigType) {
    ATTabBabConfigType_application,
    ATTabBabConfigType_contacts,
    ATTabBabConfigType_message,
    ATTabBabConfigType_my
};

//static NSInteger const kTabBarCount = 5;

/// 保存当前选中的底部navCtr
static NSString *const kTabBarUDKey_selectedIndex = @"TabBarUDKey_selectedIndex";

static NSString *const kTabBarVCTitle_application = @"应用";
static NSString *const kTabBarVCTitle_message = @"消息";
static NSString *const kTabBarVCTitle_apply = @"申请";
static NSString *const kTabBarVCTitle_contacts = @"通讯录";
static NSString *const kTabBarVCTitle_my = @"我的";

static NSString *const key_TabBarVC = @"tabBarVC";
static NSString *const key_TabBarVCTitle = @"tabBarVCTitle";
static NSString *const key_TabBarItemBadgeValue = @"tabBarItemBadgeValue";

@interface ATTabBarControllerConfig () <UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@property (nonatomic, strong) NSDictionary *vcInfoDic;

@end

@implementation ATTabBarControllerConfig

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    ATLog(@"%lu", tabBarController.selectedIndex);
    NSNumber *selectedIndex = @(tabBarController.selectedIndex);
    [[NSUserDefaults standardUserDefaults] setObject:selectedIndex forKey:kTabBarUDKey_selectedIndex];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - getter && setter

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        //        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
        //                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero;//UIOffsetMake(0, MAXFLOAT);
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];
        [self customizeTabBarAppearance:tabBarController];
        tabBarController.delegate = self;
        _tabBarController = tabBarController;
        
        NSNumber *selectedIndex = [[NSUserDefaults standardUserDefaults] objectForKey:kTabBarUDKey_selectedIndex];
        tabBarController.selectedIndex = selectedIndex.unsignedIntegerValue;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    NSArray <NSNumber *>*typeArr = @[
                                     @(ATTabBabConfigType_application),
                                     @(ATTabBabConfigType_contacts),
                                     @(ATTabBabConfigType_message),
                                     @(ATTabBabConfigType_my)];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:typeArr.count];
    for (NSInteger i = 0; i < typeArr.count; i ++) {
        NSDictionary *vcInfoDic = [self vcInfoForTabBarType:typeArr[i].integerValue];
        
        UIViewController *ctr = [(UIViewController *)[NSClassFromString(vcInfoDic[key_TabBarVC]) alloc] init];
        ctr.title = vcInfoDic[key_TabBarVCTitle];
        ATBaseNavigationController *navController = [[ATBaseNavigationController alloc] initWithRootViewController:ctr];
        [viewControllers addObject:navController];
    }
    
    return viewControllers;
}

#pragma mark - VC

- (NSDictionary *)vcInfoForTabBarType:(ATTabBabConfigType)type {
    if (!_vcInfoDic) {
        _vcInfoDic = @{
            @(ATTabBabConfigType_application) : @{
                    key_TabBarVC : @"HomeViewController",
                    key_TabBarVCTitle : kTabBarVCTitle_application,
                    key_TabBarItemBadgeValue : @(0)
            },
            @(ATTabBabConfigType_contacts) : @{
                    key_TabBarVC : @"ATInterviewViewController",
                    key_TabBarVCTitle : kTabBarVCTitle_contacts,
                    key_TabBarItemBadgeValue : @(0)
            },
            @(ATTabBabConfigType_message) : @{
                    key_TabBarVC : @"ATSessionListViewController",
                    key_TabBarVCTitle : kTabBarVCTitle_message,
                    key_TabBarItemBadgeValue : @(0)
            },
            @(ATTabBabConfigType_my) : @{
                    key_TabBarVC : @"ATMyViewController",
                    key_TabBarVCTitle : kTabBarVCTitle_my,
                    key_TabBarItemBadgeValue : @(0)
            }
        };
    }
    return _vcInfoDic[@(type)];
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : kTabBarVCTitle_application,
                                                 CYLTabBarItemImage : @"tabBar_application_normal",
                                                 CYLTabBarItemSelectedImage : @"tabBar_application_highlight",
                                                 };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : kTabBarVCTitle_contacts,
                                                 CYLTabBarItemImage : @"tabBar_contacts_normal",
                                                 CYLTabBarItemSelectedImage : @"tabBar_contacts_highlight"
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : kTabBarVCTitle_message,
                                                  CYLTabBarItemImage : @"tabBar_home_normal",
                                                  CYLTabBarItemSelectedImage : @"tabBar_home_highlight",
                                                  };
    NSDictionary *fiveTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : kTabBarVCTitle_my,
                                                CYLTabBarItemImage : @"tabBar_my_normal",
                                                CYLTabBarItemSelectedImage : @"tabBar_my_highlight"
                                                };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes,
                                       fiveTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}


/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
//#warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //    tabBarController.tabBarHeight = 44.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blueColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tabBar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabBar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

@end
