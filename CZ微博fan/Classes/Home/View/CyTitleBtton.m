//
//  CyTitleBtton.m
//  CZ微博fan
//
//  Created by fan on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyTitleBtton.h"
#import "UIView+Frame.h"
@implementation CyTitleBtton

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed:@"navigationbar_filter_background_highlighted"];
        [self setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height * 0.5] forState:UIControlStateHighlighted];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    if (self.currentImage == nil) {
        return;
    }
    
    //竟然改成0就可以了，要动脑筋了
    self.titleLabel.x = 0;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
