//
//  CyBadgeView.m
//  CZ微博fan
//
//  Created by fan on 15/12/23.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyBadgeView.h"



@implementation CyBadgeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self sizeToFit];
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = badgeValue;
    
    if ((badgeValue.length == 0) || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    
    CGSize size = [badgeValue sizeWithFont:[UIFont systemFontOfSize:11]];
    if (size.width > self.bounds.size.width ) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setImage:nil forState:UIControlStateNormal];
        [self setTitle:badgeValue   forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
