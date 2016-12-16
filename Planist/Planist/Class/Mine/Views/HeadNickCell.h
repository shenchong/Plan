//
//  HeadNickCell.h
//  Planist
//
//  Created by easemob on 2016/11/20.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@protocol HeadNickCellDelegate;

@interface HeadNickCell : UITableViewCell
@property (nonatomic, weak) id<HeadNickCellDelegate> delegate;

@property (nonatomic, strong) UserInfoModel *userInfoModel;

@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *userNameLbl;
@end

@protocol HeadNickCellDelegate <NSObject>

@optional

- (void)headImageClick:(UIImageView *)headImage;

@end