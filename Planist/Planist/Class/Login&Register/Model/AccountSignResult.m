//
//  AccountSignResult.m
//  Planist
//
//  Created by easemob on 16/10/13.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "AccountSignResult.h"

@implementation AccountSignResult
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.obj forKey:@"obj"];
    [aCoder encodeObject:self.msg forKey:@"msg"];
//    [encoder encodeObject:self.encrypttext forKey:@"encrypttext"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeBool:self.success forKey:@"success"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _obj = [aDecoder decodeObjectForKey:@"obj"];
        _msg = [aDecoder decodeObjectForKey:@"msg"];
//        self.encrypttext = [aDecoder decodeObjectForKey:@"encrypttext"];
        _phone = [aDecoder decodeObjectForKey:@"phone"];
        _success = [aDecoder decodeBoolForKey:@"success"];
    }
    return self;
}

//- (NSString *)msg{
//    if (!_msg) {
//        _msg = [[NSString alloc]init];
//    }
//    return _msg;
//}

@end
