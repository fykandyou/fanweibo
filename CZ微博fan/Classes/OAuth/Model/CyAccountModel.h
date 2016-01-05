//
//  CyAccountModel.h
//  CZ微博fan
//
//  Created by qingyun on 15/12/26.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CyAccountModel : NSObject<NSCoding>

//获取数据访问的令牌：微博授权给指定的用户在指定的App上才能使用
@property(nonatomic,strong) NSString *access_token;
//授权的有效期
@property(nonatomic,strong) NSString *expires_in;
//授权的有效期
@property(nonatomic,strong) NSString *remind_in;
//用户的唯一标示
@property(nonatomic,strong) NSString *uid;

@property(nonatomic,strong) NSDate *expires_date;

//用户昵称
@property(nonatomic,copy) NSString *name;

+(instancetype)accountWithDictionary:(NSDictionary *)dict;
@end
