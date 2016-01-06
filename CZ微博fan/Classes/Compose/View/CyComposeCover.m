//
//  CyComposeCover.m
//  CZ微博fan
//
//  Created by fan on 16/1/5.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import "CyComposeCover.h"

@implementation CyComposeCover


+(instancetype)show{
    CyComposeCover *cover = [[CyComposeCover alloc] init];
    cover.backgroundColor = [UIColor purpleColor];
    
    //[[UIApplication sharedApplication].keyWindow addSubview:cover];
    
    
    return cover;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
  //  [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(didClickCoverOfCompose:)]) {
        [self.delegate didClickCoverOfCompose:self];
    }
    
}




@end
