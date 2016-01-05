//
//  CyTextView.m
//  CZ微博fan
//
//  Created by qingyun on 16/1/4.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import "CyTextView.h"
#import "UIView+Frame.h"


@interface CyTextView()
@property(nonatomic,strong) UILabel *placeHolderLabel;

@end

@implementation CyTextView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}


#pragma mark - 懒加载
-(UILabel *)placeHolderLabel{
    if (_placeHolder == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}

-(void)setPlaceHolder:(NSString *)placeHolder{
    
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;

    //设置大小
    [self.placeHolderLabel sizeToFit];
    
}

-(void)setFont:(UIFont *)font{
    
    [super setFont:font];
    
    self.placeHolderLabel.font = font;
    [self.placeHolderLabel sizeToFit];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}


-(void)setHidePlaceHolderLabel:(BOOL)hidePlaceHolderLabel{
    
    _hidePlaceHolderLabel = hidePlaceHolderLabel;
    
    self.placeHolderLabel.hidden = hidePlaceHolderLabel;
    
    
}
@end
