//
//  GoodCollectionInfo.m
//
//  Created by MACIO 猫爷 on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GoodCollectionInfo.h"


NSString *const kGoodCollectionInfoBrief = @"brief";
NSString *const kGoodCollectionInfoImg = @"img";
NSString *const kGoodCollectionInfoId = @"id";
NSString *const kGoodCollectionInfoCurrentPrice = @"current_price";
NSString *const kGoodCollectionInfoCityname = @"cityname";
NSString *const kGoodCollectionInfoLocationId = @"location_id";
NSString *const kGoodCollectionInfoDeliveryId = @"delivery_id";
NSString *const kGoodCollectionInfoName = @"name";
NSString *const kGoodCollectionInfoOriginPrice = @"origin_price";


@interface GoodCollectionInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GoodCollectionInfo

@synthesize brief = _brief;
@synthesize img = _img;
@synthesize goodsId = _goodsId;
@synthesize currentPrice = _currentPrice;
@synthesize cityname = _cityname;
@synthesize locationId = _locationId;
@synthesize deliveryId = _deliveryId;
@synthesize name = _name;
@synthesize originPrice = _originPrice;


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
            self.brief = [self objectOrNilForKey:kGoodCollectionInfoBrief fromDictionary:dict];
            self.img = [self objectOrNilForKey:kGoodCollectionInfoImg fromDictionary:dict];
            self.goodsId = [self objectOrNilForKey:kGoodCollectionInfoId fromDictionary:dict];
            self.currentPrice = [self objectOrNilForKey:kGoodCollectionInfoCurrentPrice fromDictionary:dict];
            self.cityname = [self objectOrNilForKey:kGoodCollectionInfoCityname fromDictionary:dict];
            self.locationId = [self objectOrNilForKey:kGoodCollectionInfoLocationId fromDictionary:dict];
            self.deliveryId = [self objectOrNilForKey:kGoodCollectionInfoDeliveryId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kGoodCollectionInfoName fromDictionary:dict];
            self.originPrice = [self objectOrNilForKey:kGoodCollectionInfoOriginPrice fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.brief forKey:kGoodCollectionInfoBrief];
    [mutableDict setValue:self.img forKey:kGoodCollectionInfoImg];
    [mutableDict setValue:self.goodsId forKey:kGoodCollectionInfoId];
    [mutableDict setValue:self.currentPrice forKey:kGoodCollectionInfoCurrentPrice];
    [mutableDict setValue:self.cityname forKey:kGoodCollectionInfoCityname];
    [mutableDict setValue:self.locationId forKey:kGoodCollectionInfoLocationId];
    [mutableDict setValue:self.deliveryId forKey:kGoodCollectionInfoDeliveryId];
    [mutableDict setValue:self.name forKey:kGoodCollectionInfoName];
    [mutableDict setValue:self.originPrice forKey:kGoodCollectionInfoOriginPrice];

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

    self.brief = [aDecoder decodeObjectForKey:kGoodCollectionInfoBrief];
    self.img = [aDecoder decodeObjectForKey:kGoodCollectionInfoImg];
    self.goodsId = [aDecoder decodeObjectForKey:kGoodCollectionInfoId];
    self.currentPrice = [aDecoder decodeObjectForKey:kGoodCollectionInfoCurrentPrice];
    self.cityname = [aDecoder decodeObjectForKey:kGoodCollectionInfoCityname];
    self.locationId = [aDecoder decodeObjectForKey:kGoodCollectionInfoLocationId];
    self.deliveryId = [aDecoder decodeObjectForKey:kGoodCollectionInfoDeliveryId];
    self.name = [aDecoder decodeObjectForKey:kGoodCollectionInfoName];
    self.originPrice = [aDecoder decodeObjectForKey:kGoodCollectionInfoOriginPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_brief forKey:kGoodCollectionInfoBrief];
    [aCoder encodeObject:_img forKey:kGoodCollectionInfoImg];
    [aCoder encodeObject:_goodsId forKey:kGoodCollectionInfoId];
    [aCoder encodeObject:_currentPrice forKey:kGoodCollectionInfoCurrentPrice];
    [aCoder encodeObject:_cityname forKey:kGoodCollectionInfoCityname];
    [aCoder encodeObject:_locationId forKey:kGoodCollectionInfoLocationId];
    [aCoder encodeObject:_deliveryId forKey:kGoodCollectionInfoDeliveryId];
    [aCoder encodeObject:_name forKey:kGoodCollectionInfoName];
    [aCoder encodeObject:_originPrice forKey:kGoodCollectionInfoOriginPrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    GoodCollectionInfo *copy = [[GoodCollectionInfo alloc] init];
    
    if (copy) {

        copy.brief = [self.brief copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.goodsId = [self.goodsId copyWithZone:zone];
        copy.currentPrice = [self.currentPrice copyWithZone:zone];
        copy.cityname = [self.cityname copyWithZone:zone];
        copy.locationId = [self.locationId copyWithZone:zone];
        copy.deliveryId = [self.deliveryId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.originPrice = [self.originPrice copyWithZone:zone];
    }
    
    return copy;
}


@end
