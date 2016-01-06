//
//  CyStatusToolBar.m
//  CZ微博fan
//
//  Created by fan on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyStatusToolBar.h"
#import "CyStatus.h"
@interface CyStatusToolBar ()

@property(nonatomic,strong) NSMutableArray *buttonArray;
@property(nonatomic,strong) NSMutableArray *imageArray;


@property(nonatomic,strong) UIButton *retweetBtn;
@property(nonatomic,strong) UIButton *commentBtn;
@property(nonatomic,strong) UIButton *like;
@end



@implementation CyStatusToolBar

-(NSMutableArray *)buttonArray{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

-(NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"timeline_card_bottom_background"];
        self.image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        
        [self setupSubViews];
        
    }
    return self;
}

-(void)setupSubViews{
    //转发
    UIButton *retBtn =[self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_retweet"] Title:@"转发"];
    _retweetBtn = retBtn;
    
    //评论
    UIButton *commentBtn =[self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_comment"] Title:@"评论"];
    _commentBtn = commentBtn;
    
    //赞
    UIButton *likeBtn =[self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_unlike"] Title:@"赞"];
    _like = likeBtn;
    
    
    //加两个lable
    for (int i = 0 ; i < 2; i++) {
         UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:imageView];
        [self.imageArray addObject:imageView];
        
    }
    
}


-(UIButton *)setUpOneButtonWithImage:(UIImage *)image Title:(NSString *)title{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.text = title;
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    
    [self.buttonArray addObject:btn];
    [self addSubview:btn];
    return btn;
}



-(void)layoutSubviews{
    
    NSInteger count = self.buttonArray.count;
    
    CGFloat w = self.bounds.size.width / count;
    CGFloat y = 0;
    CGFloat x = 0;
    CGFloat h = self.bounds.size.height;
    
    for (int i = 0; i<count; i++) {
        x = i * w;
        UIButton *btn = self.buttonArray[i];
        btn.frame = CGRectMake(x, y, w, h);

    }
    
    int i = 1;
    for (UIImageView *imageView in self.imageArray) {
        UIButton *btn = self.buttonArray[i];
        CGRect frame = imageView.frame;
        frame.origin.x = btn.frame.origin.x;
        imageView.frame = frame;
        i++;
        
    }
 
}



-(void)setStatus:(CyStatus *)status{
    
    
    _status = status;
    
    
    //设置转发标题
    [self setBtn:_retweetBtn WithTitle:self.status.reposts_count];
    
    //设置评论标题
    [self setBtn:_commentBtn WithTitle:self.status.comments_count];
    
    //设置赞
    [self setBtn:_like WithTitle:self.status.attitudes_count];
    
  
    
}

-(void)setBtn:(UIButton *)button WithTitle:(int )count{
    
    NSString *title = nil;
    if (count) {
        if (count > 10000 ) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
        }else{
            title = [NSString stringWithFormat:@"%d",count];
        }
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    
}


@end
