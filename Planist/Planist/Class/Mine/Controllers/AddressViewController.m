//
//  AddressViewController.m
//  Planist
//
//  Created by easemob on 2016/12/7.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "AddressViewController.h"
#import "AccountSignResult.h"
#import "UserEntity.h"
#import "AddressModel.h"
#import "AddressListModel.h"
#import "AddressListCell.h"
#import "EditAddressViewController.h"

@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource,AddressListCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ObjctResult *account;
@property (nonatomic, strong) AddressModel *addressModel;
@property (nonatomic, strong) AddressListModel *addListModel;
@property (nonatomic, strong) NSMutableArray *addressList;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 3; ++i) {
        AddressModel *addressModel = [[AddressModel alloc]init];
        addressModel.addressId = i;
        addressModel.uuid = nil;
        addressModel.contact = @"两人游";
        addressModel.contactPhone = @"18510598187";
        addressModel.area = @"北京市昌平区";
        addressModel.street = @"回龙观";
        addressModel.detail = @"新龙城27号楼1单元502室";
        addressModel.createDate = i*1000;
        [self.addressList addObject:addressModel];
    }
    
    ObjctResult *account = [UserEntity GetCurrentAccount];
    self.account = account;
    
    [self initViews];
    
//    [self getAddressList];
}

#pragma mark - UI
- (void)initViews{
    [self.view addSubview:self.tableView];
    
    UIButton *addAddress = [[UIButton alloc]initWithFrame:CGRectMake(15, kScreenHeight-50-15, kScreenWidth-15*2, 50)];
    [addAddress setBackgroundImage:[UIImage imageNamed:@"建地址"] forState:UIControlStateNormal];
    [addAddress addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAddress];
}

- (NSMutableArray *)addressList{
    if (!_addressList) {
        _addressList = [NSMutableArray array];
    }
    return _addressList;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height-50-15) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.backgroundColor = [PublicMethod setColorWithHexString:@"#F0F0F0"];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AddressListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.addressModel = self.addressList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (_addListModel.pretermissionaddress == [_addressList[indexPath.row] addressId]) {
            [MBProgressHUD showTextHUDAddedTo:self.view withText:@"默认地址不可删除" detailText:nil andHideAfterDelay:0.7];
        }else{
            [self deleteAddress:indexPath];
        }
    }
}

#pragma mark - private
//删除地址
- (void)deleteAddress:(NSIndexPath *)indexPath{
    
    AddressModel *addressModel = self.addressList[indexPath.row];
    
//    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/addressController/%@/deleteAddress?token=%@&id=%ld",API_HOST_Test,_account.userinfo.phone,_account.token,(long)addressModel.addressId];
//    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    
//    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dic);
        [self.addressList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        
//    } fail:^(NSError *error) {
//        NSLog(@"error=%@",error);
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
}


- (void)editAddress:(AddressListCell *)cell{
    EditAddressViewController *editAddressVC = [[EditAddressViewController alloc]init];
    editAddressVC.addressModel = cell.addressModel;
    editAddressVC.title = @"地址编辑";
    [self.navigationController pushViewController:editAddressVC animated:YES];
}


- (void)addAddress{
    EditAddressViewController *editAddressVC = [[EditAddressViewController alloc]init];
    editAddressVC.title = @"新增地址";
    if (_addressList.count == 0) {
        
    }
    [self.navigationController pushViewController:editAddressVC animated:YES];
}

//获取地址列表
- (void)getAddressList{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/addressController/%@/getAddressList?token=%@",API_HOST_Test,_account.userinfo.phone,_account.token];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        AddressListModel *addListModel = [AddressListModel mj_objectWithKeyValues:[dic objectForKey:@"obj"]];
        _addListModel = addListModel;
        NSLog(@"addListModel--%@",addListModel);
        
        for (AddressModel *addressModel in addListModel.addresslist) {
            if (addListModel.pretermissionaddress == addressModel.addressId) {
                [self.addressList insertObject:addressModel atIndex:0];
            }else{
                [self.addressList addObject:addressModel];
            }
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [self.tableView reloadData];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
