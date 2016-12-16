//
//  AppDelegate.m
//  Planist
//
//  Created by easemob on 16/9/18.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化阿里百川
    [self ALBApplication:application didFinishLaunchingWithOptions:launchOptions];
    //初始化环信
    [self EaseApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    MainViewController *tabBarVC = [[MainViewController alloc]init];
    self.window.rootViewController = tabBarVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    BOOL isHandled = [[ALBBSDK sharedInstance] handleOpenURL:url]; // 如果百川处理过会返回YES
    if (!isHandled) {
        // 其他处理逻辑
    }
    return YES;
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
////    BOOL isHandled = [[AlibcTradeSDK sharedInstance] handleOpenURL:url]; // 如果百川处理过会返回YES
////    if (!isHandled) {
////        // 其他处理逻辑
////    }
//    return YES;
//}

- (void)EaseApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    EMOptions *options = [EMOptions optionsWithAppkey:@"hx#hxdemo"];
    options.enableConsoleLog = NO;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[EMClient sharedClient] loginWithUsername:@"1" password:@"1"];
}

- (void)ALBApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [[ALBBSDK sharedInstance] setDebugLogOpen:NO]; // 打开debug日志
    [[ALBBSDK sharedInstance] setUseTaobaoNativeDetail:YES]; // 优先使用手淘APP打开商品详情页面，如果没有安装手机淘宝，SDK会使用H5打开
    [[ALBBSDK sharedInstance] setViewType:ALBB_ITEM_VIEWTYPE_TAOBAO];// 使用淘宝H5页面打开商品详情
    [[ALBBSDK sharedInstance] setISVCode:@"my_isv_code"]; //设置全局的app标识，在电商模块里等同于isv_code
    [[ALBBSDK sharedInstance] asyncInit:^{ // 基础SDK初始化
        NSLog(@"init success");
    } failure:^(NSError *error) {
        NSLog(@"init failure, %@", error);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
