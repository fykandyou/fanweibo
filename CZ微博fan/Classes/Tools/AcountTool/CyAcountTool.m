//
//  CyAcountTool.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/26.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyAcountTool.h"
#import "CyAccountModel.h"

#import "CyAccountParam.h"
#import "MJExtension.h"
#import "CyHttpTool.h"

#define CyAuthorizeURL @"https://api.weibo.com/oauth2/authorize"
#define CyClient_id @"1944942166"
#define CyRedirect_uri @"http://www.baidu.com"
#define CyClient_secret @"07379513825f5f2acd44d21bcbd82a28"

#define CyAccountFilePath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
@implementation CyAcountTool

//类方法一般用静态变量代替成员变量
static CyAccountModel *_account;

+(void)saveAcount:(CyAccountModel *)acount{
    
    [NSKeyedArchiver archiveRootObject:acount toFile:CyAccountFilePath];
}
+(CyAccountModel *)acount{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:CyAccountFilePath];
        
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    return _account;
}



+(void)accessTokenWithCode:(NSString *)code sucess:(void(^)())sucess failure:(void(^)(NSError *))failure{
    
    //code参数竟然被我忘记了，找bug找了1个多小时
    CyAccountParam *param = [[CyAccountParam alloc] init];
    param.client_id =CyClient_id;
    param.client_secret =CyClient_secret;
    param.grant_type = @"authorization_code";
    param.redirect_uri = CyRedirect_uri;
    param.code = code;
    
    [CyHttpTool Post:@"https://api.weibo.com/oauth2/access_token"  parameters:param.keyValues success:^(id responseObject) {
        
        CyAccountModel *account = [CyAccountModel accountWithDictionary:responseObject];
        
        //将acount信息存入本地，归档
        [CyAcountTool saveAcount:account];
        
        if (sucess) {
            sucess();
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];

   
    
}

@end
