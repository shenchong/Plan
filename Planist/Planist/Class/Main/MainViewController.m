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
        [[UINavigationBar appearance] setBarTintColor:[PublicMethod setColorWithHexString:@"#FA6464"]];
        [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    }else{
        [[UINavigationBar appearance] setTintColor:[PublicMethod setColorWithHexString:@"#FA6464"]];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self addChildVC];
}

- (void)addChildVC{
    
//    self.tabBar.backgroundColor = [UIColor orangeColor];
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    [self addChildViewControllerWithTitle:@"首页" Image:@"我" Controller:homeVC];
    
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc]init];
    [self addChildViewControllerWithTitle:@"发现" Image:@"我" Controller:discoverVC];
    
    CommunityViewController *communityVC = [[CommunityViewController alloc]init];
    [self addChildViewControllerWithTitle:@"社区" Image:@"我" Controller:communityVC];
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    [self addChildViewControllerWithTitle:@"我" Image:@"我" Controller:mineVC];
}

- (void)addChildViewControllerWithTitle:(NSString *)title Image:(NSString *)image Controller:(UIViewController *)controller{
    
    controller.tabBarItem.image = [UIImage imageNamed:image];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",image]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.title = title;
    [self selectedTapTabBarItems:controller.tabBarItem];
    [self unSelectedTapTabBarItems:controller.tabBarItem];
    UINavigationController *navCtl = [[UINavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:navCtl];
    controller.view.backgroundColor = [UIColor whiteColor];
}

/**
 *  设置tabbar字体
 */
-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"PingFangSC-Regular" size:10], UITextAttributeFont,[UIColor grayColor],UITextAttributeTextColor,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"PingFangSC-Regular" size:10],
                                        UITextAttributeFont,[PublicMethod setColorWithHexString:@"#FA6464"],UITextAttributeTextColor,
                                        nil] forState:UIControlStateSelected];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
