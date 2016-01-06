//
//  CyCover.m
//  CZ微博fan
//
//  Created by fan on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyCover.h"

@implementation CyCover

//设置浅灰色蒙版
-(void)setDimBackground:(BOOL)dimBackground{
    if (dimBackground) {
        [self setBackgroundColor:[UIColor blackColor]];
        self.alpha = 0.5;
    }else{
        [self setBackgroundColor:[UIColor clearColor]];
        self.alpha = 1;
    }
    
    _dimBackground = dimBackground;
}


+(instancetype)show{
    
    CyCover *cover = [[CyCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    //keywindow
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    return cover;
}

//点击蒙版后，将蒙版从keywindow中移除，并通知代理移除菜单
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(coverDidClicked:)]) {
        [self.delegate coverDidClicked:self];
    }
    
    
    
    
}

















@end
