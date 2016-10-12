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

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *naviBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    self.isLogin = NO;
    
    _dataArray = @[@[@"我的积分",@"收藏"],@[@"绑定手机"],@[@"联系客服"]];
    
    [self setViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)naviBar{
    if (_naviBar == nil) {
        _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _naviBar.backgroundColor = RGBColor(220, 89, 54,0.8);
        _naviBar.alpha = 0;
    }
    return _naviBar;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        // 设置tableView头部缩放图片
        _tableView.sc_headerScaleImage = [UIImage imageNamed:@"header.JPG"];
        _tableView.sc_headerScaleImageHeight = 250;
        // 设置tableView头部视图，必须设置头部视图背景颜色为clearColor,否则会被挡住
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 250)];
        headerView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

- (void)setViews{
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.naviBar];
    
    UIButton *headImage = [[UIButton alloc] init];
    headImage.width = 70;
    headImage.height = 70;
    headImage.x = (kScreenWidth - headImage.width)/2;
    headImage.y = (self.tableView.sc_headerScaleImageHeight-headImage.height)-80;
    headImage.backgroundColor = [UIColor grayColor];
    headImage.layer.cornerRadius = 35.0;
    [self.tableView.tableHeaderView addSubview:headImage];
    
    UIButton *nickName = [[UIButton alloc]init];
    nickName.width = 100;
    nickName.height = 20;
    nickName.x = (kScreenWidth - nickName.width)/2;
    nickName.y = CGRectGetMaxY(headImage.frame)+15;
    if (_isLogin) {
        [nickName setTitle:@"昵称" forState:UIControlStateNormal];
    }else{
        [nickName setTitle:@"立即登录" forState:UIControlStateNormal];
        [nickName addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    nickName.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.tableView.tableHeaderView addSubview:nickName];
    
    UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-40, 30, 20, 20)];
    setBtn.backgroundColor = [UIColor grayColor];
    setBtn.layer.cornerRadius = 10.0;
    [self.view addSubview:setBtn];
    [self.view bringSubviewToFront:setBtn];
    
    UIButton *messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 20, 20)];
    messageBtn.backgroundColor = [UIColor grayColor];
    messageBtn.layer.cornerRadius = 10.0;
    [self.view addSubview:messageBtn];
    [self.view bringSubviewToFront:messageBtn];
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1||section == 2){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MineViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.label.text = @"99";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        BindMobileController *bindMobileVC = [[BindMobileController alloc]init];
        [self presentViewController:bindMobileVC animated:YES completion:nil];
    }
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
        _naviBar.alpha = 0;
    }
}

#pragma mark - private
- (void)toLogin{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}











@end
