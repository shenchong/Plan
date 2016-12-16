//
//  WebAPIClient.m
//  Planist
//
//  Created by easemob on 16/10/11.
//  Copyright © 2016年 沈冲. All rights reserved.
//url	__NSCFString *	@"http://192.168.0.109:8080/Planist/userController/18510598187/setDomicile?token=cebbeedf23d55ce7cbdac8edb4afc095&domicile=%E9%80%9A%E5%B7%9E"	0x0000608001268dc0

#import "WebAPIClient.h"

@implementation WebAPIClient

+ (void)getJSONWithUrl:(NSString *)url parameters:(id)parameters success:(void (^)(id))success fail:(void (^)(NSError *))fail{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", @"image/jpeg", nil];
//    [session.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
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
//     [session.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8" forHTTPHeaderField:@"Content-Type"];
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

+ (void)postHeaderWithUrl:(NSString *)url parameters:(id)parameters image:(UIImage *)image success:(void (^)(id))success fail:(void (^)(NSError *))fail{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [session POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:data name:@"file" fileName:@"headImg.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
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
