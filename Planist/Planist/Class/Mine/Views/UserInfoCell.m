//
//  UserInfoCell.m
//  Planist
//
//  Created by easemob on 2016/11/21.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _topicLbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 11, 68, 19)];
        _topicLbl.textColor = [PublicMethod setColorWithHexString:@"#643232"];
        _topicLbl.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_topicLbl];
        
        if (indexPath.section == 1){
            if (indexPath.row == 0) {
                _boyBtn = [[UIButton alloc]initWithFrame:CGRectMake(106, 12, 20, 20)];
                [_boyBtn setBackgroundImage:[UIImage imageNamed:@"中"] forState:UIControlStateSelected];
                [_boyBtn setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
                [_boyBtn addTarget:self action:@selector(boyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//                NSLog(@"_boyBtn===%@",_boyBtn);
                [self.contentView addSubview:_boyBtn];
                
                _boyLbl = [[UILabel alloc]initWithFrame:CGRectMake(141, 11, 23, 19)];
                _boyLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
                _boyLbl.text = @"男";
                _boyLbl.font = [UIFont systemFontOfSize:16];
                [self.contentView addSubview:_boyLbl];
                
                _girlBtn = [[UIButton alloc]initWithFrame:CGRectMake(215, 12, 20, 20)];
                [_girlBtn setBackgroundImage:[UIImage imageNamed:@"中"] forState:UIControlStateSelected];
                [_girlBtn setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
                [_girlBtn addTarget:self action:@selector(girlBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_girlBtn];
                
                _girlLbl = [[UILabel alloc]initWithFrame:CGRectMake(250, 11, 23, 19)];
                _girlLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
                _girlLbl.text = @"女";
                _girlLbl.font = [UIFont systemFontOfSize:16];
                [self.contentView addSubview:_girlLbl];
            }else if (indexPath.row == 1){
                _birthLbl = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, 150, 19)];
                _birthLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
                _birthLbl.font = [UIFont systemFontOfSize:16];
                [_birthLbl sizeToFit];
                [self.contentView addSubview:_birthLbl];
                self.accessoryView = self.accessoryImgV;
            }
        }else if (indexPath.section == 2){
            _phoneLbl = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, 125, 19)];
            _phoneLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
            _phoneLbl.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:_phoneLbl];
        }else if (indexPath.section == 3){
            self.accessoryView = self.accessoryImgV;
            if (indexPath.row == 1) {
                _areaLbl = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, 150, 19)];
                _areaLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
                _areaLbl.font = [UIFont systemFontOfSize:16];
                [self.contentView addSubview:_areaLbl];
            }else if (indexPath.row == 2){
                _addressLbl = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, 200, 19)];
                _addressLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
                _addressLbl.font = [UIFont systemFontOfSize:16];
                [self.contentView addSubview:_addressLbl];
            }
        }
    }
    return self;
}

- (void)setUserInfoModel:(UserInfoModel *)userInfoModel{
    _userInfoModel = userInfoModel;
    
    _birthLbl.text = userInfoModel.birthday;
    _areaLbl.text = userInfoModel.domicile;
}

- (void)boyBtnClick:(UIButton *)boyBtn{
//    NSLog(@"boyBtn===%@",boyBtn);
    if ([_delegate respondsToSelector:@selector(boyBtnSelected:girlBtn:)]) {
        [_delegate boyBtnSelected:boyBtn girlBtn:_girlBtn];
    }
}

- (void)girlBtnClick:(UIButton *)girlBtn{
    if ([_delegate respondsToSelector:@selector(girlBtnSelected:boyBtn:)]) {
        [_delegate girlBtnSelected:girlBtn boyBtn:_boyBtn];
    }
}

- (UIImageView *)accessoryImgV{
    if (!_accessoryImgV) {
        _accessoryImgV = [[UIImageView alloc] init];
        _accessoryImgV.image = [UIImage imageNamed:@"箭头"];
        [_accessoryImgV sizeToFit];
    }
    return _accessoryImgV;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
