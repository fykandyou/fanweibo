//
//  CyOriginalView.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyOriginalView.h"
#import "UIImageView+WebCache.h"
#import "CyStatusFrame.h"
#import "CyStatus.h"
#import "CyPhotoView.h"
@interface CyOriginalView ()

// 头像
@property (nonatomic, weak) UIImageView *iconView;


// 昵称
@property (nonatomic, weak) UILabel *nameView;


// vip
@property (nonatomic, weak) UIImageView *vipView;


// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;


// 正文
@property (nonatomic, weak) UILabel *textView;


//配图
@property (nonatomic,weak ) CyPhotoView *photosView;

@end

@implementation CyOriginalView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        [self setupSubViews];
     
        self.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"timeline_card_top_background"];
        self.image = [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height * 0.5];
        

    }
    return self;
}

-(void)setupSubViews{
    
   //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView =iconView;
    
  //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel ];
    nameLabel.font = CyNameFont;
    _nameView = nameLabel;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;

    //时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    timeLabel.font = CyTimeFont;
    _timeView = timeLabel;
 
    //来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self addSubview:sourceLabel];
    sourceLabel.font = CyTimeFont;
    _sourceView =sourceLabel;
    

    //正文
    UILabel *textLabel = [[UILabel alloc] init];
    [self addSubview:textLabel];
    textLabel.font = CyTextFont;
    textLabel.numberOfLines = 0;
    _textView = textLabel;
    
    //配图
    CyPhotoView *imageView = [[CyPhotoView alloc] init];
    [self addSubview:imageView];
    _photosView = imageView;
    
    
    
}


-(void)setStatusFrame:(CyStatusFrame *)statusFrame{
    
    _statusFrame = statusFrame;
    
    [self setSubViewsFrame];
  
    
    [self setSubViewsData];

}


-(void)setSubViewsData{
    
    CyStatus *status = _statusFrame.status;
    //头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    //vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    _vipView.image = image;
    
    //时间
    _timeView.text = status.created_at;
    //来源
    _sourceView.text = status.source;
    NSLog(@"%@",_sourceView.text);
    
    //正文
    _textView.text = status.text;
    
    //配图
    _photosView.pic_urls = status.pic_urls;
    
}


-(void)setSubViewsFrame{

    //头像
    _iconView.frame = _statusFrame.originalIconFrame;
    
    //昵称
    _nameView.frame =_statusFrame.originalNameFrame;
    //vip
    _vipView.frame = _statusFrame.originalVipFrame;
    
    
    // 时间
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + CyStatusCellMargin * 0.5;
    
    CyStatus *status = self.statusFrame.status;
    NSDictionary *timeAttributes = @{NSFontAttributeName:CyTimeFont};
    CGSize timeSize = [status.created_at sizeWithAttributes:timeAttributes];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + CyStatusCellMargin;
    CGFloat sourceY = timeY;
    
    NSDictionary *sourceAttributes = @{NSFontAttributeName:CySourceFont};
    CGSize sourceSize = [status.source sizeWithAttributes:sourceAttributes];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};

    
    //正文
    _textView.frame = _statusFrame.originalTextFrame;
    
    //配图
    _photosView.frame = _statusFrame.originalPhotoFrame;
}











@end
