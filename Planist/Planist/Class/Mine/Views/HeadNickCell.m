//
//  HeadNickCell.m
//  Planist
//
//  Created by easemob on 2016/11/20.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "HeadNickCell.h"

@implementation HeadNickCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
        _headImage = headImage;
        _headImage.backgroundColor = [PublicMethod setColorWithHexString:@"#000000" alpha:0.1];
        _headImage.layer.cornerRadius = _headImage.width/2;
        _headImage.clipsToBounds = YES;
        _headImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageTapAction:)];
        [_headImage addGestureRecognizer:tapRecognizer];
        [self.contentView addSubview:_headImage];
        
        UILabel *userNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(140, 50, 140, 18)];
        _userNameLbl = userNameLbl;
        [self.contentView addSubview:_userNameLbl];
        
    }
    return self;
}

- (void)setUserInfoModel:(UserInfoModel *)userInfoModel{
    _userInfoModel = userInfoModel;
    if (userInfoModel.picture) {
        NSData *data = [[NSData alloc]initWithBase64EncodedString:userInfoModel.picture options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image = [[UIImage alloc]initWithData:data];
        _headImage.image = image;
    }
    _userNameLbl.text = _userInfoModel.username;
}

- (void)headImageTapAction:(UITapGestureRecognizer *)tapRecognizer{
    if ([_delegate respondsToSelector:@selector(headImageClick:)]) {
        [_delegate headImageClick:_headImage];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
