//
//  CyTabBar.h
//  CZ微博fan
//
//  Created by fan on 15/12/23.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CyTabBar;

@protocol CyTabBarPro <NSObject>

@optional
-(void)TabBar:(CyTabBar *)tabBar indexOfClickedButton:(NSInteger)index;


/*
 *点击加号的时候调用
 */
-(void)tabBarDidClickedComposeButton:(UITabBar *)tabBar;
@end



@interface CyTabBar : UIView
@property(nonatomic,strong) NSArray *items;
@property(nonatomic,strong) id<CyTabBarPro>delegate;
@end
