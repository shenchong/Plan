//
//  PublicMethod.m
//  Planist
//
//  Created by easemob on 16/10/24.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "PublicMethod.h"

@implementation PublicMethod
+(UIColor *)setColorWithString:(NSString *)color alpha:(CGFloat)alpha{
    int colorInt=[color intValue];
    if(colorInt<0)
        return [UIColor whiteColor];
    
    NSString *nLetterValue;
    NSString *colorString16 =@"";
    int ttmpig;
    for (int i = 0; i<9; i++)
    {
        ttmpig=colorInt%16;
        colorInt=colorInt/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
                
        }
        colorString16 = [nLetterValue stringByAppendingString:colorString16];
        if (colorInt == 0)
            break;
    }
    colorString16 = [[colorString16 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString]; //去掉前后空格换行符
    
    // strip 0X if it appears
    if ([colorString16 hasPrefix:@"0X"])
        colorString16 = [colorString16 substringFromIndex:2];
    if ([colorString16 hasPrefix:@"#"])
        colorString16 = [colorString16 substringFromIndex:1];
    // String should be 6 or 8 characters
    if ([colorString16 length] < 6)
    {
        long cc=6-[colorString16 length];
        for (int i=0; i<cc; i++)
            colorString16=[@"0" stringByAppendingString:colorString16];
    }
    if ([colorString16 length] != 6)
        return [UIColor whiteColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *bString = [colorString16 substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [colorString16 substringWithRange:range];
    
    range.location = 4;
    NSString *rString = [colorString16 substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  //扫描16进制到int
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)setColorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (UIColor *)setColorWithHexString:(NSString *)color{
    return [self setColorWithHexString:color alpha:1.0f];
}
@end
