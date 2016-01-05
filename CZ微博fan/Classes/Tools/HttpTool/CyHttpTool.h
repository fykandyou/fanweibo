//
//  CyHttpTool.h
//  CZ微博fan
//
//  Created by qingyun on 15/12/27.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CyUploadParam;
@interface CyHttpTool : NSObject

+(void)GET:(NSString *)baseURL parameters:(NSDictionary *)parameters success:(void(^)(id responseObject)) sucess failure:(void (^)(NSError *error)) failure;


+(void)Post:(NSString *)baseURL parameters:(NSDictionary *)parameters success:(void(^)(id responseObject)) sucess failure:(void (^)(NSError *error)) failure;

+ (void)Upload:(NSString *)URLString parameters:(id)parameters uploadParam:(CyUploadParam *)uploadParam success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
