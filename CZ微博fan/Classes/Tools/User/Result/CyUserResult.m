//
//  CyUserResult.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyUserResult.h"

@implementation CyUserResult

-(int)messageCount{
    return _cmt + _dm + _mention_cmt + _mention_status;

}

-(int)totoalCount{
    return self.messageCount + _status + _follower;
}


@end
