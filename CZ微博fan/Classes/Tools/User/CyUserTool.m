//
//  CyUserTool.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyUserTool.h"
#import "CyUserResult.h"
#import "CyHttpTool.h"
#import "CyUserParam.h"
#import "CyAcountTool.h"
#import "CyAccountModel.h"
#import "CyUser.h"
#import "MJExtension.h"
@implementation CyUserTool


+(void)unreadWithSuccess:(void (^)(CyUserResult *))success failure:(void (^)(NSError *))failure{
    
    
    CyUserParam *param = [CyUserParam param];
    param.uid = [CyAcountTool acount].uid;
    
    
    [CyHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json"  parameters:param.keyValues success:^(id responseObject) {
        
    CyUserResult *result = [CyUserResult objectWithKeyValues:responseObject];
        
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

+(void)userInfoWithSuccess:(void (^)(CyUser *))success failure:(void (^)(NSError *))failure{
    
    CyUserParam *param = [CyUserParam param];
    param.uid = [CyAcountTool acount].uid;
    
    [CyHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        
        CyUser *user = [CyUser objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
        
        
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
@end
