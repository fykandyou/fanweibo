//
//  CyBaseParam.h
//  CZ微博fan
//
//  Created by fan on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CyBaseParam : NSObject


/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property(nonatomic,copy) NSString *access_token;


+(instancetype)param;

@end
