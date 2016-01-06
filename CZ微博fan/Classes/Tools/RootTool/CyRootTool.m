//
//  CyRootTool.m
//  CZ微博fan
//
//  Created by fan on 15/12/26.
//  Copyright © 2015年 cyfan. All rights reserved.
//


#import "CyRootTool.h"
#define CZVersionKey @"version"

@implementation CyRootTool

+(void)choseRootViewController:(UIWindow*)window{
    
    
    NSString *currentVersion =[ [NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    //NSString *currentVersion= [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    NSString *savedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:CZVersionKey];
    
    if ([currentVersion isEqualToString:savedVersion]) {
        window.rootViewController = [[CyTabBarController alloc] init];
    }else{
        window.rootViewController = [[CyNewFeatureController alloc] init];
        
        //保存版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:CZVersionKey];
        // [[NSUserDef aults standardUserDefaults] synchronize];
    }
}
@end