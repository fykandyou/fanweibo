//
//  CyRetweetView.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyRetweetView.h"
#import "CyStatus.h"
#import "CyStatusFrame.h"
#import "CyPhotoView.h"
@interface CyRetweetView ()
// 昵称
@property (nonatomic, weak) UILabel *nameView;


// 正文
@property (nonatomic, weak) UILabel *textView;

//配图
@property  (nonatomic,weak) CyPhotoView *photoView;
@end

@implementation CyRetweetView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        [self setupSubViews];
        
        self.userInteractionEnabled =YES;
        UIImage *image =[UIImage imageNamed:@"timeline_retweet_background"];
        self.image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        
        
    }
    return self;
}

-(void)setupSubViews{
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    [self addSubview:nameView];
    nameView.font = CyNameFont;
    _nameView = nameView;
    
    
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    [self addSubview:textView];
    textView.font = CyTextFont;
    textView.numberOfLines = 0;
    _textView = textView;

    //配图
    CyPhotoView *photoView = [[CyPhotoView alloc] init];
    [self addSubview:photoView];
    _photoView = photoView;

}


-(void)setStatusFrame:(CyStatusFrame *)statusFrame{
    
    _statusFrame = statusFrame;
    
    CyStatus *status = statusFrame.status;
    
    //昵称
    _nameView.text = status.retweetName;
    _nameView.frame =statusFrame.retweetNameFrame;

    
    //正文
    _textView.text = status.retweeted_status.text;
    _textView.frame = statusFrame.retweetTextFrame;

    //配图
    _photoView.frame = statusFrame.retweetPhotoFrame;
    _photoView.pic_urls = status.retweeted_status.pic_urls;
    
}



@end
