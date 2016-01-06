//
//  CyUserTool.h
//  CZ微博fan
//
//  Created by fan on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CyUserResult.h"
@class CyUser;
@interface CyUserTool : NSObject


/**
 *  请求用户的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(CyUserResult *result))success failure:(void(^)(NSError *error))failure;




/**
 *  用户信息的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(CyUser *result))success failure:(void(^)(NSError *error))failure;




@end
