//
//  ObjctResult.h
//  Planist
//
//  Created by easemob on 16/10/13.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface ObjctResult : NSObject<NSCoding>

@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) BOOL isNew;
@property (nonatomic, strong) NSString *encrypttext;
@property (nonatomic, strong) NSString *bitmap;
@property (nonatomic, assign) NSInteger addressId;
@property (nonatomic, strong) UserInfoModel *userinfo;

@end

