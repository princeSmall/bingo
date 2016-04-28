//
//  MovieSpecialShowGoodIndoModel.m
//
//  Created by MACIO 猫爷 on 15/12/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieSpecialShowGoodIndoModel.h"


NSString *const kMovieSpecialShowGoodIndoModelImg = @"img";
NSString *const kMovieSpecialShowGoodIndoModelCity = @"city";
NSString *const kMovieSpecialShowGoodIndoModelId = @"id";
NSString *const kMovieSpecialShowGoodIndoModelCurrentPrice = @"current_price";
NSString *const kMovieSpecialShowGoodIndoModelSort = @"sort";
NSString *const kMovieSpecialShowGoodIndoModelDeliveryName = @"delivery_name";
NSString *const kMovieSpecialShowGoodIndoModelShopId = @"shop_id";
NSString *const kMovieSpecialShowGoodIndoModelOriginPrice = @"origin_price";
NSString *const kMovieSpecialShowGoodIndoModelName = @"name";


@interface MovieSpecialShowGoodIndoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieSpecialShowGoodIndoModel

@synthesize img = _img;
@synthesize city = _city;
@synthesize goodId = _goodId;
@synthesize currentPrice = _currentPrice;
@synthesize sort = _sort;
@synthesize deliveryName = _deliveryName;
@synthesize shopId = _shopId;
@synthesize originPrice = _originPrice;
@synthesize name = _name;


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
            self.img = [self objectOrNilForKey:kMovieSpecialShowGoodIndoModelImg fromDictionary:dict];
            self.city = [self objectOrNilForKey:kMovieSpecialShowGoodIndoModelCity fromDictionary:dict];
            self.goodId = [self objectOrNilForKey:kMovieSpecialShowGoodIndoModelId fromDictionary:dict];
            self.currentPrice = [self objectOrNilForKey:kMovieSpecialShowGoodIndoModelCurrentPrice fromDictionary:dict];
            self.sort = [self objectOrNilForKey:kMovieSpecialShowGoodIndoModelSort fromDictionary:dict];
            self.deliveryName = [self objectOrNilForKey:kMovieSpecialShowGoodIndoModelDeliveryName fromDictionary:dict];
            self.shopId = [self objectOrNilForKey:kMovieSpecialShowGoodIndoModelShopId fromDictionary:dict];
            self.originPrice = [self objectOrNilForKey:kMovieSpecialShowGoodIndoModelOriginPrice fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieSpecialShowGoodIndoModelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.img forKey:kMovieSpecialShowGoodIndoModelImg];
    [mutableDict setValue:self.city forKey:kMovieSpecialShowGoodIndoModelCity];
    [mutableDict setValue:self.goodId forKey:kMovieSpecialShowGoodIndoModelId];
    [mutableDict setValue:self.currentPrice forKey:kMovieSpecialShowGoodIndoModelCurrentPrice];
    [mutableDict setValue:self.sort forKey:kMovieSpecialShowGoodIndoModelSort];
    [mutableDict setValue:self.deliveryName forKey:kMovieSpecialShowGoodIndoModelDeliveryName];
    [mutableDict setValue:self.shopId forKey:kMovieSpecialShowGoodIndoModelShopId];
    [mutableDict setValue:self.originPrice forKey:kMovieSpecialShowGoodIndoModelOriginPrice];
    [mutableDict setValue:self.name forKey:kMovieSpecialShowGoodIndoModelName];

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

    self.img = [aDecoder decodeObjectForKey:kMovieSpecialShowGoodIndoModelImg];
    self.city = [aDecoder decodeObjectForKey:kMovieSpecialShowGoodIndoModelCity];
    self.goodId = [aDecoder decodeObjectForKey:kMovieSpecialShowGoodIndoModelId];
    self.currentPrice = [aDecoder decodeObjectForKey:kMovieSpecialShowGoodIndoModelCurrentPrice];
    self.sort = [aDecoder decodeObjectForKey:kMovieSpecialShowGoodIndoModelSort];
    self.deliveryName = [aDecoder decodeObjectForKey:kMovieSpecialShowGoodIndoModelDeliveryName];
    self.shopId = [aDecoder decodeObjectForKey:kMovieSpecialShowGoodIndoModelShopId];
    self.originPrice = [aDecoder decodeObjectForKey:kMovieSpecialShowGoodIndoModelOriginPrice];
    self.name = [aDecoder decodeObjectForKey:kMovieSpecialShowGoodIndoModelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_img forKey:kMovieSpecialShowGoodIndoModelImg];
    [aCoder encodeObject:_city forKey:kMovieSpecialShowGoodIndoModelCity];
    [aCoder encodeObject:_goodId forKey:kMovieSpecialShowGoodIndoModelId];
    [aCoder encodeObject:_currentPrice forKey:kMovieSpecialShowGoodIndoModelCurrentPrice];
    [aCoder encodeObject:_sort forKey:kMovieSpecialShowGoodIndoModelSort];
    [aCoder encodeObject:_deliveryName forKey:kMovieSpecialShowGoodIndoModelDeliveryName];
    [aCoder encodeObject:_shopId forKey:kMovieSpecialShowGoodIndoModelShopId];
    [aCoder encodeObject:_originPrice forKey:kMovieSpecialShowGoodIndoModelOriginPrice];
    [aCoder encodeObject:_name forKey:kMovieSpecialShowGoodIndoModelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieSpecialShowGoodIndoModel *copy = [[MovieSpecialShowGoodIndoModel alloc] init];
    
    if (copy) {

        copy.img = [self.img copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.goodId = [self.goodId copyWithZone:zone];
        copy.currentPrice = [self.currentPrice copyWithZone:zone];
        copy.sort = [self.sort copyWithZone:zone];
        copy.deliveryName = [self.deliveryName copyWithZone:zone];
        copy.shopId = [self.shopId copyWithZone:zone];
        copy.originPrice = [self.originPrice copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
