//
//  MineViewController.m
//  Planist
//
//  Created by easemob on 16/9/20.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "MineViewController.h"
#import "UIScrollView+Header.h"
#import "MineViewCell.h"
#import "LoginViewController.h"
#import "BindMobileController.h"
#import "SetPasswordController.h"
#import "UserEntity.h"
#import "UserInfoViewController.h"
#import "SettingViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *naviBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) ObjctResult *account;

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UIButton *nickName;
@property (nonatomic, strong) UIButton *youTicket;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    ObjctResult *account = [UserEntity GetCurrentAccount];
    self.account = account;
    if (account.token.length) {
        self.isLogin = YES;
    }else{
        self.isLogin = NO;
    }
    [self updateViews];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
    
    _dataArray = @[@[@"我的订单",@"我的收藏"],@[@"客服"]];
    
    [self setViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)naviBar{
    if (_naviBar == nil) {
        _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _naviBar.backgroundColor = RGBColor(250, 250, 250,0.05);
        _naviBar.alpha = 0.05;
    }
    return _naviBar;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(250, 100, 100, 0.08);
        
        // 设置tableView头部缩放图片
        _tableView.sc_headerScaleImage = [UIImage imageNamed:@"Rectangle"];
        _tableView.sc_headerScaleImageHeight = 260;
        // 设置tableView头部视图，必须设置头部视图背景颜色为clearColor,否则会被挡住
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 260)];
        headerView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

- (void)updateViews{
    if (_isLogin) {
        if (_account.userinfo.picture) {
            NSData *data = [[NSData alloc]initWithBase64EncodedString:_account.userinfo.picture options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *image = [[UIImage alloc]initWithData:data];
            _headImage.image = image;
        }
        [_nickName setTitle:_account.userinfo.phone forState:UIControlStateNormal];
    }else{
        _headImage.image = nil;
        [_nickName setTitle:@"立即登录" forState:UIControlStateNormal];
    }
}

- (void)setViews{
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.naviBar];
    
    _headImage = [[UIImageView alloc] init];
    _headImage.width = 80;
    _headImage.height = 80;
    _headImage.x = (kScreenWidth - _headImage.width)/2;
    _headImage.y = 92;
    _headImage.backgroundColor = RGBColor(0, 0, 0, 0.10);
    _headImage.layer.cornerRadius = 40.0;
    _headImage.clipsToBounds = YES;
    _headImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nickNameAndHeadImgClick)];
    [_headImage addGestureRecognizer:tapRecognizer];
    [self.tableView.tableHeaderView addSubview:_headImage];
    
    _nickName = [[UIButton alloc]init];
    _nickName.width = 80;
    _nickName.height = 15;
    _nickName.x = (kScreenWidth - _nickName.width)/2;
    _nickName.y = 184;
    _nickName.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
    [_nickName addTarget:self action:@selector(nickNameAndHeadImgClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView.tableHeaderView addSubview:_nickName];
    
    _youTicket = [[UIButton alloc]init];
    _youTicket.width = 80;
    _youTicket.height = 20;
    _youTicket.x = (kScreenWidth - _youTicket.width)/2;
    _youTicket.y = 206;
    _youTicket.backgroundColor = [PublicMethod setColorWithHexString:@"#000000" alpha:0.1];
    [_youTicket setImage:[UIImage imageNamed:@"票图标"] forState:UIControlStateNormal];
    [_youTicket setTitle:@"游票:xx" forState:UIControlStateNormal];
    _youTicket.titleLabel.font = SCFont(10);
    _youTicket.layer.cornerRadius = 11.5;
    _youTicket.layer.masksToBounds = YES;
    [_youTicket setImageEdgeInsets:UIEdgeInsetsMake(0.0, -8, 0.0, 0.0)];
    [self.tableView.tableHeaderView addSubview:_youTicket];
    
    _setBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-40, 27, 30, 30)];
    [_setBtn setBackgroundImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    _setBtn.adjustsImageWhenHighlighted = NO;
    [_setBtn addTarget:self action:@selector(settingVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_setBtn];
    [self.view bringSubviewToFront:_setBtn];
    
    _messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 27, 30, 30)];
    [_messageBtn setBackgroundImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    _messageBtn.adjustsImageWhenHighlighted = NO;
    [_messageBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_messageBtn];
    [self.view bringSubviewToFront:_messageBtn];
}

