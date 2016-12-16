//
//  AddressListCell.m
//  Planist
//
//  Created by easemob on 2016/12/10.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "AddressListCell.h"

@implementation AddressListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 70, 19)];
        self.nameLbl = nameLbl;
        nameLbl.font = SCFont(16);
        nameLbl.textAlignment = NSTextAlignmentLeft;
        nameLbl.textColor = [PublicMethod setColorWithHexString:@"#030303"];
        [self.contentView addSubview:nameLbl];
        
        UILabel *phoneLbl = [[UILabel alloc]initWithFrame:CGRectMake(130, 20, 95, 19)];
        self.phoneLbl = phoneLbl;
        phoneLbl.font = SCFont(16);
        phoneLbl.textAlignment = NSTextAlignmentLeft;
        phoneLbl.textColor = [PublicMethod setColorWithHexString:@"#030303"];
        [self.contentView addSubview:phoneLbl];
        
        UILabel *addressLbl = [[UILabel alloc]initWithFrame:CGRectMake(130, 52, 190, 28)];
        self.addressLbl = addressLbl;
        addressLbl.numberOfLines = 2;
        addressLbl.font = SCFont(12);
        addressLbl.lineBreakMode = NSLineBreakByWordWrapping;
        addressLbl.textColor = [PublicMethod setColorWithHexString:@"#979797"];
        [self.contentView addSubview:addressLbl];
        
        UIImageView *editImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-52, 0, 52, 100)];
        editImg.image = [UIImage imageNamed:@"辑icon"];
        editImg.userInteractionEnabled = YES;
        self.editImg = editImg;
        [self.contentView addSubview:editImg];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editImgTapAction:)];
        [editImg addGestureRecognizer:tapRecognizer];
        
        UIImageView *isDefault = [[UIImageView alloc]initWithFrame:CGRectMake(22, 51, 34, 18)];
        isDefault.image = [UIImage imageNamed:@"认符号"];
        isDefault.hidden = YES;
        [self.contentView addSubview:isDefault];
    }
    return self;
}

- (void)setAddressModel:(AddressModel *)addressModel{
    _addressModel = addressModel;
    _nameLbl.text = addressModel.contact;
    _phoneLbl.text = addressModel.contactPhone;
    [_phoneLbl sizeToFit];
    _addressLbl.text = [NSString stringWithFormat:@"%@%@%@",addressModel.area,addressModel.street,addressModel.detail];
    [_addressLbl sizeToFit];
}

- (void)editImgTapAction:(UITapGestureRecognizer *)tap{
    if ([_delegate respondsToSelector:@selector(editAddress:)]) {
        [_delegate editAddress:self];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
