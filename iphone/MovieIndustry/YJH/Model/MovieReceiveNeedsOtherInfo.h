//
//  MovieReceiveNeedsOtherInfo.h
//
//  Created by MACIO 猫爷 on 15/11/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieReceiveNeedsOtherInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *movieReceiveNeedsOtherInfoIdentifier;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *cateId;
@property (nonatomic, strong) NSString *nikename;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *juli;
@property (nonatomic, strong) NSString *priceId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *numerate;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *cateName;
@property (nonatomic, strong) NSString *priceName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *iconImg;
@property (nonatomic, strong) NSString *timeStr;
@property (nonatomic, strong) NSString *profession;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
