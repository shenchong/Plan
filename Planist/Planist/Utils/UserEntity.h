//
//  UserEntity.h
//  Planist
//
//  Created by easemob on 16/10/13.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountSignResult.h"

@interface UserEntity : NSObject
+ (void)SaveCurrentAccount:(AccountSignResult *)account;
+ (AccountSignResult*)GetCurrentAccount;
+(void)removeCurrentAccount;
@end
