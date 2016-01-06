//
//  CyStatusTool.m
//  CZ微博fan
//
//  Created by fan on 15/12/27.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyStatusTool.h"
#import "CyHttpTool.h"
#import "CyStatus.h"
#import "CyAcountTool.h"
#import "CyAccountModel.h"

#import "CyStatusParam.h"
#import "CyStatusResult.h"

#import "MJExtension.h"
@implementation CyStatusTool

+(void)newStatusWithSinceId:(NSString *)sinceId sucess:(void (^) (NSArray *status))sucess failure:(void (^)(NSError *error))failure{
    
    CyStatusParam *param = [[CyStatusParam alloc] init];
    if (sinceId) {
        param.since_id = sinceId;

    }
    param.access_token =[CyAcountTool acount].access_token;

    
    
   [CyHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
      
          // NSArray *dictArr = responseObject[@"statuses"];
           
           //NSMutableArray *statusArr = [NSMutableArray array];
       
       //将返回来的Jason数据转化为结果模型
       CyStatusResult *result = [CyStatusResult objectWithKeyValues:responseObject];
       
       
//           for (NSDictionary *dict in dictArr) {
//#warning 该方法需要自己了解到底怎么做的
//               CyStatus *status = [CyStatus objectWithKeyValues:dict];
//               [statusArr addObject:status];
//           }
       
       
       
           if (sucess) {
                sucess(result.statuses);
           }
       
   } failure:^(NSError *error) {
       

           if (failure) {
               failure(error);
           }
       
   }];
}

+(void)moreStatusWithMaxId:(NSString *)maxId sucess:(void (^)(NSArray *))sucess failure:(void (^)(NSError *))failure{

    CyStatusParam *params = [[CyStatusParam alloc] init];
    
    if (maxId) {
        
        params.max_id = maxId;
        
    }
    
    params.access_token = [CyAcountTool acount].access_token;
    

    
    
    [CyHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:(NSDictionary *)params.keyValues success:^(id responseObject) {
        
        NSArray *dictArr = responseObject[@"statuses"];
        
        NSMutableArray *statusArr = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArr) {
#warning 该方法需要自己了解到底怎么做的MJ
            CyStatus *status = [CyStatus objectWithKeyValues:dict];
            [statusArr addObject:status];
        }
        
        if (sucess) {
            sucess(statusArr);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
    
    
    
    
    
    
    
}




















@end
