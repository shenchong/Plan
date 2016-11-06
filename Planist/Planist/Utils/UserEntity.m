//
//  UserEntity.m
//  Planist
//
//  Created by easemob on 16/10/13.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

+(void)SaveCurrentAccount:(AccountSignResult *)account
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *accountPath = [path stringByAppendingString:@"/Account.data"];
    [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
}

+ (AccountSignResult*)GetCurrentAccount
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *accountPath = [path stringByAppendingString:@"/Account.data"];
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
}

+(void)removeCurrentAccount
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *rootPath = [path stringByAppendingString:@"/Account.data"];
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:rootPath])
    {
        [manger removeItemAtPath:rootPath error:nil];
    }
}

@end
