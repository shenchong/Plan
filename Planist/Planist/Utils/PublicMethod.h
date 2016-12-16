//
//  PublicMethod.h
//  Planist
//
//  Created by easemob on 16/10/24.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicMethod : NSObject
///设置颜色
+ (UIColor *)setColorWithString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)setColorWithHexString:(NSString *)color;
+ (UIColor *)setColorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
