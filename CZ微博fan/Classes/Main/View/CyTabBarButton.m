//
//  CyTabBarButton.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/23.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyTabBarButton.h"
#import "CyBadgeView.h"
#import "UIView+Frame.h"
#define CZImageRidio 0.7

@interface CyTabBarButton ()
@property(nonatomic,strong) CyBadgeView *badgeValueView;
@end
@implementation CyTabBarButton

-(CyBadgeView *)badgeValue{
    if (_badgeValueView == nil) {
        CyBadgeView *badge = [CyBadgeView buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:badge];
        
        _badgeValueView = badge;
    }
    return _badgeValueView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        //设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //设置titleLabel的字体文本居中和字体大小
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}

-(void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听BadgeValue
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
   
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    //BadgeValue
    self.badgeValueView.badgeValue =_item.badgeValue;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //下面的部分直接复制的，稍后再看
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * CZImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    self.badgeValueView.x = self.width - self.badgeValue.width - 10;
    self.badgeValueView.y = 0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
