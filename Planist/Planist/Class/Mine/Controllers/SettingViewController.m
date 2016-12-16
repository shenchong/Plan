//
//  SettingViewController.m
//  Planist
//
//  Created by easemob on 2016/12/6.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"
#import "UserEntity.h"
#import "AccountSignResult.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *topicArray;
@property (nonatomic, strong) UILabel *cacheLbl;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _topicArray = @[@[@"消息推送设置",@"检查更新",@"清除缓存"],@[@"退出登录",@"关于两人游"]];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [PublicMethod setColorWithHexString:@"#F0F0F0"];
        
    }
    return _tableView;
}

- (UILabel *)cacheLbl{
    if (!_cacheLbl) {
        _cacheLbl = [[UILabel alloc]init];
        _cacheLbl.font = SCFont(14);
        _cacheLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
    }
    return _cacheLbl;
}
#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return self.topicArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.topicArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        UIImageView *accessoryView = [[UIImageView alloc] init];
        accessoryView.image = [UIImage imageNamed:@"箭头"];
        [accessoryView sizeToFit];
        cell.accessoryView = accessoryView;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [PublicMethod setColorWithHexString:@"#643232" alpha:1.0];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    cell.textLabel.text = _topicArray[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            cell.accessoryView = nil;
        }
        if (indexPath.row == 2) {
            self.cacheLbl.frame = CGRectMake(kScreenWidth-40-15, 14, 40, 17);
            self.cacheLbl.text = @"10MB";
            cell.accessoryView = self.cacheLbl;
        }
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.accessoryView = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        AboutViewController *aboutVC = [[AboutViewController alloc]init];
        aboutVC.title = @"关于两人游";
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        [UserEntity removeCurrentAccount];
        NSLog(@"已退出登录");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

@end
