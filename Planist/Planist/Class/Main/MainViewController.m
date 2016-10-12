//
//  MainViewController.m
//  Planist
//
//  Created by easemob on 16/9/18.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "MainViewController.h"
#import "MineViewController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "CommunityViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化加载视图：
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        [[UINavigationBar appearance] setBarTintColor:RGBColor(220, 89, 54,1)];
        [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    }else{
        [[UINavigationBar appearance] setTintColor:RGBColor(220, 89, 54,1)];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self addChildVC];
}

- (void)addChildVC{
    
//    self.tabBar.backgroundColor = [UIColor orangeColor];
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    homeVC.title = @"首页";
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    [self addChildViewController:homeNav];
    
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc]init];
    discoverVC.title = @"发现";
    UINavigationController *discoverNav = [[UINavigationController alloc]initWithRootViewController:discoverVC];
    [self addChildViewController:discoverNav];
    
    CommunityViewController *communityVC = [[CommunityViewController alloc]init];
    communityVC.title = @"社区";
    UINavigationController *communityNav = [[UINavigationController alloc]initWithRootViewController:communityVC];
    [self addChildViewController:communityNav];
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    mineVC.title = @"我";
    UINavigationController *mineNav = [[UINavigationController alloc]initWithRootViewController:mineVC];
    [self addChildViewController:mineNav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
