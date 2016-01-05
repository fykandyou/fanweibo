//
//  CyStatus.h
//  CZ微博fan
//
//  Created by qingyun on 15/12/26.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CyUser.h"
#import "MJExtension.h"
@interface CyStatus : NSObject<MJKeyValue>


/*
 * 微博创建时间
 */
@property(nonatomic,copy) NSString *created_at;

/*
 * 字符串型的微博ID
 */
@property(nonatomic,copy) NSString *idstr;

/*
 * 微博信息内容
 */
@property(nonatomic,copy) NSString *text;

/*
 *微博来源
 */
@property(nonatomic,copy) NSString *source;

/*
 *转发数
 */
#warning 这里我曾多一个指针*号，为报错，模型转化错误，搞了好半天 
@property(nonatomic,assign) int reposts_count;

/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  表态数(赞)
 */
@property (nonatomic, assign) int attitudes_count;

/*
 * 用户信息
 */
@property(strong,nonatomic) CyUser *user;



/**
 *  配图数组(CZPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;



/**
 *  转发微博
 */
@property (nonatomic, strong) CyStatus *retweeted_status;

/**
 * 转发微博的昵称@
 */
@property(nonatomic,copy) NSString *retweetName;










@end
