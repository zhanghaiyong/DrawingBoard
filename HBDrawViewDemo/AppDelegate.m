//
//  AppDelegate.m
//  HBDrawViewDemo
//
//  Created by 伍宏彬 on 15/11/11.
//  Copyright © 2015年 伍宏彬. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadUrlViewController.h"
#import "AppDelegate+UPush.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [Reachability reachabilityWithHostName:@"www.google.com"];//可以以多种形式初始化
    [hostReach startNotifier]; //开始监听,会启动一个run loop
    [self updateInterfaceWithReachability: hostReach];
    
    
    //JPush
    [self setUMessageApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    LoadUrlViewController *loadVC = [[LoadUrlViewController alloc]init];
    self.window.rootViewController = loadVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

// 连接改变

- (void)reachabilityChanged: (NSNotification*)note
{
    Reachability*curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

//处理连接改变后的情况
- (void)updateInterfaceWithReachability: (Reachability*)curReach
{
    //对连接改变做出响应的处理动作。
    NetworkStatus status=[curReach currentReachabilityStatus];
    
    if (status== NotReachable) { //没有连接到网络就弹出提实况
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                       message:@"您的网络无法连接，请稍候重试"
                                                      delegate:nil
                                             cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
        [alert show];
    }
    
}


@end
