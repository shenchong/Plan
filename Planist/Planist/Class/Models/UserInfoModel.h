//
//  UserInfoModel.h
//  Planist
//
//  Created by 沈冲 on 16/11/8.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, strong) NSString *agegroup;//年龄
@property (nonatomic, strong) NSString *birthday;//生日
@property (nonatomic, assign) NSInteger createdate;//创建时间
@property (nonatomic, strong) NSString *domicile;//常住地
@property (nonatomic, assign) NSInteger integration;
@property (nonatomic, strong) NSString *interest;//兴趣
@property (nonatomic, strong) NSString *introduction;//签名
@property (nonatomic, strong) NSString *picture;//头像
@property (nonatomic, strong) NSString *sex;//性别
@property (nonatomic, strong) NSString *username;//昵称
@property (nonatomic, strong) NSString *phone;

@end
//{obj :{token:xxx,userinfo:{picture:xxx,domicile:xxx,birthday:xxx,sex:xxx,username:xxx,interest:xxx,integration:xxx,agegroup:xxx,createdate:xxx,introduction:xxx}}}
