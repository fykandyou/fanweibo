//
//  CyPhotoView.m
//  CZ微博fan
//
//  Created by fan on 15/12/30.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyPhotoView.h"
#import "CySubPhotoView.h"
#import "CyPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"


@implementation CyPhotoView


-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        //cell 选中时会把该颜色覆盖掉
     //   self.backgroundColor = [UIColor purpleColor];
     
        [self setUpSubPhotoView];
    }
    return self;
}


-(void)setUpSubPhotoView{
    
    for (int i =0; i < 9; i++) {
        
        CySubPhotoView *imageView = [[CySubPhotoView alloc] init];
        
        imageView.tag = i + 100;
        //添加手势是UGestureRecognizer 而我变成了UIGestureRecognizer，可见我的水平多菜了
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:recognizer];
        
        [self addSubview:imageView];
    }
}

#warning  不进入这个方法
-(void)tap:(UIGestureRecognizer *)recognizer{
    
    UIImageView *imageView =(UIImageView *)recognizer.view;
    
    int i =0;
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (CyPhoto *photo in _pic_urls) {
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjPhoto.url = [NSURL URLWithString:urlStr];
        mjPhoto.index = i;
        mjPhoto.srcImageView = imageView;
        i++;
        
        [mutableArr addObject:mjPhoto];
    }
    
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = mutableArr;
    browser.currentPhotoIndex = imageView.tag - 100;
    [browser show];
    
    
    
}






-(void)setPic_urls:(NSArray *)pic_urls{
    
    _pic_urls = pic_urls;
    
    int count =(int)self.subviews.count;
    
    for (int i=0; i < count; i++) {
        CySubPhotoView *subView = self.subviews[i];
        
        if (i < pic_urls.count) {
            subView.hidden = NO;
            
            CyPhoto *photo = pic_urls[i];
            subView.photo = photo;
            
            
            
        }else{
            subView.hidden = YES;
        }
    }
}





-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat x = 0 ;
    CGFloat y = 0 ;
    CGFloat wh = 70;
    
    CGFloat margin = 10;
    
    int col = 0;
    int rol = 0;
    int colums = _pic_urls.count==4?2:3;
    
    for (int i=0; i< _pic_urls.count ; i++) {
        //所在的行
        rol = i / colums;
        //所在的列
        col = i % colums;
        
        UIImageView *view = self.subviews[i];
        x = wh * col+ margin * col ;
        y = wh * rol + margin *rol ;
        
        view.frame = CGRectMake(x, y, wh, wh);
    }
    
    
    
    
    
    
    
    
    
}
@end
