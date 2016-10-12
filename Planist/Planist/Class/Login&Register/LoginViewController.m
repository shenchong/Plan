
//
//  LoginViewController.m
//  Planist
//
//  Created by easemob on 16/9/28.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "LoginViewController.h"
#import "ImageHelper.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    dispatch_source_t _timer;
}

@property (weak, nonatomic) IBOutlet UITextField *mobileInput;
@property (weak, nonatomic) IBOutlet UITextField *secretInput;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *changeLogin;
@property (weak, nonatomic) IBOutlet UIButton *wxLogin;
@property (weak, nonatomic) IBOutlet UIButton *qqLogin;
@property (weak, nonatomic) IBOutlet UIButton *wbLogin;
@property (weak, nonatomic) IBOutlet UILabel *thirdLoginlbl;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;
@property (weak, nonatomic) IBOutlet UIButton *secretSecurity;
@property (weak, nonatomic) IBOutlet UIButton *getCode;
@property (nonatomic, weak) UIImageView *imgVw;

@property (nonatomic, assign) BOOL isSecurity;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self initViews];
    [self setupViews];
    
    //监听文本框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.mobileInput];
}

- (void)setupViews{
    self.login.layer.cornerRadius = 6;
    self.login.layer.masksToBounds = YES;
    self.login.backgroundColor = RGBColor(250, 100, 100, 1);
    self.login.adjustsImageWhenHighlighted = NO;
    [self.login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.line.backgroundColor = self.line2.backgroundColor = self.line3.backgroundColor = self.line4.backgroundColor = RGBColor(216, 216, 216, 1);
    
    self.mobileInput.delegate = self;
    self.secretInput.delegate = self;
    
    self.isSecurity = YES;
    self.secretSecurity.adjustsImageWhenHighlighted = NO;
    [self.secretSecurity addTarget:self action:@selector(securitySwitch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.dismissBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.dismissBtn.adjustsImageWhenHighlighted = NO;
    
    self.changeLogin.adjustsImageWhenHighlighted = NO;
    [self.changeLogin addTarget:self action:@selector(changeLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    self.getCode.layer.cornerRadius = 4;
    self.getCode.layer.masksToBounds = YES;
    [self.getCode setBackgroundColor:RGBColor(216, 216, 216, 1)];
    self.getCode.userInteractionEnabled = NO;
    [self.getCode addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imgVw = [[UIImageView alloc]initWithFrame:CGRectMake(100, 22, 100, 32)];
    self.imgVw = imgVw;
//    imgVw.backgroundColor = [UIColor grayColor];
    imgVw.centerX = self.view.centerX;
    [self.view addSubview:imgVw];
}

- (void)securitySwitch:(UIButton *)sender{
    
    if (self.isSecurity) {
        [self.secretSecurity setBackgroundImage:[UIImage imageNamed:@"密码可见图标"] forState:UIControlStateNormal];
        self.secretInput.secureTextEntry = NO;
        self.isSecurity = NO;
    }else{
        [self.secretSecurity setBackgroundImage:[UIImage imageNamed:@"密码不可见图标"] forState:UIControlStateNormal];
        self.secretInput.secureTextEntry = YES;
        self.isSecurity = YES;
    }
}

- (void)changeLogin:(UIButton *)sender{
    if ([self.changeLogin.titleLabel.text isEqualToString:@"使用验证码登录"]) {
        [self.changeLogin setTitle:@"使用密码登录" forState:UIControlStateNormal];
        self.secretInput.width = 180;
        self.secretSecurity.hidden = YES;
        self.getCode.hidden = NO;
        self.secretInput.placeholder = @"输入验证码";
        self.secretInput.text = nil;
        self.secretInput.secureTextEntry = NO;
        
    }else if ([self.changeLogin.titleLabel.text isEqualToString:@"使用密码登录"]){
        [self.changeLogin setTitle:@"使用验证码登录" forState:UIControlStateNormal];
        self.secretInput.width = 210;
        self.secretSecurity.hidden = NO;
        self.getCode.hidden = YES;
        self.secretInput.placeholder = @"输入密码";
        self.secretInput.text = nil;
        self.secretInput.secureTextEntry = self.isSecurity;
    }
}

- (void)loginAction{
    if (self.mobileInput.text.length == 11&&self.secretInput.text.length != 0) {
        
        NSString *phoneNumber = self.mobileInput.text;
        NSString *urlStrTemp = [NSString stringWithFormat:@"%@?phone=%@&passwordPhone=%@",API_Account_LoginByPhone,phoneNumber,self.secretInput.text];
        NSString *urlStr = [urlStrTemp stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
            NSLog(@"%@",result);
            NSString *str = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        } fail:^(NSError *error) {
            
        }];
    }
    
    if (self.mobileInput.text.length == 0) {
        NSLog(@"登陆失败");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请输入手机号";
        hud.bezelView.color = RGBColor(38, 16, 17, 1);
        hud.contentColor = [UIColor whiteColor];
        hud.mode = MBProgressHUDModeText;
        hud.offset = CGPointMake(0, -120);
        [hud hideAnimated:YES afterDelay:1];

    }else if (self.mobileInput.text.length != 11){
        NSLog(@"请输入正确的手机号");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请输入正确手机号";
        hud.bezelView.color = RGBColor(38, 16, 17, 1);
        hud.contentColor = [UIColor whiteColor];
        hud.mode = MBProgressHUDModeText;
        hud.offset = CGPointMake(0, -120);
        [hud hideAnimated:YES afterDelay:1];
    }else if (self.mobileInput.text.length == 11){
        if ([self.changeLogin.titleLabel.text isEqualToString:@"使用验证码登录"]) {
            if (self.secretInput.text.length != 6) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = @"请输入验证码";
                hud.bezelView.color = RGBColor(38, 16, 17, 1);
                hud.contentColor = [UIColor whiteColor];
                hud.mode = MBProgressHUDModeText;
                hud.offset = CGPointMake(0, -120);
                [hud hideAnimated:YES afterDelay:1];
            }
        }
    }
}

- (void)getCodeAction:(UIButton *)sender{
    [self startTime];
    
    NSString *phoneNumber = self.mobileInput.text;
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?phone=%@",API_Account_GetCode,phoneNumber];
    NSString *urlStr = [urlStrTemp stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    @"http://192.168.0.109:8080/Planist/loginController/generateCaptchaByPhone?18155307625"
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSLog(@"%@",result);
        NSString *str = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"验证码已发送";
        hud.detailsLabel.text = @"请耐心等待";
        hud.bezelView.color = RGBColor(38, 16, 17, 1);
        hud.contentColor = [UIColor whiteColor];
        hud.mode = MBProgressHUDModeText;
        hud.offset = CGPointMake(0, -120);
        [hud hideAnimated:YES afterDelay:1];
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"发送验证码失败";
        hud.bezelView.color = RGBColor(38, 16, 17, 1);
        hud.contentColor = [UIColor whiteColor];
        hud.mode = MBProgressHUDModeText;
        hud.offset = CGPointMake(0, -120);
        [hud hideAnimated:YES afterDelay:1];
    }];
}

- (void)startTime
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            [self endTimer];
        }else{
            //int minutes = timeout / 60;
            int seconds = timeout %61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.getCode.userInteractionEnabled = NO;
                [self.getCode setTitle:[NSString stringWithFormat:@"%@后重发",strTime] forState:UIControlStateNormal];
                [self.getCode setBackgroundColor:RGBColor(216, 216, 216, 1)];
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)endTimer
{
    dispatch_source_cancel(_timer);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.getCode.userInteractionEnabled = YES;
        [self.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getCode setBackgroundColor:RGBColor(250, 100, 100, 1)];
    });
    
}

#pragma mark - UITextField Delegate
- (void)changeText{
    if (self.mobileInput) {
        if (self.mobileInput.text.length == 11) {
            self.getCode.userInteractionEnabled = YES;
            [self.getCode setBackgroundColor:RGBColor(250, 100, 100, 1)];
        }else if(self.mobileInput.text.length != 11){
            self.getCode.userInteractionEnabled = NO;
            [self.getCode setBackgroundColor:RGBColor(216, 216, 216, 1)];
        }
    }
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
