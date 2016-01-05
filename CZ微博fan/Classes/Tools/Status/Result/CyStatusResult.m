//
//  CyStatusResult.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/27.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyStatusResult.h"
#import "MJExtension.h"
#import "CyStatus.h"

@implementation CyStatusResult

-(NSDictionary *)objectClassInArray{
   
    return @{@"statuses":[CyStatus class]};
    
}

@end
