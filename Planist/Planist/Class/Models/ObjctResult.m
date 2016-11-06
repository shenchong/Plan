//
//  ObjctResult.m
//  Planist
//
//  Created by easemob on 16/10/13.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "ObjctResult.h"

@implementation ObjctResult

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.encrypttext forKey:@"encrypttext"];
    [aCoder encodeObject:self.bitmap forKey:@"bitmap"];
    [aCoder encodeBool:self.isNew forKey:@"isNew"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _token = [aDecoder decodeObjectForKey:@"token"];
        _encrypttext = [aDecoder decodeObjectForKey:@"encrypttext"];
        _bitmap = [aDecoder decodeObjectForKey:@"bitmap"];
        _isNew = [aDecoder decodeBoolForKey:@"isNew"];
    }
    return self;
}

@end
