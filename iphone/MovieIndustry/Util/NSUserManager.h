//
//  NSUserManager.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//  存储历史记录

#import <Foundation/Foundation.h>

@interface NSUserManager : NSObject

///设置key
+ (void)SetSearchText:(NSString *)searchTxt andKey:(NSString *)searchKey;
///读取key
+ (NSArray *)readNSUserDefaultsAndKey:(NSString *)searchKey;

@end
