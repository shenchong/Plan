//
//  AddressListModel.h
//  Planist
//
//  Created by easemob on 2016/12/10.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface AddressListModel : NSObject
@property (nonatomic, strong) NSArray *addresslist;
@property (nonatomic, assign) NSInteger pretermissionaddress;
@end
