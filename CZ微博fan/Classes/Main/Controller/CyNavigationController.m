
//
//  CyNavigationController.m
//  CZ微博fan
//
//  Created by fan on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyNavigationController.h"
#import "UIBarButtonItem+CyItem.h"
#import "cytabbar.h"
@interface CyNavigationController ()<UINavigationControllerDelegate>
@property(nonatomic,strong) id popDelegate;
@end

@implementation CyNavigationController

+(void)initialize{
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    //设置导航栏文本字体
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName]= [UIColor orangeColor];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    //返回的手势代理
    self.popDelegate = self.interactivePopGestureRecognizer.delegate ;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
#warning  self.viewControllers.count 与  self.childViewControllers.count的区别
    if ( self.childViewControllers.count ) {//不是根试图控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        //左边
        
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
        
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = right;

    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)popToPre{
    [self popViewControllerAnimated:YES];
}

-(void)popToRoot{
    [self popToRootViewControllerAnimated:YES];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    for (UIView *tabBtn in tabBar.tabBar.subviews) {
        
        if (![tabBtn isKindOfClass:[CyTabBar class]]){
            [tabBtn removeFromSuperview];
        }
        
    }
    
    
}


-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.viewControllers[0]) {//根视图控制器
        //返回手势的代理设为空
        self.interactivePopGestureRecognizer.delegate = nil;
    }else{
        //该代理执行了一些方法使之能够返回
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
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
