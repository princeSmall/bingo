//
//  MovieReceiveNeedsOtherInfo.m
//
//  Created by MACIO 猫爷 on 15/11/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieReceiveNeedsOtherInfo.h"


NSString *const kMovieReceiveNeedsOtherInfoId = @"id";
NSString *const kMovieReceiveNeedsOtherInfoKeyword = @"keyword";
NSString *const kMovieReceiveNeedsOtherInfoCateId = @"cate_id";
NSString *const kMovieReceiveNeedsOtherInfoNikename = @"nikename";
NSString *const kMovieReceiveNeedsOtherInfoMobile = @"mobile";
NSString *const kMovieReceiveNeedsOtherInfoJuli = @"juli";
NSString *const kMovieReceiveNeedsOtherInfoPriceId = @"price_id";
NSString *const kMovieReceiveNeedsOtherInfoUserId = @"user_id";
NSString *const kMovieReceiveNeedsOtherInfoNumerate = @"numerate";
NSString *const kMovieReceiveNeedsOtherInfoCityId = @"city_id";
NSString *const kMovieReceiveNeedsOtherInfoRemark = @"remark";
NSString *const kMovieReceiveNeedsOtherInfoCateName = @"cate_name";
NSString *const kMovieReceiveNeedsOtherInfoPriceName = @"price_name";
NSString *const kMovieReceiveNeedsOtherInfoCityName = @"city_name";
NSString *const kMovieReceiveNeedsOtherInfoIconImg = @"icon_img";
NSString *const kMovieReceiveNeedsOtherInfoTimeStr = @"time_str";
NSString *const kMovieReceiveNeedsOtherInfoProfession = @"profession";
NSString *const kMovieReceiveNeedsOtherInfoAddTime = @"add_time";


@interface MovieReceiveNeedsOtherInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieReceiveNeedsOtherInfo

