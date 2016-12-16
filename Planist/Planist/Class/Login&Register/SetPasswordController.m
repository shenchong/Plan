//
//  SetPasswordController.m
//  Planist
//
//  Created by easemob on 16/10/13.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "SetPasswordController.h"
#import "UserEntity.h"
#import "AccountSignResult.h"

@interface SetPasswordController ()
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;
@property (weak, nonatomic) IBOutlet UITextField *passwordInputRe;
@property (weak, nonatomic) IBOutlet UITextField *idImgCode;
@property (weak, nonatomic) IBOutlet UIImageView *idCodeImage;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UIButton *setNewPassword;
@end

@implementation SetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
    [self getIdCodeImage];
}

- (void)setupViews{
    [self.dismissBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.dismissBtn.adjustsImageWhenHighlighted = NO;
    
    self.setNewPassword.layer.cornerRadius = 6;
    self.setNewPassword.layer.masksToBounds = YES;
    self.setNewPassword.backgroundColor = RGBColor(250, 100, 100, 1);
    self.setNewPassword.adjustsImageWhenHighlighted = NO;
    [self.setNewPassword addTarget:self action:@selector(setNewPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.refreshBtn addTarget:self action:@selector(refreshIDCodeImg) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getIdCodeImage{
    [WebAPIClient getJSONWithUrl:API_Account_GetCaptchaImg parameters:nil success:^(id result) {

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        if (dic) {
            ObjctResult *account = [UserEntity GetCurrentAccount];
            AccountSignResult *accountResult = [AccountSignResult mj_objectWithKeyValues:dic];
            NSData *data = [[NSData alloc]initWithBase64EncodedString:accountResult.obj.bitmap options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *image = [[UIImage alloc]initWithData:data];
            self.idCodeImage.image = image;
            account.bitmap = accountResult.obj.bitmap;
            account.encrypttext = accountResult.obj.encrypttext;
            [UserEntity SaveCurrentAccount:account];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setNewPasswordAction{
    
    if ([self.passwordInput.text isEqualToString:self.passwordInputRe.text]&&self.idImgCode.text.length > 0) {
        
        ObjctResult *account = [UserEntity GetCurrentAccount];
        NSString *token = account.token;
        NSString *encrypttext = account.encrypttext;
        
        NSString *urlStrTemp = [NSString stringWithFormat:@"%@?phone=%@&token=%@&password=%@&encryptText=%@&inputText=%@",API_Account_SetPassword,account.userinfo.phone,token,self.passwordInput.text,encrypttext,self.idImgCode.text];
        NSString *urlStr = [urlStrTemp stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [WebAPIClient postJSONWithUrl:urlStr parameters:nil success:^(id result) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            
            AccountSignResult *sign = [AccountSignResult mj_objectWithKeyValues:dic];
            
            NSLog(@"msg == %@",[dic objectForKey:@"msg"]);
            
            if (sign.success) {
                [MBProgressHUD showTextHUDAddedTo:self.view withText:@"设置密码成功" detailText:nil andHideAfterDelay:1];
                [self performSelector:@selector(settedPassword) withObject:nil afterDelay:1];
            }else{
                [MBProgressHUD showTextHUDAddedTo:self.view withText:[dic objectForKey:@"msg"] detailText:nil andHideAfterDelay:1];
            }
            
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)refreshIDCodeImg{
    [self getIdCodeImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)settedPassword{
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
