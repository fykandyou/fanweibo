//
//  CyPopMenu.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyPopMenu.h"
@implementation CyPopMenu


+(instancetype)showInRect:(CGRect)rect{
    CyPopMenu *menu = [[CyPopMenu alloc] initWithFrame:rect];
    UIImage *image = [UIImage imageNamed:@"popover_background"];
    menu.image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:menu];
    
    return menu;
}

+(void)hide{
    
    for (UIView *subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:self]) {
            [subView removeFromSuperview];
        }
    }
}
-(void)setContentView:(UIView *)contentView{
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    _contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_contentView];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat X = 5;
    CGFloat Y = 9;
    CGFloat W = self.frame.size.width - 2 * X;
    CGFloat H = self.frame.size.height - Y;
    _contentView.frame = CGRectMake(X, Y, W, H);
    
}
@end
