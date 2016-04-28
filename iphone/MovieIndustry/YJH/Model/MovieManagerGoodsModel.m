//
//  MovieManagerGoodsModel.m
//
//  Created by MACIO 猫爷 on 15/12/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieManagerGoodsModel.h"


NSString *const kMovieManagerGoodsModelImg = @"img";
NSString *const kMovieManagerGoodsModelCityId = @"city_id";
NSString *const kMovieManagerGoodsModelId = @"id";
NSString *const kMovieManagerGoodsModelCurrentPrice = @"current_price";
NSString *const kMovieManagerGoodsModelLocationId = @"location_id";
NSString *const kMovieManagerGoodsModelDeliveryId = @"delivery_id";
NSString *const kMovieManagerGoodsModelName = @"name";


@interface MovieManagerGoodsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieManagerGoodsModel

@synthesize img = _img;
@synthesize cityId = _cityId;
@synthesize goodId = _goodId;
@synthesize currentPrice = _currentPrice;
@synthesize locationId = _locationId;
@synthesize deliveryId = _deliveryId;
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
            self.img = [self objectOrNilForKey:kMovieManagerGoodsModelImg fromDictionary:dict];
            self.cityId = [self objectOrNilForKey:kMovieManagerGoodsModelCityId fromDictionary:dict];
            self.goodId = [self objectOrNilForKey:kMovieManagerGoodsModelId fromDictionary:dict];
            self.currentPrice = [self objectOrNilForKey:kMovieManagerGoodsModelCurrentPrice fromDictionary:dict];
            self.locationId = [self objectOrNilForKey:kMovieManagerGoodsModelLocationId fromDictionary:dict];
            self.deliveryId = [self objectOrNilForKey:kMovieManagerGoodsModelDeliveryId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieManagerGoodsModelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.img forKey:kMovieManagerGoodsModelImg];
    [mutableDict setValue:self.cityId forKey:kMovieManagerGoodsModelCityId];
    [mutableDict setValue:self.goodId forKey:kMovieManagerGoodsModelId];
    [mutableDict setValue:self.currentPrice forKey:kMovieManagerGoodsModelCurrentPrice];
    [mutableDict setValue:self.locationId forKey:kMovieManagerGoodsModelLocationId];
    [mutableDict setValue:self.deliveryId forKey:kMovieManagerGoodsModelDeliveryId];
    [mutableDict setValue:self.name forKey:kMovieManagerGoodsModelName];

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

    self.img = [aDecoder decodeObjectForKey:kMovieManagerGoodsModelImg];
    self.cityId = [aDecoder decodeObjectForKey:kMovieManagerGoodsModelCityId];
    self.goodId = [aDecoder decodeObjectForKey:kMovieManagerGoodsModelId];
    self.currentPrice = [aDecoder decodeObjectForKey:kMovieManagerGoodsModelCurrentPrice];
    self.locationId = [aDecoder decodeObjectForKey:kMovieManagerGoodsModelLocationId];
    self.deliveryId = [aDecoder decodeObjectForKey:kMovieManagerGoodsModelDeliveryId];
    self.name = [aDecoder decodeObjectForKey:kMovieManagerGoodsModelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_img forKey:kMovieManagerGoodsModelImg];
    [aCoder encodeObject:_cityId forKey:kMovieManagerGoodsModelCityId];
    [aCoder encodeObject:_goodId forKey:kMovieManagerGoodsModelId];
    [aCoder encodeObject:_currentPrice forKey:kMovieManagerGoodsModelCurrentPrice];
    [aCoder encodeObject:_locationId forKey:kMovieManagerGoodsModelLocationId];
    [aCoder encodeObject:_deliveryId forKey:kMovieManagerGoodsModelDeliveryId];
    [aCoder encodeObject:_name forKey:kMovieManagerGoodsModelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieManagerGoodsModel *copy = [[MovieManagerGoodsModel alloc] init];
    
    if (copy) {

        copy.img = [self.img copyWithZone:zone];
        copy.cityId = [self.cityId copyWithZone:zone];
        copy.goodId = [self.goodId copyWithZone:zone];
        copy.currentPrice = [self.currentPrice copyWithZone:zone];
        copy.locationId = [self.locationId copyWithZone:zone];
        copy.deliveryId = [self.deliveryId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
