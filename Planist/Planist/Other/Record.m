//
//  Record.m
//  Planist
//
//  Created by easemob on 16/9/29.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>

/*LoginViewController的UI搭建
- (void)initViews{
    UIButton *missBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 44, 30, 30)];
    //    missBtn.backgroundColor = [UIColor redColor];
    [missBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    missBtn.adjustsImageWhenHighlighted = NO;
    [missBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:missBtn];
    
    UIImageView *mobile = [[UIImageView alloc]initWithFrame:CGRectMake(45, 180, 20, 20)];
    mobile.image = [UIImage imageNamed:@"手机图标"];
    [self.view addSubview:mobile];
    
    UIImageView *secret = [[UIImageView alloc]initWithFrame:CGRectMake(45, 220, 20, 20)];
    secret.image = [UIImage imageNamed:@"密码图标"];
    [self.view addSubview:secret];
    
    UITextField *mobileInput = [[UITextField alloc]initWithFrame:CGRectMake(78, 181, 240, 20)];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:@"输入手机号"];
    [placeholder setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],} range:NSMakeRange(0, placeholder.length)];
    mobileInput.attributedPlaceholder = placeholder;
    //    [mobileInput drawPlaceholderInRect:CGRectMake(0, 3, 240, 17)];
    //    mobileInput.textAlignment
    [self.view addSubview:mobileInput];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(78, 201, 240, 1)];
    line.backgroundColor = RGBColor(216, 216, 216, 1);
    [self.view addSubview:line];
    
    UITextField *secretInput = [[UITextField alloc]initWithFrame:CGRectMake(78, 221, 240, 20)];
    NSMutableAttributedString *secretPlaceholder = [[NSMutableAttributedString alloc]initWithString:@"输入密码"];
    [secretPlaceholder setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:NSMakeRange(0, secretPlaceholder.length)];
    secretInput.attributedPlaceholder = secretPlaceholder;
    //    secretInput.textAlignment = NSTextAlignmentLeft;
    //    [mobileInput drawPlaceholderInRect:CGRectMake(0, 3, 240, 17)];
    [self.view addSubview:secretInput];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(78, 241, 240, 1)];
    line2.backgroundColor = RGBColor(216, 216, 216, 1);
    [self.view addSubview:line2];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(80, 300, 220, 40)];
    loginBtn.backgroundColor = RGBColor(250, 100, 100, 1);
    [loginBtn setTitle:@"登      录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn setTitleColor:RGBColor(255, 255, 255, 1) forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    
    UIButton *switchLogin = [[UIButton alloc]initWithFrame:CGRectMake(145, 346, 220, 20)];
    //    switchLogin.backgroundColor = [UIColor grayColor];
    [switchLogin setTitle:@"使用验证码登录" forState:UIControlStateNormal];
    [switchLogin setTitleColor:RGBColor(250, 100, 100, 1) forState:UIControlStateNormal];
    switchLogin.titleLabel.font = [UIFont systemFontOfSize:12];
    [switchLogin setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [switchLogin sizeToFit];
    switchLogin.x = kScreenWidth-switchLogin.width-75;
    [self.view addSubview:switchLogin];
    
    UILabel *thirdLogin = [[UILabel alloc]initWithFrame:CGRectMake(160, 502, 76, 20)];
    thirdLogin.text = @"第三方登录";
    thirdLogin.textColor = [UIColor grayColor];
    thirdLogin.font = [UIFont systemFontOfSize:12];
    [thirdLogin sizeToFit];
    [self.view addSubview:thirdLogin];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(86, 510, 64, 1)];
    line3.backgroundColor = RGBColor(216, 216, 216, 1);
    [self.view addSubview:line3];
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(226, 510, 64, 1)];
    line4.backgroundColor = RGBColor(216, 216, 216, 1);
    [self.view addSubview:line4];
    
    UIButton *wxLogin = [[UIButton alloc]initWithFrame:CGRectMake(55, 555, 50, 50)];
    [wxLogin setBackgroundImage:[UIImage imageNamed:@"微信图标 + 微信圈"] forState:UIControlStateNormal];
    [self.view addSubview:wxLogin];
    
    UIButton *qqLogin = [[UIButton alloc]initWithFrame:CGRectMake(162, 555, 50, 50)];
    [qqLogin setBackgroundImage:[UIImage imageNamed:@"QQ图标 + QQ圈"] forState:UIControlStateNormal];
    [self.view addSubview:qqLogin];
    
    UIButton *wbLogin = [[UIButton alloc]initWithFrame:CGRectMake(270, 555, 50, 50)];
    [wbLogin setBackgroundImage:[UIImage imageNamed:@"微博图标 + 微博圈"] forState:UIControlStateNormal];
    [self.view addSubview:wbLogin];
}
*/