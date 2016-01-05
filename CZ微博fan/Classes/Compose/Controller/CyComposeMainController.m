//
//  CyComposeMainController.m
//  CZ微博fan
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import "CyComposeMainController.h"
#import "CyComposeCover.h"
#import "CyCompoeController.h"
#define kYOffset    [UIScreen mainScreen].bounds.size.height

@interface CyComposeMainController ()<CyComposeCoverProtocol>
@property(nonatomic,strong) NSMutableArray *menuBtns;
@property(nonatomic,strong) CyComposeCover *Cover;
@end

@implementation CyComposeMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加蒙版
    [self addCover];
    
    
    
  //  [self showMenuBtnsWithAnimation:YES];
    
    
}
-(void)addCover{
    CyComposeCover *cover = [CyComposeCover show];
    cover.frame = self.view.bounds;
    
    cover.delegate = self;
    
    [self.view addSubview:cover];
    _Cover = cover;
    
    
    [self createMenuBtns];
   
}

- (void)createMenuBtns {
    // 1. 确定btn的宽和高，水平间距和垂直间距
    CGFloat btnWidth = 71.f;
    CGFloat btnHeight = 71.f;
    
    CGFloat marginX = (CGRectGetWidth(self.view.bounds) - 3*btnWidth) / 4.f;
    CGFloat marginY = 32;
    
    NSArray *btnImgNames = @[@"tabbar_compose_camera", @"tabbar_compose_idea", @"tabbar_compose_lbs", @"tabbar_compose_more", @"tabbar_compose_photo", @"tabbar_compose_review"];
    _menuBtns = [NSMutableArray array];
    for (int i = 0; i < btnImgNames.count; i++) {
        int row = i / 3;
        int column = i % 3;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(marginX+(marginX+btnWidth)*column, kYOffset+marginY+(marginY+btnHeight)*row, btnWidth, btnHeight);
        [btn setBackgroundImage:[UIImage imageNamed:btnImgNames[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = self.Cover.subviews.count;
        [self.Cover addSubview:btn];
        [_menuBtns addObject:btn];
    }
}

- (void)showMenuBtnsWithAnimation:(BOOL)animation {
    if (animation) {
        for (int i = 0; i < _menuBtns.count; i++) {
            UIButton *btn = _menuBtns[i];
            
            /**
             duration: 动画时长
             delay: 延迟开始动画时间
             damping: 弹簧阻尼系数(0-1) 1:阻尼最大，没有弹跳效果
             velocity: 初始动力大小 0 自动根据duration和damping来计算
             */
            [UIView animateWithDuration:0.8 delay:i*0.03 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGPoint center = btn.center;
                center.y -= 500;
                btn.center = center;
            } completion:nil];
        }
    } else {
        for (int i = 0; i < _menuBtns.count; i++) {
            UIButton *btn = _menuBtns[i];
            CGPoint center = btn.center;
            center.y -= 500;
            btn.center = center;
        }
    }
}

-(void)clicked:(UIButton *)btn{
    
    [UIView animateWithDuration:0.2 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.6, 1.6);
        btn.alpha = 0.38;
    } completion:^(BOOL finished) {
        btn.transform = CGAffineTransformIdentity;
        btn.alpha = 1.0;
        [self hideMenuBtnsWithAnimation:NO];
    }];
    
    
    //如果是发消息，则转化到另一视图
    if (btn.tag == 1) {
        CyCompoeController *composeVC = [[CyCompoeController alloc] init];
        
      //  [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:composeVC] animated:YES completion:nil];
        [self.navigationController pushViewController:composeVC animated:YES];
    }
}

- (void)hideMenuBtnsWithAnimation:(BOOL)animation {
    if (animation) {
        int totalNum = (int)_menuBtns.count;
        for (int i = 0; i < totalNum; i++) {
            UIButton *btn = _menuBtns[totalNum-1-i];
            
            /**
             duration: 动画时长
             delay: 延迟开始动画时间
             damping: 弹簧阻尼系数(0-1) 1:阻尼最大，没有弹跳效果
             velocity: 初始动力大小 0 自动根据duration和damping来计算
             */
            [UIView animateWithDuration:0.8 delay:i*0.03 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGPoint center = btn.center;
                center.y += 500;
                btn.center = center;
            } completion:nil];
        }
    } else {
        int totalNum = (int)_menuBtns.count;
        for (int i = 0; i < totalNum; i++) {
            UIButton *btn = _menuBtns[totalNum-1-i];
            CGPoint center = btn.center;
            center.y += 500;
            btn.center = center;
        }
    }
    
    //_isShow = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [self showMenuBtnsWithAnimation:YES];
}

#pragma mark - CyComposeCoverProtocol  移除btn
-(void)didClickCoverOfCompose:(CyComposeCover *)cover{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}


@end
