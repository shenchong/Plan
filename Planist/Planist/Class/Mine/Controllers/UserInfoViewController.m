//
//  UserInfoViewController.m
//  Planist
//
//  Created by easemob on 16/11/2.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "UserInfoViewController.h"
#import "HeadNickCell.h"
#import "UserInfoCell.h"
#import "AccountSignResult.h"
#import "UserEntity.h"
#import "STPickerDate.h"
#import "STPickerArea.h"
#import "AddressViewController.h"

@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UserInfoCellDelegate,HeadNickCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,STPickerDateDelegate,STPickerAreaDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *topicArray;
@property (nonatomic, strong) ObjctResult *account;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *birthLbl;
@property (nonatomic, strong) UILabel *areaLbl;
@end

@implementation UserInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的资料";
    _topicArray = @[@[@"昵称"],@[@"性别",@"生日"],@[@"绑定手机"],@[@"兴趣标签",@"常驻城市",@"收货地址"]];
    ObjctResult *account = [UserEntity GetCurrentAccount];
    self.account = account;
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [PublicMethod setColorWithHexString:@"#F0F0F0"];
//        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UIImagePickerController *)imagePicker{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.allowsEditing = NO;
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return _topicArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *headNickCellID = @"headNickCell";
        
        HeadNickCell *headNickCell = [tableView dequeueReusableCellWithIdentifier:headNickCellID];
        if (!headNickCell) {
            headNickCell = [[HeadNickCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headNickCellID];
        }
        headNickCell.selectionStyle = UITableViewCellSelectionStyleNone;
        headNickCell.delegate = self;
//        userInfoModel.picture = @"微博图标 + 微博圈";
//        userInfoModel.username = @"两人游";
        headNickCell.userInfoModel = self.account.userinfo;
        return headNickCell;
    }
    
    static NSString *ID = @"userInfoCell";
    
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID indexPath:indexPath];
    }
    cell.topicLbl.text = _topicArray[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.boyBtn.selected = YES;
        }else if (indexPath.row == 1){
            _birthLbl = cell.birthLbl;
//            cell.birthLbl.text = @"1993-10-12";
            cell.userInfoModel = self.account.userinfo;
            [cell.birthLbl sizeToFit];
        }
    }else if (indexPath.section == 2){
        cell.phoneLbl.text = self.account.userinfo.phone;
    }else if (indexPath.section == 3){
        if (indexPath.row == 1) {
            cell.areaLbl.hidden = NO;
            _areaLbl = cell.areaLbl;
//            cell.areaLbl.text = @"北京";
            cell.userInfoModel = self.account.userinfo;
        }else if (indexPath.row == 2){
//            cell.addressLbl.hidden = NO;
//            cell.addressLbl.text = @"昌平区新龙城27-1-502";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            STPickerDate *pickerDate = [[STPickerDate alloc]init];
            [pickerDate setDelegate:self];
            [pickerDate show];
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 1) {
            STPickerArea *pickerArea = [[STPickerArea alloc]init];
            [pickerArea setDelegate:self];
            [pickerArea show];
        }
        if (indexPath.row == 2) {
            AddressViewController *addressVC = [[AddressViewController alloc]init];
            addressVC.title =@"收货地址";
            [self.navigationController pushViewController:addressVC animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)pickerImageChannel
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"上传照片" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //UIImagePickerControllerSourceTypePhotoLibrary
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"去拍美照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BOOL isCameraAvailabel = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        if (!isCameraAvailabel) {
            [MBProgressHUD showTextHUDAddedTo:self.view withText:@"没有权限" detailText:nil andHideAfterDelay:0.7];
            return;
        }
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//设置头像
- (void)setImageWithImage:(UIImage *)image{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?token=%@",API_UpdateHeader(_account.userinfo.phone),_account.token];
    NSString *urlStr = [urlStrTemp stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WebAPIClient postHeaderWithUrl:urlStr parameters:nil image:image success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        BOOL success = [dic objectForKey:@"success"];
        if (success) {
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            NSString *imageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            self.account.userinfo.picture = imageStr;
            [UserEntity SaveCurrentAccount:self.account];
            [self.tableView reloadData];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

//设置生日
- (void)setBirthday:(NSString *)dateStr{
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?token=%@&birthday=%@",API_SetBirthday(_account.userinfo.phone),_account.token,dateStr];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        BOOL success = [dic objectForKey:@"success"];
        if (success) {
            self.account.userinfo.birthday = dateStr;
            _birthLbl.text = dateStr;
            [UserEntity SaveCurrentAccount:self.account];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
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

//设置常驻地址?中文地址处理
- (void)setDomicile:(NSString *)city{
    //    NSString *urlStrTemp = [NSString stringWithFormat:@"%@/userController/%@/setDomicile?token=%@&domicile=beijing",API_HOST_Test,_account.phone,_account.obj.token];
    NSString *urlStrTemp = [NSString stringWithFormat:@"%@?token=%@&domicile=%@",API_SetDomicile(_account.userinfo.phone),_account.token,city];

//    NSData *data = [urlStrTemp dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *urlStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *urlStr = [urlStrTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WebAPIClient getJSONWithUrl:urlStr parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        BOOL success = [dic objectForKey:@"success"];
        if (success) {
            self.account.userinfo.domicile = city;
            _areaLbl.text = city;
            [UserEntity SaveCurrentAccount:self.account];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } fail:^(NSError *error) {
        NSLog(@"error=%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark - imagepickerCtrl delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{

    UIImageView *imgVT = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, 300)];
    imgVT.image = image;
    [self.view addSubview:imgVT];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self setImageWithImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - STPickerDateDelegate
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%zd.%zd.%zd", year, month, day];
    [self setBirthday:text];
}

#pragma mark - STPickerAreaDelegate
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@", city];
    [self setDomicile:city];
}
#pragma mark - UserInfoCellDelegate
- (void)boyBtnSelected:(UIButton *)boyBtn girlBtn:(UIButton *)girlBtn{
    if (!boyBtn.selected) {
        boyBtn.selected = YES;
        girlBtn.selected = NO;
    }
}

- (void)girlBtnSelected:(UIButton *)girlBtn boyBtn:(UIButton *)boyBtn{
    if (!girlBtn.selected) {
        girlBtn.selected = YES;
        boyBtn.selected = NO;
    }
}
#pragma mark - HeadNickCellDelegate
- (void)headImageClick:(UIImageView *)headImage{
    [self pickerImageChannel];
}

@end
