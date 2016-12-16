//
//  AddressListCell.h
//  Planist
//
//  Created by easemob on 2016/12/10.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@class AddressListCell;
@protocol AddressListCellDelegate;
@interface AddressListCell : UITableViewCell
@property (nonatomic, weak) id<AddressListCellDelegate> delegate;

@property (nonatomic, strong) AddressModel *addressModel;

@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *phoneLbl;
@property (nonatomic, strong) UILabel *addressLbl;
@property (nonatomic, strong) UIImageView *editImg;
@property (nonatomic, strong) UILabel *defaultLal;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@protocol AddressListCellDelegate <NSObject>

@optional

- (void)editAddress:(AddressListCell *)cell;

@end
