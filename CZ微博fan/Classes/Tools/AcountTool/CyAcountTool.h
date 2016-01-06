//
//  CyAcountTool.h
//  CZ微博fan
//
//  Created by fan on 15/12/26.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CyAccountModel;
@interface CyAcountTool : NSObject

+(void)saveAcount:(CyAccountModel *)acount;
+(CyAccountModel *)acount;


+(void)accessTokenWithCode:(NSString *)code sucess:(void(^)())sucess failure:(void(^)(NSError *))failure;

@end
