//
//  CyComposeToolBar.m
//  CZ微博fan
//
//  Created by fan on 16/1/4.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import "CyComposeToolBar.h"

@implementation CyComposeToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildrenBtn];
    }
    return self;
}

-(void)setUpAllChildrenBtn{
    // 相册
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    // 提及
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    // 话题
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    // 表情
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];
    // 键盘]
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] target:self action:@selector(btnClick:)];

}

- (void)setUpButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag = self.subviews.count;
    
    [self addSubview:btn];
}

-(void)btnClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickedBtnIndex:)]) {
        [self.delegate composeToolBar:self didClickedBtnIndex:sender.tag];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat w = self.bounds.size.width / count;
    CGFloat h = self.bounds.size.height;
    CGFloat x = 0 ;
    CGFloat y = 0 ;
    
    int i = 0;
    for (UIButton *btn in self.subviews) {
        x = w * i;
        btn.frame = CGRectMake(x, y, w, h);
        i++;
        
    }
}

@end
