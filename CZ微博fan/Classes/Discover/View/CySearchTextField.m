//
//  CySearchTextField.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/23.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CySearchTextField.h"

@implementation CySearchTextField


-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
        
        UIImage *background = [UIImage imageNamed:@"searchbar_textfield_background"];
#warning 拉伸图片？
        UIImage *stretchImage = [background stretchableImageWithLeftCapWidth:background.size.width * 0.5 topCapHeight:background.size.height * 0.5];
        self.background =stretchImage ;
        
        //设置左边的图片
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];

        CGRect  frame =leftView.frame;
        frame.size.width += 10;
        leftView.frame = frame;
        
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
