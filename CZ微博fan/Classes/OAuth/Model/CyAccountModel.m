//
//  CyAccountModel.m
//  CZ微博fan
//
//  Created by fan on 15/12/26.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyAccountModel.h"

#define CyAccountTokenKey @"token"
#define CyUidKey @"uid"
#define CyExpires_inKey @"expires"
#define CyExpires_dateKey @"date"
#define CyName @"name"
@implementation CyAccountModel
+(instancetype)accountWithDictionary:(NSDictionary *)dict{
  
    CyAccountModel *accout = [[self alloc] init];
    [accout setValuesForKeysWithDictionary:dict];
    return accout;
}

-(void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    
    //计算失效时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}
//归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:CyAccountTokenKey];
    [aCoder encodeObject:self.uid forKey:CyUidKey];
    [aCoder encodeObject:self.expires_in forKey:CyExpires_inKey];
    [aCoder encodeObject:self.expires_date forKey:CyExpires_dateKey];
    [aCoder encodeObject:self.name forKey:CyName];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        _access_token = [aDecoder decodeObjectForKey:CyAccountTokenKey];
        _uid = [aDecoder decodeObjectForKey:CyUidKey];
        _expires_date = [aDecoder decodeObjectForKey:CyExpires_dateKey];
        _expires_in = [aDecoder decodeObjectForKey:CyExpires_inKey];
        _name = [aDecoder decodeObjectForKey:CyName];
    }
    return self;
}
@end
