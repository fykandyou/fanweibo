//
//  CyStatusFrame.m
//  CZ微博fan
//
//  Created by fan on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyStatusFrame.h"
#import "CyStatus.h"

#warning cell中有的没有图片昵称来源？？？？？？？？？？？？？？

@implementation CyStatusFrame

-(void)setStatus:(CyStatus *)status{
    _status = status;
//W3school
    //计算原创微博
    [self setUpOriginalView];
    
    CGFloat toolY = CGRectGetMaxY(_originalViewFrame);
    
    if (self.status.retweeted_status) {
        //计算转发微博
        [self setUpRetweetView];
        toolY = CGRectGetMaxY(_retweetViewFrame);
    }

        //计算ToolBar
    CGFloat toolX = 0 ;
    CGFloat toolW = CyScreenW;
    CGFloat toolH =35;
    _toolBarFrame = CGRectMake(toolX, toolY, toolW, toolH);
    
    //计算cell高度
    _cellHeight =CGRectGetMaxY(_toolBarFrame);

}

#pragma mark -- 计算原创微博
-(void)setUpOriginalView{
    //头像
    CGFloat imageX =CyStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + CyStatusCellMargin;
    CGFloat nameY = imageY;
#warning @{NSFontAttributeName:...} NSFontAttributeName不用加引号
    NSDictionary *nameAttributes = @{NSFontAttributeName:CyNameFont};
    CGSize  nameSize = [_status.user.name sizeWithAttributes:nameAttributes];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + CyStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
    
    
       // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + CyStatusCellMargin;
    
    CGFloat textW = CyScreenW - 2 * CyStatusCellMargin;
    
    NSDictionary *textAttributes = @{NSFontAttributeName:CyTextFont};
    CGRect textSize = [_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil ];
    _originalTextFrame = (CGRect){{textX,textY},textSize.size};
    
    CGFloat originViewH = CGRectGetMaxY(_originalTextFrame) + CyStatusCellMargin;

    //配图
    if (_status.pic_urls.count) {
        
        CGFloat photosX = CyStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + CyStatusCellMargin;
        
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        _originalPhotoFrame = (CGRect){{photosX,photosY},photosSize};
    
        originViewH = CGRectGetMaxY(_originalPhotoFrame) +CyStatusCellMargin;
    }
   
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = CyScreenW;
    _originalViewFrame = CGRectMake(originX, originY, originW, originViewH);
}

-(CGSize)photosSizeWithCount:(NSInteger)count{
    
    //获取总列数
    int colums = count==4?2:3;
    
    //获取总行数
    int rols = (count - 1) / colums + 1;
    
    CGFloat photoWH = 70;
    CGFloat photosW = photoWH * colums + CyStatusCellMargin * (colums - 1);
    CGFloat photosH = photoWH * rols + CyStatusCellMargin * (rols -1);
    
    
    return CGSizeMake(photosW, photosH);
}

#pragma mark -- 计算转发微博
-(void)setUpRetweetView{
    
    //昵称
    CGFloat nameX = CyStatusCellMargin;
    CGFloat nameY = nameX;
    
    NSDictionary *attributes =@{NSFontAttributeName:CyNameFont};
    CGSize  nameSize = [_status.retweetName sizeWithAttributes:attributes];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //正文
    CGFloat textX = CyStatusCellMargin;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + CyStatusCellMargin;
    CGFloat textW = CyScreenW - 2 * CyStatusCellMargin;
    
    NSDictionary *attr =@{NSFontAttributeName:CyTextFont};
    CGRect textSize = [_status.retweeted_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    _retweetTextFrame =(CGRect){{textX,textY},textSize.size};
    
    CGFloat retweetViewH = CGRectGetMaxY(_retweetTextFrame) + CyStatusCellMargin;
    
    //retweet_Photo
    int count = (int)_status.retweeted_status.pic_urls.count;
   
    if(count) {
        CGFloat photosX = CyStatusCellMargin;
        CGFloat photosY = CyStatusCellMargin + CGRectGetMaxY(_retweetTextFrame);
        CGSize photosSize = [self photosSizeWithCount:count];
        
        _retweetPhotoFrame = (CGRect){{photosX,photosY},photosSize};
        
        retweetViewH = CGRectGetMaxY(_retweetPhotoFrame)+ CyStatusCellMargin;

    }
    
    //转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = CyScreenW;
    
    _retweetViewFrame =(CGRect){retweetX,retweetY,retweetW,retweetViewH};
    

 }
@end
