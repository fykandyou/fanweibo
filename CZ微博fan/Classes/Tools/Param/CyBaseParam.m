//
//  CyBaseParam.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/28.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyBaseParam.h"
#import "CyAcountTool.h"
#import "CyAccountModel.h"
@implementation CyBaseParam
+(instancetype)param{
    
    CyBaseParam *param = [[self alloc] init];
    param.access_token =[CyAcountTool acount].access_token;
 
    return param;
}

@end
