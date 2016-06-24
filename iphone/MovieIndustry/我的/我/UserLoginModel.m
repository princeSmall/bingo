//
//  UserLoginModel.m
//  MovieIndustry
//
//  Created by 童乐 on 16/2/3.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "UserLoginModel.h"

@implementation UserLoginModel

+ (NSString *)getDocPath{
    NSString * string = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingString:@"/SavePath"];
    return string;
}


+ (void)ArchiveUser:(UserLoginModel *)user{
    [NSKeyedArchiver archiveRootObject:user toFile:[UserLoginModel getDocPath]];
}
+ (UserLoginModel *)UnarchiverUser{
   UserLoginModel * model = [NSKeyedUnarchiver unarchiveObjectWithFile:[UserLoginModel getDocPath]];
    return model;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.phoneNumber = [aDecoder decodeObjectForKey:@"phoneNumber"];
    }
    return self;
}


@end
