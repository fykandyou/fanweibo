//
//  CyComposeCover.h
//  CZ微博fan
//
//  Created by fan on 16/1/5.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CyComposeCover;

@protocol CyComposeCoverProtocol <NSObject>

@optional

-(void)didClickCoverOfCompose:(CyComposeCover *)cover;

@end


@interface CyComposeCover : UIView

@property(nonatomic,strong) id<CyComposeCoverProtocol>delegate;


+(instancetype)show;
@end
