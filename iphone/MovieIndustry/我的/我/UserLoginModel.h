//
//  UserLoginModel.h
//  MovieIndustry
//
//  Created by 童乐 on 16/2/3.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLoginModel : NSObject<NSCoding>

@property (nonatomic,strong)NSString * phoneNumber;
@property (nonatomic,strong)NSString * user_id;

+ (void)ArchiveUser:(UserLoginModel *)user;
+ (UserLoginModel *)UnarchiverUser;


@end
