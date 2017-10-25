//
//  LoadingViewController.m
//  Waistcoat
//
//  Created by 张海勇 on 2017/9/16.
//  Copyright © 2017年 zhy. All rights reserved.
//
#define requestUrl @"http://apns.push0001.com/getApi.jbm?app_id=1300064681"

#import "LoadUrlViewController.h"
#import "KSMNetworkRequest.h"
#import "MainViewController.h"
#import <SVProgressHUD.h>
@interface LoadUrlViewController ()
{
    NSDictionary *result;
}
@property (weak, nonatomic) IBOutlet UIImageView *backImg;

@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LoadUrlViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOpenUrl)];
    [self.imageView addGestureRecognizer:tap];
    
    [self requestData];
    
}

- (void)requestData {
    [KSMNetworkRequest getRequest:requestUrl params:nil success:^(id responseObj) {
        NSLog(@"responseObj = %@",responseObj);
        
        [SVProgressHUD dismiss];
        
        if ([responseObj[@"code"] integerValue] == 200) {
            result = responseObj[@"result"];
            if ([result[@"is_show_tip"] integerValue] == 1) {
                self.popupView.hidden = NO;
                self.backImg.hidden = NO;
            }else {
                self.popupView.hidden = YES;
                self.backImg.hidden = YES;
                UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainViewController *mainVC = [SB instantiateViewControllerWithIdentifier:@"MainViewController"];
                [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
            }
        }else {
            
            UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *mainVC = [SB instantiateViewControllerWithIdentifier:@"MainViewController"];
            [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        self.popupView.hidden = YES;
        self.backImg.hidden = YES;
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.popupView.hidden == YES && self.backImg.hidden == YES) {
        [self requestData];
    }
}

- (void)tapOpenUrl {
    NSURL *url = [NSURL URLWithString:result[@"url"]];
    [[UIApplication sharedApplication]openURL:url];
}

@end

