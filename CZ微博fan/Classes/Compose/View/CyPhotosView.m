//
//  CyPhotosView.m
//  CZ微博fan
//
//  Created by fan on 16/1/4.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import "CyPhotosView.h"

@implementation CyPhotosView

-(void)setImage:(UIImage *)image{
    
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    NSInteger cols = 3;
    
    CGFloat margin = 10;
    
    CGFloat wh = (self.bounds.size.width - (cols - 1) * margin)/cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIImageView *imageView = self.subviews[i];
        
        col = i % cols;
        row = i / cols;
        x = col * (margin + wh);
        y = row * (margin + wh);
        imageView.frame = CGRectMake(x, y, wh, wh);
        
    }
    
    
    
}
@end
