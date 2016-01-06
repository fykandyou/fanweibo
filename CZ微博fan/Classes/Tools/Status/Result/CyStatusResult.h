//
//  CyStatusResult.h
//  CZ微博fan
//
//  Created by fan on 15/12/27.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CyStatusResult : NSObject

/**
 *  用户的微博数组（CZStatus）
 */
@property (nonatomic, strong) NSArray *statuses;

/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int *total_number;

@end
