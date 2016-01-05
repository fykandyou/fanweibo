//
//  CyComposeToolBar.h
//  CZ微博fan
//
//  Created by qingyun on 16/1/4.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CyComposeToolBarProtocol <NSObject>

@optional
-(void)composeToolBar:(UIToolbar *)toolBar didClickedBtnIndex:(NSInteger)index;

@end


@interface CyComposeToolBar : UIView
@property(nonatomic,strong) id<CyComposeToolBarProtocol> delegate;
@end
