//
//  NSUserManager.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "NSUserManager.h"

@implementation NSUserManager

+ (void)SetSearchText:(NSString *)searchTxt andKey:(NSString *)searchKey
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:searchKey];
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    
    NSArray *historyStrArray = [self readNSUserDefaultsAndKey:searchKey];
    
    ///判断以前是否存在记录
    BOOL isSvaed = NO;
    if (historyStrArray.count>0) {
        for (NSString *historyStr in historyStrArray) {
            if ([historyStr isEqualToString:searchTxt]) {
                isSvaed = YES;
            }
        }
        
        if (!searTXT) {
            searTXT = [NSMutableArray array];
            [searTXT addObject:searchTxt];
        }else{
            ///如果不存在则存储
            if (!isSvaed) {
                [searTXT addObject:searchTxt];
            }
        }
        
    }else
    {
        if (!searTXT) {
            searTXT = [NSMutableArray array];
            [searTXT addObject:searchTxt];
        }else{
            ///如果存在则存储
            if (!isSvaed) {
                [searTXT addObject:searchTxt];
            }
        }
    }
    
    
//    if(searTXT.count > 5)
//    {
//        [searTXT removeObjectAtIndex:0];
//    }
    //将上述数据全部存储到NSUserDefaults中
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searTXT forKey:searchKey];
    //同步到本地
    [userDefaultes synchronize];
}


+ (NSArray *)readNSUserDefaultsAndKey:(NSString *)searchKey
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:searchKey];
    NSLog(@"myArray======%@",myArray);
    
    return myArray;
}

- (NSArray *)readNSUserDefaultsAndKey:(NSString *)searchKey
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:searchKey];
    NSLog(@"myArray======%@",myArray);
    
    return myArray;
}

@end
