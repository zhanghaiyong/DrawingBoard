//
//  AppDelegate+UPush.h
//  Waistcoat
//
//  Created by zhy on 2017/9/18.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "AppDelegate.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (UPush)<UNUserNotificationCenterDelegate,JPUSHRegisterDelegate>
- (void)setUMessageApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@end
