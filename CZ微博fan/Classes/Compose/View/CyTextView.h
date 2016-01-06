//
//  CyTextView.h
//  CZ微博fan
//
//  Created by fan on 16/1/4.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyTextView : UITextView
@property(nonatomic,strong) NSString *placeHolder;
//对外接口，引用通知改变占位Label是否隐藏
@property(nonatomic,assign) BOOL hidePlaceHolderLabel;
@end
