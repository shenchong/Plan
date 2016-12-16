//
//  UserEntity.h
//  Planist
//
//  Created by easemob on 16/10/13.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountSignResult.h"
#import "TaeSessionModel.h"
#import "ObjctResult.h"

@interface UserEntity : NSObject
+ (void)SaveCurrentAccount:(ObjctResult *)account;
+ (ObjctResult*)GetCurrentAccount;
+(void)removeCurrentAccount;

+ (void)SaveTaeSession:(TaeSessionModel *)account;
+ (TaeSessionModel*)GetTaeSession;
+(void)removeTaeSession;
@end