- (void)test{
//    [self addAddress];
}

- (void)nickNameAndHeadImgClick{
//    if (_isLogin) {
        [self userInfoList];
//    }else{
//        [self toLogin];
//    }
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MineViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        UIImageView *accessoryView = [[UIImageView alloc] init];
        accessoryView.image = [UIImage imageNamed:@"箭头"];
        [accessoryView sizeToFit];
        cell.accessoryView = accessoryView;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [PublicMethod setColorWithHexString:@"#643232" alpha:1.0];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_dataArray[indexPath.section][indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
            EaseMessageViewController *chatVC = [[EaseMessageViewController alloc]initWithConversationChatter:@"scceshi1" conversationType:EMConversationTypeChat];
            chatVC.hidesBottomBarWhenPushed = YES;
            chatVC.title = @"客服";
            [self.navigationController pushViewController:chatVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offSetY = scrollView.contentOffset.y;
//    if (offSetY<=0&&offSetY>=-40)  _naviBar.alpha = 0;
//    else if(offSetY <= 200) _naviBar.alpha = offSetY/200;
//    if (offSetY >= 200) {
//        _naviBar.alpha = 1.0;
//    }
    if (offSetY>=250-64) {
        _naviBar.alpha = 1.0;
    }else{
        _naviBar.alpha = 0.05;
    }
}

#pragma mark - private

- (void)userInfoList{
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc]init];
    userInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVC animated:YES];
}

- (void)settingVC{
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    settingVC.title = @"设置";
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)toLogin{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

//设置昵称
- (void)userInfo{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?token=%@&username=planist",API_SetUserName(_account.userinfo.phone),_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
//设置生日
- (void)setBirthday{
//    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/userController/%@/setBirthday?token=%@&birthday=1994.8.1",API_HOST_Test,_account.phone,_account.obj.token];
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?token=%@&birthday=1994.8.1",API_SetBirthday(_account.userinfo.phone),_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
//设置常驻地址?中文地址处理
- (void)setDomicile{
//    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/userController/%@/setDomicile?token=%@&domicile=beijing",API_HOST_Test,_account.phone,_account.obj.token];
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?token=%@&domicile=beijing",API_SetDomicile(_account.userinfo.phone),_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"domicile"]=@"北京昌平";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
//设置个人简介
- (void)setIntroduction{
//    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?token=%@&introduction=PlanistGo",API_SetIntroduction(_account.phone),_account.obj.token];
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/userController/%@/setIntroduction?token=%@&introduction=PlanistGo",API_HOST_Test,_account.userinfo.phone,_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
//获取用户信息
- (void)getUserInfoAll{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/userController/%@/getUserInfoAll?token=%@",API_HOST_Test,_account.userinfo.phone,_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

//添加地址?中文地址处理
- (void)addAddress{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/addressController/%@/addAddress?token=%@&contact=沈冲&contactPhone=18510598187&area=北京市昌平区&street=回龙观&detail=新龙城27号楼1单元502",API_HOST_Test,_account.userinfo.phone,_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
//获取地址列表
- (void)getAddressList{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/addressController/%@/getAddressList?token=%@",API_HOST_Test,_account.userinfo.phone,_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
//删除地址
- (void)deleteAddress{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/addressController/%@/deleteAddress?token=%@&id=4",API_HOST_Test,_account.userinfo.phone,_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

//设置默认地址
- (void)setPretermissionAddress{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/addressController/%@/setPretermissionAddress?token=%@&pretermissionAddress=4",API_HOST_Test,_account.userinfo.phone,_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

//设置头像
- (void)setImage{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/userController/%@/setImage?token=%@",API_HOST_Test,_account.userinfo.phone,_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    UIImage *image = [UIImage imageWithContentsOfFile:@"/Users/easemob/Desktop/移动办工/Planist/Planist/Planist/Resources/delete.png"];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient postHeaderWithUrl:urlStr parameters:nil image:image success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
}

//设置头像
- (void)setImageWithImage:(UIImage *)image{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/userController/%@/setImage?token=%@",API_HOST_Test,_account.userinfo.phone,_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient postHeaderWithUrl:urlStr parameters:nil image:image success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        _headImage.image = image;
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark - imagepickerCtrl delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self setImageWithImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
