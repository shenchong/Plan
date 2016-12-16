//
//  EditAddressViewController.m
//  Planist
//
//  Created by easemob on 2016/12/10.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "EditAddressViewController.h"
#import "SCTextView.h"
#import "ObjctResult.h"
#import "UserEntity.h"

@interface EditAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *defaultBtn;
@property (nonatomic, assign) BOOL isDefault;

@property (nonatomic, strong) ObjctResult *account;

@property (nonatomic, strong) UITextField *contactTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *area;
@property (nonatomic, strong) SCTextView *detailText;
@end

@implementation EditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ObjctResult *account = [UserEntity GetCurrentAccount];
    self.account = account;
    
    [self setViews];
    
    
}

- (void)setViews{
    [self.view addSubview:self.tableView];
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 26, 17)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = SCFont(13);
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 31)];
    self.tableView.tableFooterView = footerView;
    
    UIButton *defaultBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, 115, 16)];
    _defaultBtn = defaultBtn;
    defaultBtn.centerX = footerView.centerX+10;
    [defaultBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
    [defaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    defaultBtn.titleLabel.font = SCFont(13);
    [defaultBtn setImage:[UIImage imageNamed:@"默认中"] forState:UIControlStateSelected];
    [defaultBtn setImage:[UIImage imageNamed:@"默认选中"] forState:UIControlStateNormal];
    [defaultBtn addTarget:self action:@selector(setDefault:) forControlEvents:UIControlEventTouchUpInside];
    defaultBtn.selected = NO;
    [defaultBtn sizeToFit];
    [footerView addSubview:defaultBtn];
    
}

- (void)saveBtnClick{
    if (_addressModel==nil) {
        [self addAddress];
    }else{
        
    }
}

//添加地址?中文地址处理
- (void)addAddress{
    BOOL whetherDefault;
    if (_defaultBtn.selected) {
        whetherDefault = YES;
    }else{
        whetherDefault = NO;
    }
    
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?token=%@&contact=%@&contactPhone=%@&area=%@&street=nil&detail=%@&whetherDefault=%d",API_AddAddress(_account.userinfo.phone),_account.token,self.contactTF.text,self.phoneTF.text,self.area.text,self.detailText.textView.text,whetherDefault];
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

- (void)setDefault:(UIButton *)sender{
    sender.selected = !sender.selected;
}

//设置默认地址   设置一个不存在的地址为默认地址，需要设置完地址后返回pretermissionAddress给我
- (void)setPretermissionAddress:(NSInteger)addressId{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/addressController/%@/setPretermissionAddress?token=%@&pretermissionAddress=%ld",API_HOST_Test,_account.userinfo.phone,_account.token,addressId];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [PublicMethod setColorWithHexString:@"#F0F0F0"];
    }
    return _tableView;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 3) {
        SCTextView *detailAddTF = [[SCTextView alloc]initWithFrame:CGRectMake(18, 15, kScreenWidth-40, 30)];
        detailAddTF.placeholder = @"详细地址，如街道、楼牌号";
        if (_addressModel.street.length!=0&&_addressModel.detail.length!=0) {
            detailAddTF.text = [NSString stringWithFormat:@"%@%@",_addressModel.street,_addressModel.detail];
        }
        detailAddTF.font = SCFont(15);
        self.detailText = detailAddTF;
        [cell.contentView addSubview:detailAddTF];
    }else{
        UITextField *contentTF = [[UITextField alloc]initWithFrame:CGRectMake(20, 15, kScreenWidth-40, 18)];
        contentTF.font = SCFont(15);
        [cell.contentView addSubview:contentTF];
    
        if (indexPath.row == 0) {
            contentTF.placeholder = @"姓名";
            contentTF.text = _addressModel.contact;
            self.contactTF = contentTF;
        }else if (indexPath.row == 1){
            contentTF.placeholder = @"联系手机";
            contentTF.text = _addressModel.contactPhone;
            self.phoneTF = contentTF;
        }else if (indexPath.row == 2){
            contentTF.placeholder = @"省份、城市、区县";
            contentTF.text = _addressModel.area;
            self.area = contentTF;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 50+15+15;
    }
    return 48;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
