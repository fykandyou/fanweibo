//
//  CyTabBar.m
//  CZ微博fan
//
//  Created by fan on 15/12/23.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyTabBar.h"
#import "CyTabBarButton.h"

@interface CyTabBar()
@property(nonatomic,strong) UIButton *selectedButton;
@property(nonatomic,strong) NSMutableArray *buttons;
@property(nonatomic,strong) UIButton *plusButton;
@end

@implementation CyTabBar


-(UIButton *)plusButton{
    
    if (_plusButton == nil) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_plusButton setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [_plusButton sizeToFit];
        
        [_plusButton addTarget:self action:@selector(composeClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_plusButton];
    }
    
    return _plusButton;
}

-(void)composeClicked:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedComposeButton:)]) {
        [self.delegate tabBarDidClickedComposeButton:self];
    }
}

-(NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
-(void)setItems:(NSArray *)items{
    _items = items;
    
    for (UITabBarItem * item in items) {
        CyTabBarButton *button = [CyTabBarButton buttonWithType:UIButtonTypeCustom];
        button.item = item;
        
        button.tag = self.buttons.count;
        if (button.tag == 0) {
            //button.selected = YES;
            [self buttonClick:button];
        }
        
        [button addTarget:self  action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        [self.buttons addObject:button];
    }
}


-(void)buttonClick:(UIButton *)sender{
    _selectedButton.selected = NO;
    sender.selected = YES;
    _selectedButton = sender;
    
    
    if ([self.delegate respondsToSelector:@selector(TabBar:indexOfClickedButton:)]) {
        [self.delegate TabBar:self indexOfClickedButton:sender.tag];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat X = self.frame.size.width;
    CGFloat Y = self.frame.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = X/(self.items.count + 1);
    CGFloat btnH =Y;
    
    int i = 0;
    for (UIView *btn in self.subviews) {
        if (i == 2) {
          i = 3;
        }

     btnX = i * btnW;
     btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
     i++;
    }
   
    self.plusButton.center = CGPointMake(X * 0.5, Y * 0.5);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
