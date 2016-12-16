//
//  AddressModel.h
//  Planist
//
//  Created by easemob on 2016/12/10.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property (nonatomic, assign) NSInteger addressId;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) NSInteger createDate;
@end

//{"obj":{"addresslist":[{"addressId":1,"uuid":null,"contact":"曹轲","contactPhone":"18155307625","area":"北京市昌平区","street":"回龙观","detail":"新龙城小区","createDate":1476460800000},{"id":2,"uuid":null,"contact":"曹轲","contactPhone":"18155307625","area":"北京市大兴区","street":"金苑路","detail":"软微学院","createDate":1476460800000}],"pretermissionaddress":2},"msg":"设置成功","success":true}
