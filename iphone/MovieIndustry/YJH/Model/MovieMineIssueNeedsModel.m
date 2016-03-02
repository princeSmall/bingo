//
//  MovieMineIssueRequestModel.m
//
//  Created by MACIO 猫爷 on 15/11/27
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieMineIssueNeedsModel.h"


NSString *const kMovieMineIssueRequestModelId = @"id";
NSString *const kMovieMineIssueRequestModelKeyword = @"keyword";
NSString *const kMovieMineIssueRequestModelNikename = @"nikename";
NSString *const kMovieMineIssueRequestModelMobile = @"mobile";
NSString *const kMovieMineIssueRequestModelPriceId = @"price_id";
NSString *const kMovieMineIssueRequestModelUserId = @"user_id";
NSString *const kMovieMineIssueRequestModelNumerate = @"numerate";
NSString *const kMovieMineIssueRequestModelCityId = @"city_id";
NSString *const kMovieMineIssueRequestModelRemark = @"remark";
NSString *const kMovieMineIssueRequestModelCateName = @"cate_name";
NSString *const kMovieMineIssueRequestModelPriceName = @"price_name";
NSString *const kMovieMineIssueRequestModelIconImg = @"icon_img";
NSString *const kMovieMineIssueRequestModelTimeStr = @"time_str";
NSString *const kMovieMineIssueRequestModelAddTime = @"add_time";
NSString *const kMovieMineIssueRequestModelCityName = @"city_name";
NSString *const kMovieMineIssueRequestModelCateId = @"cate_id";


@interface MovieMineIssueNeedsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieMineIssueNeedsModel

