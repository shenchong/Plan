//
//  BindMobileController.m
//  Planist
//
//  Created by 沈冲 on 16/10/5.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "BindMobileController.h"

@interface BindMobileController (){
    dispatch_source_t _timer;
}
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileInput;
@property (weak, nonatomic) IBOutlet UITextField *codeInput;
@property (weak, nonatomic) IBOutlet UIButton *getCode;
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;
@end

@implementation BindMobileController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
    
    //监听文本框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText) name:UITextFieldTextDidChangeNotification object:self.mobileInput];
}

- (void)setupViews{
    [self.dismissBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.dismissBtn.adjustsImageWhenHighlighted = NO;
    
    self.bindBtn.layer.cornerRadius = 6;
    self.bindBtn.layer.masksToBounds = YES;
    self.bindBtn.backgroundColor = RGBColor(250, 100, 100, 1);
    self.bindBtn.adjustsImageWhenHighlighted = NO;
    [self.bindBtn addTarget:self action:@selector(bindAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.getCode.layer.cornerRadius = 4;
    self.getCode.layer.masksToBounds = YES;
    [self.getCode setBackgroundColor:RGBColor(216, 216, 216, 1)];
    self.getCode.userInteractionEnabled = NO;
    [self.getCode addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bindAction{
    if (self.mobileInput.text.length == 11&&self.codeInput.text.length != 0) {
        
        NSString *phoneNumber = self.mobileInput.text;
        NSString *urlStrTemp = [NSString stringWithFormat:@"%@?phone=%@&passwordPhone=%@",API_Account_LoginByPhone,phoneNumber,self.codeInput.text];
        NSString *urlStr = [urlStrTemp stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
            //            NSLog(@"%@",result);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSString *msg = [dic objectForKey:@"msg"];
            [MBProgressHUD showTextHUDAddedTo:self.view withText:msg detailText:nil andHideAfterDelay:1];
            
        } fail:^(NSError *error) {
            
        }];
    }
    
    if (self.mobileInput.text.length != 11){
        [MBProgressHUD showTextHUDAddedTo:self.view withText:@"请输入正确手机号" detailText:nil andHideAfterDelay:1];
    }else if (self.mobileInput.text.length == 11){
        if (self.codeInput.text.length != 6) {
            [MBProgressHUD showTextHUDAddedTo:self.view withText:@"请输入验证码" detailText:nil andHideAfterDelay:1];
        }
    }
}

- (void)getCodeAction:(UIButton *)sender{
    [self startTime];
    
    NSString *phoneNumber = self.mobileInput.text;
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?%@",API_Account_GetCode,phoneNumber];
    NSString *urlStr = [urlStrTemp stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSLog(@"%@",result);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showTextHUDAddedTo:self.view withText:@"请输入验证码" detailText:nil andHideAfterDelay:1];
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
