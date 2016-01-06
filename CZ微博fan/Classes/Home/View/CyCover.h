//
//  CyCover.h
//  CZ微博fan
//
//  Created by fan on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CyCover;

@protocol CyCoverPro <NSObject>

@optional
-(void)coverDidClicked:(CyCover *)cover;

@end


@interface CyCover : UIView

//是否设置浅灰色蒙版
@property(nonatomic,assign) BOOL dimBackground;

//蒙版显示,并创建是指加载到整个屏幕
+(instancetype)show;

@property(nonatomic,strong) id<CyCoverPro>delegate;

@end
