//
//  CyPopMenu.h
//  CZ微博fan
//
//  Created by fan on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyPopMenu : UIImageView

@property(nonatomic,strong) UIView *contentView;

+(instancetype)showInRect:(CGRect)rect;

+(void)hide;
@end
