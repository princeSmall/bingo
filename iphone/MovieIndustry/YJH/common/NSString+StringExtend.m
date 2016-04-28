//
//  NSString+StringExtend.m
//  F-Zone
//
//  Created by  13-12-5.
//  Copyright (c) . All rights reserved.
//

#import "NSString+StringExtend.h"

@implementation NSString (StringExtend)

#pragma 去除两边空格
- (NSString *)asTrim {
    NSString *returnValue;
    if (self == nil) returnValue = @"";
    returnValue = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return returnValue;
}

#pragma 检测字符串中是否有特殊字符
- (BOOL)chkSpecialString {
    NSString *str = @"`~!@#$%^&*()-+=|\\[]{}:;'\",.<>/?";
    NSRange range = [self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:str]];
    if (range.location == NSNotFound)
        return NO;
    else
        return YES;
}

#pragma 检测字符串中是否有SQL注入关键字
- (BOOL)chkSQLString {
    NSString *str = @"'\"";
    NSRange range = [self rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:str]];
    if (range.location == NSNotFound)
        return NO;
    else
        return YES;
}

- (id)convertToJSON {
    if (self == nil || [self isEqualToString:@""]) return nil;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    id jsonData;
    NSError *error;
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error)
        return nil;
    return jsonData;
}

@end