@synthesize requestRentId = _requestRentId;
@synthesize keyword = _keyword;
@synthesize nikename = _nikename;
@synthesize mobile = _mobile;
@synthesize priceId = _priceId;
@synthesize userId = _userId;
@synthesize numerate = _numerate;
@synthesize cityId = _cityId;
@synthesize remark = _remark;
@synthesize cateName = _cateName;
@synthesize priceName = _priceName;
@synthesize iconImg = _iconImg;
@synthesize timeStr = _timeStr;
@synthesize addTime = _addTime;
@synthesize cityName = _cityName;
@synthesize cateId = _cateId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.requestRentId = [self objectOrNilForKey:kMovieMineIssueRequestModelId fromDictionary:dict];
            self.keyword = [self objectOrNilForKey:kMovieMineIssueRequestModelKeyword fromDictionary:dict];
            self.nikename = [self objectOrNilForKey:kMovieMineIssueRequestModelNikename fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kMovieMineIssueRequestModelMobile fromDictionary:dict];
            self.priceId = [self objectOrNilForKey:kMovieMineIssueRequestModelPriceId fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kMovieMineIssueRequestModelUserId fromDictionary:dict];
            self.numerate = [self objectOrNilForKey:kMovieMineIssueRequestModelNumerate fromDictionary:dict];
            self.cityId = [self objectOrNilForKey:kMovieMineIssueRequestModelCityId fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kMovieMineIssueRequestModelRemark fromDictionary:dict];
            self.cateName = [self objectOrNilForKey:kMovieMineIssueRequestModelCateName fromDictionary:dict];
            self.priceName = [self objectOrNilForKey:kMovieMineIssueRequestModelPriceName fromDictionary:dict];
            self.iconImg = [self objectOrNilForKey:kMovieMineIssueRequestModelIconImg fromDictionary:dict];
            self.timeStr = [self objectOrNilForKey:kMovieMineIssueRequestModelTimeStr fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kMovieMineIssueRequestModelAddTime fromDictionary:dict];
            self.cityName = [self objectOrNilForKey:kMovieMineIssueRequestModelCityName fromDictionary:dict];
            self.cateId = [self objectOrNilForKey:kMovieMineIssueRequestModelCateId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.requestRentId forKey:kMovieMineIssueRequestModelId];
    [mutableDict setValue:self.keyword forKey:kMovieMineIssueRequestModelKeyword];
    [mutableDict setValue:self.nikename forKey:kMovieMineIssueRequestModelNikename];
    [mutableDict setValue:self.mobile forKey:kMovieMineIssueRequestModelMobile];
    [mutableDict setValue:self.priceId forKey:kMovieMineIssueRequestModelPriceId];
    [mutableDict setValue:self.userId forKey:kMovieMineIssueRequestModelUserId];
    [mutableDict setValue:self.numerate forKey:kMovieMineIssueRequestModelNumerate];
    [mutableDict setValue:self.cityId forKey:kMovieMineIssueRequestModelCityId];
    [mutableDict setValue:self.remark forKey:kMovieMineIssueRequestModelRemark];
    [mutableDict setValue:self.cateName forKey:kMovieMineIssueRequestModelCateName];
    [mutableDict setValue:self.priceName forKey:kMovieMineIssueRequestModelPriceName];
    [mutableDict setValue:self.iconImg forKey:kMovieMineIssueRequestModelIconImg];
    [mutableDict setValue:self.timeStr forKey:kMovieMineIssueRequestModelTimeStr];
    [mutableDict setValue:self.addTime forKey:kMovieMineIssueRequestModelAddTime];
    [mutableDict setValue:self.cityName forKey:kMovieMineIssueRequestModelCityName];
    [mutableDict setValue:self.cateId forKey:kMovieMineIssueRequestModelCateId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.requestRentId = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelId];
    self.keyword = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelKeyword];
    self.nikename = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelNikename];
    self.mobile = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelMobile];
    self.priceId = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelPriceId];
    self.userId = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelUserId];
    self.numerate = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelNumerate];
    self.cityId = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelCityId];
    self.remark = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelRemark];
    self.cateName = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelCateName];
    self.priceName = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelPriceName];
    self.iconImg = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelIconImg];
    self.timeStr = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelTimeStr];
    self.addTime = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelAddTime];
    self.cityName = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelCityName];
    self.cateId = [aDecoder decodeObjectForKey:kMovieMineIssueRequestModelCateId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_requestRentId forKey:kMovieMineIssueRequestModelId];
    [aCoder encodeObject:_keyword forKey:kMovieMineIssueRequestModelKeyword];
    [aCoder encodeObject:_nikename forKey:kMovieMineIssueRequestModelNikename];
    [aCoder encodeObject:_mobile forKey:kMovieMineIssueRequestModelMobile];
    [aCoder encodeObject:_priceId forKey:kMovieMineIssueRequestModelPriceId];
    [aCoder encodeObject:_userId forKey:kMovieMineIssueRequestModelUserId];
    [aCoder encodeObject:_numerate forKey:kMovieMineIssueRequestModelNumerate];
    [aCoder encodeObject:_cityId forKey:kMovieMineIssueRequestModelCityId];
    [aCoder encodeObject:_remark forKey:kMovieMineIssueRequestModelRemark];
    [aCoder encodeObject:_cateName forKey:kMovieMineIssueRequestModelCateName];
    [aCoder encodeObject:_priceName forKey:kMovieMineIssueRequestModelPriceName];
    [aCoder encodeObject:_iconImg forKey:kMovieMineIssueRequestModelIconImg];
    [aCoder encodeObject:_timeStr forKey:kMovieMineIssueRequestModelTimeStr];
    [aCoder encodeObject:_addTime forKey:kMovieMineIssueRequestModelAddTime];
    [aCoder encodeObject:_cityName forKey:kMovieMineIssueRequestModelCityName];
    [aCoder encodeObject:_cateId forKey:kMovieMineIssueRequestModelCateId];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieMineIssueNeedsModel *copy = [[MovieMineIssueNeedsModel alloc] init];
    
    if (copy) {

        copy.requestRentId = [self.requestRentId copyWithZone:zone];
        copy.keyword = [self.keyword copyWithZone:zone];
        copy.nikename = [self.nikename copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.priceId = [self.priceId copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.numerate = [self.numerate copyWithZone:zone];
        copy.cityId = [self.cityId copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.cateName = [self.cateName copyWithZone:zone];
        copy.priceName = [self.priceName copyWithZone:zone];
        copy.iconImg = [self.iconImg copyWithZone:zone];
        copy.timeStr = [self.timeStr copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.cityName = [self.cityName copyWithZone:zone];
        copy.cateId = [self.cateId copyWithZone:zone];
    }
    
    return copy;
}


@end
