//
//  CySubPhotoView.m
//  CZ微博fan
//
//  Created by fan on 15/12/31.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CySubPhotoView.h"
#import "UIImageView+WebCache.h"
#import "CyPhoto.h"
#import "UIView+Frame.h"

@interface CySubPhotoView ()
@property(nonatomic,strong) UIImageView *gifView;
@end

@implementation CySubPhotoView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        
        _gifView = gifView;
    }
    return self;
}

-(void)setPhoto:(CyPhoto *)photo{
    
    _photo = photo;
    
    //赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    NSString *str = photo.thumbnail_pic.absoluteString;
    if ([str hasSuffix:@".gif"]) {
        _gifView.hidden = NO;
    }else{
        _gifView.hidden = YES;
    }
    
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width  - self.gifView.width;
    self.gifView.y = self.width - self.gifView.height;
    
}
@end
