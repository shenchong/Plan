//
//  AccountSignResult.h
//  Planist
//
//  Created by easemob on 16/10/13.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjctResult.h"

@interface AccountSignResult : NSObject<NSCoding>

@property (nonatomic, strong) ObjctResult *obj;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, assign) BOOL success;
//@property (nonatomic, strong) NSString *encrypttext;

@property (nonatomic, strong) NSString *phone;

@end
