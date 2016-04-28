//
//  UserDesModel.h
//  MovieIndustry
//
//  Created by aaa on 16/2/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock)(NSString * string);

//用户登陆后的模型
@interface UserDesModel : NSObject
@property (nonatomic,strong)NSString * user_id;
@property (nonatomic,strong)NSString * sex;
@property (nonatomic,strong)NSString * username;
@property (nonatomic,strong)NSString * img;
@property (nonatomic,strong)NSString * mobile;
@property (nonatomic,strong)NSString * real_name;
@property (nonatomic,strong)NSString * nickname;
@property (nonatomic,strong)NSString * has_shop;
@property (nonatomic,strong)NSString * com_name;
@property (nonatomic,strong)NSString * job;
@property (nonatomic,strong)NSString * address;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (void) GetUploadImageDictWithData:(NSData *)imageData WithType:(NSString *)type With:(successBlock)block;

@end
