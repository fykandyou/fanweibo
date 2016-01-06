//
//  AppDelegate.m
//  微博fan
//
//  Created by fan on 16/1/5.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import "AppDelegate.h"
#import "CyOAuthViewController.h"
#import "CyAcountTool.h"
#import "CyRootTool.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"

#define CZVersionKey @"version"

@interface AppDelegate ()
@property(nonatomic,strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //注册通知，使应用图标可以显示未读消息的总和
    UIUserNotificationSettings *settings =[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    
    [application registerUserNotificationSettings:settings];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //选择跟试图控制器
    //判断是否授权
    if ([CyAcountTool acount]) {//已经授权
        [CyRootTool choseRootViewController:self.window];
    }else{
        CyOAuthViewController *authoVC = [[CyOAuthViewController alloc] init];
        
        self.window.rootViewController = authoVC;
    }
    
    
    
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

//内存告罄
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    //停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


//失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    NSURL *url =[[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    _player = player;
    
    [player prepareToPlay];
    player.numberOfLoops = -1;
    [player play];
    
    
}
//进入后台程序时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //开启一个后台任务，优先级比较低，苹果系统优先处理结束，时间不确定
    UIBackgroundTaskIdentifier Id = [application beginBackgroundTaskWithExpirationHandler:^{
        
        //当后台程序结束时，调用
        [application endBackgroundTask:Id];
        
        
    }];
    
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    
    // 微博：在程序即将失去焦点的时候播放静音音乐.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
