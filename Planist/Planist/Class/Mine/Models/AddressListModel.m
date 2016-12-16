//
//  AddressListModel.m
//  Planist
//
//  Created by easemob on 2016/12/10.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "AddressListModel.h"

@implementation AddressListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"addresslist" : [AddressModel class]};
}
@end
