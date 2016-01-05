//
//  CyNewFeatureCell.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyNewFeatureCell.h"
#import "UIView+Frame.h"
#import "CyTabBarController.h"
@interface CyNewFeatureCell ()
@property(nonatomic,strong) UIButton *shareButton;
@property(nonatomic,strong) UIButton *startButton;
@property(nonatomic,strong) UIImageView *imageView;
@end

@implementation CyNewFeatureCell
-(UIButton *)shareButton{
    if (_shareButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        _shareButton = btn;
        [self.contentView addSubview:_shareButton];
    }
    return _shareButton;
}

-(UIButton *)startButton{
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
        
    }
    return _startButton;

}
-(void)start{
    CyTabBarController *tabBar = [[CyTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
     
         [self.contentView addSubview:_imageView];
    }
    
   
    return _imageView;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}

-(void)setIndex:(NSIndexPath *)index count:(NSInteger)count{
    if (index.row == count - 1) {
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    }else{
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.imageView.frame = self.bounds;
    
    self.shareButton.center = CGPointMake(self.width*0.5 , self.height * 0.8);
    self.startButton.center = CGPointMake(self.width*0.5, self.height * 0.9);
}
@end
