//
//  CyTabBarController.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/23.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyTabBarController.h"

#import "CyHomeTableViewController.h"
#import "CyDiscoverViewController.h"
#import "CyMessageTableViewController.h"
#import "CyProfileTableViewController.h"

#import "CyTabBar.h"
#import "CyUserResult.h"
#import "CyUserTool.h"

#import "CyNavigationController.h"

#import "CyComposeMainController.h"
@interface CyTabBarController ()<CyTabBarPro>
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,weak) CyHomeTableViewController *home;
@property(nonatomic,weak) CyMessageTableViewController *message;
@property(nonatomic,weak) CyDiscoverViewController *discover;
@property(nonatomic,weak) CyProfileTableViewController *profile;
@end

@implementation CyTabBarController

-(NSMutableArray *)items{
    if (_items == nil) {
        _items = [NSMutableArray array];
        
    }
    return _items;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupAllSubController];
    
    [self setupTabBar];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES ];
}

-(void)requestUnread{
    
    [CyUserTool unreadWithSuccess:^(CyUserResult *result) {
       
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        //设置系统的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}

-(void)setupTabBar{
    
    CyTabBar *tabBar = [[CyTabBar alloc] initWithFrame:self.tabBar.frame];
    tabBar.items = self.items;
    
    [tabBar setBackgroundColor:[UIColor whiteColor]];
    
    //设置代理才能调用协议的方法
    tabBar.delegate = self;
    
    //自定义的tabBar添加在系统的tabBar上，因为 压栈viewController时需要隐藏下方的tabBar，而hidesBottomBarWhenPush属性只能显示或者隐藏系统的tabBar
    //系统的tabBar上面的按钮还在，需要删除
    [self.view addSubview:tabBar];
#warning 这里到底怎么做，这时候就不应该移除了吧？删除系统的子控件还没有做
   [self.tabBar removeFromSuperview];
    
}
////系统的tabBar上面的按钮还在，需要删除
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    for (UIView *tabBarButton in self.tabBar.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabBarButton  removeFromSuperview];
//        }
//        
//    }
//}

-(void)TabBar:(CyTabBar *)tabBar indexOfClickedButton:(NSInteger)index{
    
    if (index == 0 && self.selectedIndex == index) {
        [_home refresh];
    }
    
    
    self.selectedIndex = index;
}

-(void)setupAllSubController{
    CyHomeTableViewController *home = [[CyHomeTableViewController alloc] init];
    [self setupOneSubControllerForController:home WithNormalImage:[UIImage imageNamed:@"tabbar_home"] SelectedImage:[UIImage imageNamed:@"tabbar_home_selected"] Title:@"首页"];
    _home = home;
    
    CyMessageTableViewController *message = [[CyMessageTableViewController alloc] init];
    [self setupOneSubControllerForController:message WithNormalImage:[UIImage imageNamed:@"tabbar_message_center"] SelectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"] Title:@"消息"];
    _message = message;
    
    CyDiscoverViewController *discover = [[CyDiscoverViewController alloc] init];
    [self setupOneSubControllerForController:discover WithNormalImage:[UIImage imageNamed:@"tabbar_discover"] SelectedImage:[UIImage imageNamed:@"tabbar_discover_selected"] Title:@"发现"];
    _discover = discover;
    
    
    CyProfileTableViewController *profile = [[CyProfileTableViewController alloc] init];
    [self setupOneSubControllerForController:profile WithNormalImage:[UIImage imageNamed:@"tabbar_profile"] SelectedImage:[UIImage imageNamed:@"tabbar_profile_selected"] Title:@"我"];
    _profile = profile;
}

-(void)tabBarDidClickedComposeButton:(UITabBar *)tabBar{
    CyComposeMainController *composeVC = [[CyComposeMainController alloc] init];
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:composeVC];
    
    [self presentViewController:navVc animated:YES completion:nil];

    
}



-(void)setupOneSubControllerForController:(UIViewController *)vc WithNormalImage:(UIImage *)image SelectedImage:(UIImage *)selectedImage Title:(NSString *)title{

    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = image;
    
    //self.items装的是vc的tabBarItem;
    [self.items addObject:vc.tabBarItem];
    
  CyNavigationController *navigation = [[CyNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navigation];
    
}

@end
