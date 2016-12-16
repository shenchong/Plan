//
//  UserInfoCell.h
//  Planist
//
//  Created by easemob on 2016/11/21.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@protocol UserInfoCellDelegate;

@interface UserInfoCell : UITableViewCell
@property (weak, nonatomic) id<UserInfoCellDelegate> delegate;
@property (nonatomic, strong) UserInfoModel *userInfoModel;
@property (nonatomic, strong) UILabel *topicLbl;
@property (nonatomic, strong) UIButton *boyBtn;
@property (nonatomic, strong) UILabel *boyLbl;
@property (nonatomic, strong) UIButton *girlBtn;
@property (nonatomic, strong) UILabel *girlLbl;
@property (nonatomic, strong) UILabel *birthLbl;
@property (nonatomic, strong) UILabel *phoneLbl;
@property (nonatomic, strong) UILabel *areaLbl;
@property (nonatomic, strong) UILabel *addressLbl;
@property (nonatomic, strong) UIImageView *accessoryImgV;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;
@end

@protocol UserInfoCellDelegate <NSObject>

@optional

- (void)boyBtnSelected:(UIButton *)boyBtn girlBtn:(UIButton *)girlBtn;
- (void)girlBtnSelected:(UIButton *)girlBtn boyBtn:(UIButton *)boyBtn;

@end