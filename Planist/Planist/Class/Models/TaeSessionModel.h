//
//  TaeSessionModel.h
//  Planist
//
//  Created by easemob on 16/11/16.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaeSessionModel : NSObject
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *authorizationCode;
@property (nonatomic, strong) NSString *topAccessToken;
@property (nonatomic, strong) NSString *sessionId;
@end
