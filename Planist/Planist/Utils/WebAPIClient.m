//
//  WebAPIClient.m
//  Planist
//
//  Created by easemob on 16/10/11.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "WebAPIClient.h"

@implementation WebAPIClient

+ (void)getJSONWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(id))success fail:(void (^)(NSError *))fail{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [session GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)postJSONWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(id))success fail:(void (^)(NSError *))fail{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];

    [session POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

@end
