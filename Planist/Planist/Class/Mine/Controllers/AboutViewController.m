//
//  AboutViewController.m
//  Planist
//
//  Created by easemob on 2016/12/7.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
}

- (void)initViews{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 60, 121, 120, 120)];
    imageView.backgroundColor = [PublicMethod setColorWithHexString:@"#D8D8D8"];
    imageView.layer.cornerRadius = 20;
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];
    
    UILabel *versionLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 291, kScreenWidth, 19)];
    versionLbl.textAlignment = NSTextAlignmentCenter;
    versionLbl.text = @"两人游 v1.0";
    versionLbl.font = SCFont(16);
    versionLbl.textColor = [PublicMethod setColorWithHexString:@"#643232"];
    [self.view addSubview:versionLbl];
    
    UILabel *contactUsLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-30-14, kScreenWidth, 14)];
    contactUsLbl.textAlignment = NSTextAlignmentCenter;
    contactUsLbl.text = @"联系我们";
    contactUsLbl.font = SCFont(12);
    contactUsLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
    [self.view addSubview:contactUsLbl];
    
    UILabel *phoneLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight-30-14-29, kScreenWidth, 14)];
    phoneLbl.textAlignment = NSTextAlignmentCenter;
    phoneLbl.text = @"xxx";
    phoneLbl.font = SCFont(12);
    phoneLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
    [self.view addSubview:phoneLbl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
