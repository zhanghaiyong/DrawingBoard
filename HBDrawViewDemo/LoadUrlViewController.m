//
//  LoadingViewController.m
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "LoadUrlViewController.h"
#import "KSMNetworkRequest.h"
#import "MainViewController.h"
#import <SVProgressHUD.h>
#import <AVOSCloud/AVOSCloud.h>
@interface LoadUrlViewController ()<UIWebViewDelegate>{
    AVObject *avObj;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@end

@implementation LoadUrlViewController

- (IBAction)homeAction:(id)sender {
    
    NSURL *debugURL=[NSURL URLWithString:avObj[@"url"]];
    NSURLRequest *request=[NSURLRequest requestWithURL:debugURL];
    [self.webView loadRequest:request];
}
- (IBAction)backAction:(id)sender {
     [self.webView goBack];
}
- (IBAction)forwardAction:(id)sender {
    [self.webView goForward];
}
- (IBAction)refreshAction:(id)sender {
    [self.webView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    
//    AVObject *todo = [AVObject objectWithClassName:@"oneClass"];
//    [todo setObject:@"YES" forKey:@"show"];
//    [todo setObject:@"http://www.cocoachina.com" forKey:@"url"];
//    [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            // 存储成功
//            return ;
//        } else {
//            // 失败的话，请检查网络环境以及 SDK 配置是否正确
//        }
//    }];
    
    
    AVQuery *query = [AVQuery queryWithClassName:@"oneClass"];
    __weak LoadUrlViewController *weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (!error) {
            avObj = objects[0];
            if ([avObj[@"show"] isEqualToString:@"YES"]) {
                
                weakSelf.toolBar.hidden = NO;
                
                NSURL *debugURL=[NSURL URLWithString:avObj[@"url"]];
                NSURLRequest *request=[NSURLRequest requestWithURL:debugURL];
                [weakSelf.webView loadRequest:request];
                [weakSelf.view addSubview:weakSelf.webView];
                
            }else {
                UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainViewController *tabbar = [SB instantiateViewControllerWithIdentifier:@"MainViewController"];
                [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
            }
        }else {
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *tabbar = [SB instantiateViewControllerWithIdentifier:@"MainViewController"];
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
        }
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    [SVProgressHUD dismiss];
    return YES;
}

@end