@synthesize movieReceiveNeedsOtherInfoIdentifier = _movieReceiveNeedsOtherInfoIdentifier;
@synthesize keyword = _keyword;
@synthesize cateId = _cateId;
@synthesize nikename = _nikename;
@synthesize mobile = _mobile;
@synthesize juli = _juli;
@synthesize priceId = _priceId;
@synthesize userId = _userId;
@synthesize numerate = _numerate;
@synthesize cityId = _cityId;
@synthesize remark = _remark;
@synthesize cateName = _cateName;
@synthesize priceName = _priceName;
@synthesize cityName = _cityName;
@synthesize iconImg = _iconImg;
@synthesize timeStr = _timeStr;
@synthesize profession = _profession;
@synthesize addTime = _addTime;


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
            self.movieReceiveNeedsOtherInfoIdentifier = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoId fromDictionary:dict];
            self.keyword = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoKeyword fromDictionary:dict];
            self.cateId = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoCateId fromDictionary:dict];
            self.nikename = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoNikename fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoMobile fromDictionary:dict];
            self.juli = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoJuli fromDictionary:dict];
            self.priceId = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoPriceId fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoUserId fromDictionary:dict];
            self.numerate = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoNumerate fromDictionary:dict];
            self.cityId = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoCityId fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoRemark fromDictionary:dict];
            self.cateName = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoCateName fromDictionary:dict];
            self.priceName = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoPriceName fromDictionary:dict];
            self.cityName = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoCityName fromDictionary:dict];
            self.iconImg = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoIconImg fromDictionary:dict];
            self.timeStr = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoTimeStr fromDictionary:dict];
            self.profession = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoProfession fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kMovieReceiveNeedsOtherInfoAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.movieReceiveNeedsOtherInfoIdentifier forKey:kMovieReceiveNeedsOtherInfoId];
    [mutableDict setValue:self.keyword forKey:kMovieReceiveNeedsOtherInfoKeyword];
    [mutableDict setValue:self.cateId forKey:kMovieReceiveNeedsOtherInfoCateId];
    [mutableDict setValue:self.nikename forKey:kMovieReceiveNeedsOtherInfoNikename];
    [mutableDict setValue:self.mobile forKey:kMovieReceiveNeedsOtherInfoMobile];
    [mutableDict setValue:self.juli forKey:kMovieReceiveNeedsOtherInfoJuli];
    [mutableDict setValue:self.priceId forKey:kMovieReceiveNeedsOtherInfoPriceId];
    [mutableDict setValue:self.userId forKey:kMovieReceiveNeedsOtherInfoUserId];
    [mutableDict setValue:self.numerate forKey:kMovieReceiveNeedsOtherInfoNumerate];
    [mutableDict setValue:self.cityId forKey:kMovieReceiveNeedsOtherInfoCityId];
    [mutableDict setValue:self.remark forKey:kMovieReceiveNeedsOtherInfoRemark];
    [mutableDict setValue:self.cateName forKey:kMovieReceiveNeedsOtherInfoCateName];
    [mutableDict setValue:self.priceName forKey:kMovieReceiveNeedsOtherInfoPriceName];
    [mutableDict setValue:self.cityName forKey:kMovieReceiveNeedsOtherInfoCityName];
    [mutableDict setValue:self.iconImg forKey:kMovieReceiveNeedsOtherInfoIconImg];
    [mutableDict setValue:self.timeStr forKey:kMovieReceiveNeedsOtherInfoTimeStr];
    [mutableDict setValue:self.profession forKey:kMovieReceiveNeedsOtherInfoProfession];
    [mutableDict setValue:self.addTime forKey:kMovieReceiveNeedsOtherInfoAddTime];

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

    self.movieReceiveNeedsOtherInfoIdentifier = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoId];
    self.keyword = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoKeyword];
    self.cateId = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoCateId];
    self.nikename = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoNikename];
    self.mobile = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoMobile];
    self.juli = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoJuli];
    self.priceId = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoPriceId];
    self.userId = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoUserId];
    self.numerate = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoNumerate];
    self.cityId = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoCityId];
    self.remark = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoRemark];
    self.cateName = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoCateName];
    self.priceName = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoPriceName];
    self.cityName = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoCityName];
    self.iconImg = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoIconImg];
    self.timeStr = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoTimeStr];
    self.profession = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoProfession];
    self.addTime = [aDecoder decodeObjectForKey:kMovieReceiveNeedsOtherInfoAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_movieReceiveNeedsOtherInfoIdentifier forKey:kMovieReceiveNeedsOtherInfoId];
    [aCoder encodeObject:_keyword forKey:kMovieReceiveNeedsOtherInfoKeyword];
    [aCoder encodeObject:_cateId forKey:kMovieReceiveNeedsOtherInfoCateId];
    [aCoder encodeObject:_nikename forKey:kMovieReceiveNeedsOtherInfoNikename];
    [aCoder encodeObject:_mobile forKey:kMovieReceiveNeedsOtherInfoMobile];
    [aCoder encodeObject:_juli forKey:kMovieReceiveNeedsOtherInfoJuli];
    [aCoder encodeObject:_priceId forKey:kMovieReceiveNeedsOtherInfoPriceId];
    [aCoder encodeObject:_userId forKey:kMovieReceiveNeedsOtherInfoUserId];
    [aCoder encodeObject:_numerate forKey:kMovieReceiveNeedsOtherInfoNumerate];
    [aCoder encodeObject:_cityId forKey:kMovieReceiveNeedsOtherInfoCityId];
    [aCoder encodeObject:_remark forKey:kMovieReceiveNeedsOtherInfoRemark];
    [aCoder encodeObject:_cateName forKey:kMovieReceiveNeedsOtherInfoCateName];
    [aCoder encodeObject:_priceName forKey:kMovieReceiveNeedsOtherInfoPriceName];
    [aCoder encodeObject:_cityName forKey:kMovieReceiveNeedsOtherInfoCityName];
    [aCoder encodeObject:_iconImg forKey:kMovieReceiveNeedsOtherInfoIconImg];
    [aCoder encodeObject:_timeStr forKey:kMovieReceiveNeedsOtherInfoTimeStr];
    [aCoder encodeObject:_profession forKey:kMovieReceiveNeedsOtherInfoProfession];
    [aCoder encodeObject:_addTime forKey:kMovieReceiveNeedsOtherInfoAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieReceiveNeedsOtherInfo *copy = [[MovieReceiveNeedsOtherInfo alloc] init];
    
    if (copy) {

        copy.movieReceiveNeedsOtherInfoIdentifier = [self.movieReceiveNeedsOtherInfoIdentifier copyWithZone:zone];
        copy.keyword = [self.keyword copyWithZone:zone];
        copy.cateId = [self.cateId copyWithZone:zone];
        copy.nikename = [self.nikename copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.juli = self.juli;
        copy.priceId = [self.priceId copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.numerate = [self.numerate copyWithZone:zone];
        copy.cityId = [self.cityId copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.cateName = [self.cateName copyWithZone:zone];
        copy.priceName = [self.priceName copyWithZone:zone];
        copy.cityName = [self.cityName copyWithZone:zone];
        copy.iconImg = [self.iconImg copyWithZone:zone];
        copy.timeStr = [self.timeStr copyWithZone:zone];
        copy.profession = [self.profession copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
