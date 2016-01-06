//
//  CyUser.m
//  CZ微博fan
//
//  Created by fan on 15/12/26.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyUser.h"

@implementation CyUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}


@end
