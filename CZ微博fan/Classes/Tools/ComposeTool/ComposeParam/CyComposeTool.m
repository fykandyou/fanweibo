//
//  CyComposeTool.m
//  CZ微博fan
//
//  Created by fan on 16/1/4.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import "CyComposeTool.h"
#import "CyHttpTool.h"
//#import "SKHttptool.h"
#import "CyComposeParam.h"
#import "MJExtension.h"
#import "CyUploadParam.h"
@implementation CyComposeTool


+(void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    CyComposeParam *param = [CyComposeParam param];
    param.status = status;
    NSLog(@"%@",param.keyValues);
    [CyHttpTool Post:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues  success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
 
    }];
}


+(void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    // 创建参数模型
    CyComposeParam *param = [CyComposeParam param];
    param.status = status;
    
    // 创建上传的模型
    CyUploadParam *uploadP = [[CyUploadParam alloc] init];
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    [CyHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadP success:^(id responseObject) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}



@end
