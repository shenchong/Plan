//
//  WebAPIClient.h
//  Planist
//
//  Created by easemob on 16/10/11.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebAPIClient : NSObject
//get方法
+ (void)getJSONWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(id result))success fail:(void (^)(NSError *error))fail;
/// 4.post提交json数据
+ (void)postJSONWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(id result))success fail:(void (^)(NSError *error))fail;
@end
