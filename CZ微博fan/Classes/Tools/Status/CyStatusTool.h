//
//  CyStatusTool.h
//  CZ微博fan
//
//  Created by qingyun on 15/12/27.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CyStatusResult;
@interface CyStatusTool : NSObject


+(void)newStatusWithSinceId:(NSString *)sinceId sucess:(void (^) (NSArray *status))sucess failure:(void (^)(NSError *error))failure;



+(void)moreStatusWithMaxId:(NSString *)maxId sucess:(void (^) (NSArray *status))sucess failure:(void (^)(NSError *error))failure;



@end
