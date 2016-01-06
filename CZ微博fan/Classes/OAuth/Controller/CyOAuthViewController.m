//
//  CyOAuthViewController.m
//  CZ微博fan
//
//  Created by fan on 15/12/25.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "CyAccountModel.h"
#import "CyAcountTool.h"
#import "CyRootTool.h"


@interface CyOAuthViewController ()<UIWebViewDelegate>

@end

@implementation CyOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"1944942166";
    NSString *redirect_uri = @"http://www.baidu.com";
    
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];

    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载请求
    [webView loadRequest:request];
    
    webView.delegate = self;
}
#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    
    NSRange codeRange = [urlStr rangeOfString:@"code="];
    
    if (codeRange.length) {
        
        NSString *code = [urlStr substringFromIndex:codeRange.location + codeRange.length];
        
        [self accessTokenWithCode:code];
        
        return NO;
    }
#warning 此地有个bug
    
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code{
    
   [CyAcountTool accessTokenWithCode:code sucess:^{
       
       [CyRootTool choseRootViewController:[UIApplication sharedApplication].keyWindow];
       
   } failure:^(NSError *error) {
     
       NSLog(@"%@",error);
  
   }];
        
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
@end
