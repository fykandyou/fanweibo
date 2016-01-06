//
//  CyHttpTool.m
//  CZ微博fan
//
//  Created by fan on 15/12/27.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyHttpTool.h"
#import "AFNetworking.h"
#import "CyUploadParam.h"
@implementation CyHttpTool



+(void)GET:(NSString *)baseURL parameters:(NSDictionary *)parameters success:(void(^)(id responseObject)) sucess failure:(void(^)(NSError *error)) failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask *  task, id responseObject) {
        
        if (sucess) {
            sucess(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
        
        if (failure) {
            failure(error);
        }
    }];
}

+(void)Post:(NSString *)baseURL parameters:(NSDictionary *)parameters success:(void (^)(id responeObject))sucess failure:(void (^)(NSError *))failure{
    
    //为什么会请求失败，baseUrl ？ 参数 ？
    
    //NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
   // AFHTTPSessionManager *manager =[[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@",parameters);
    [manager POST:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask *  task, id responseObject) {
        
        if (sucess) {
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * task, NSError *  error) {
        if (failure) {
            failure(error);
        }
    }];
    
}



+ (void)Upload:(NSString *)URLString parameters:(id)parameters uploadParam:(CyUploadParam *)uploadParam success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    
    
    AFHTTPSessionManager *manager= [AFHTTPSessionManager manager];
//    
//    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
    
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];

    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        if (failure) {
            failure(error);
        }
    }];
    
}




@end
