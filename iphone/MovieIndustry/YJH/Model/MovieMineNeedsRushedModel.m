//
//  MovieMineNeedsRushedModel.m
//
//  Created by MACIO 猫爷 on 15/12/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieMineNeedsRushedModel.h"
#import "MovieNeedsRushedGoodsInfoModel.h"


NSString *const kMovieMineNeedsRushedModelStatus = @"status";
NSString *const kMovieMineNeedsRushedModelLocationName = @"location_name";
NSString *const kMovieMineNeedsRushedModelCity = @"city";
NSString *const kMovieMineNeedsRushedModelId = @"id";
NSString *const kMovieMineNeedsRushedModelRentId = @"rent_id";
NSString *const kMovieMineNeedsRushedModelUpdateTime = @"update_time";
NSString *const kMovieMineNeedsRushedModelLocationId = @"location_id";
NSString *const kMovieMineNeedsRushedModelDealId = @"deal_id";
NSString *const kMovieMineNeedsRushedModelDealInfo = @"deal_info";
NSString *const kMovieMineNeedsRushedModelAddTime = @"add_time";


@interface MovieMineNeedsRushedModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieMineNeedsRushedModel

@synthesize status = _status;
@synthesize locationName = _locationName;
@synthesize city = _city;
@synthesize movieMineNeedsRushedModelIdentifier = _movieMineNeedsRushedModelIdentifier;
@synthesize rentId = _rentId;
@synthesize updateTime = _updateTime;
@synthesize locationId = _locationId;
@synthesize dealId = _dealId;
@synthesize dealInfo = _dealInfo;
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
            self.status = [self objectOrNilForKey:kMovieMineNeedsRushedModelStatus fromDictionary:dict];
            self.locationName = [self objectOrNilForKey:kMovieMineNeedsRushedModelLocationName fromDictionary:dict];
            self.city = [self objectOrNilForKey:kMovieMineNeedsRushedModelCity fromDictionary:dict];
            self.movieMineNeedsRushedModelIdentifier = [self objectOrNilForKey:kMovieMineNeedsRushedModelId fromDictionary:dict];
            self.rentId = [self objectOrNilForKey:kMovieMineNeedsRushedModelRentId fromDictionary:dict];
            self.updateTime = [self objectOrNilForKey:kMovieMineNeedsRushedModelUpdateTime fromDictionary:dict];
            self.locationId = [self objectOrNilForKey:kMovieMineNeedsRushedModelLocationId fromDictionary:dict];
            self.dealId = [self objectOrNilForKey:kMovieMineNeedsRushedModelDealId fromDictionary:dict];
    NSObject *receivedDealInfo = [dict objectForKey:kMovieMineNeedsRushedModelDealInfo];
    NSMutableArray *parsedDealInfo = [NSMutableArray array];
    if ([receivedDealInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDealInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDealInfo addObject:[MovieNeedsRushedGoodsInfoModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDealInfo isKindOfClass:[NSDictionary class]]) {
       [parsedDealInfo addObject:[MovieNeedsRushedGoodsInfoModel modelObjectWithDictionary:(NSDictionary *)receivedDealInfo]];
    }

    self.dealInfo = [NSArray arrayWithArray:parsedDealInfo];
            self.addTime = [self objectOrNilForKey:kMovieMineNeedsRushedModelAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kMovieMineNeedsRushedModelStatus];
    [mutableDict setValue:self.locationName forKey:kMovieMineNeedsRushedModelLocationName];
    [mutableDict setValue:self.city forKey:kMovieMineNeedsRushedModelCity];
    [mutableDict setValue:self.movieMineNeedsRushedModelIdentifier forKey:kMovieMineNeedsRushedModelId];
    [mutableDict setValue:self.rentId forKey:kMovieMineNeedsRushedModelRentId];
    [mutableDict setValue:self.updateTime forKey:kMovieMineNeedsRushedModelUpdateTime];
    [mutableDict setValue:self.locationId forKey:kMovieMineNeedsRushedModelLocationId];
    [mutableDict setValue:self.dealId forKey:kMovieMineNeedsRushedModelDealId];
    NSMutableArray *tempArrayForDealInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.dealInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDealInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDealInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDealInfo] forKey:kMovieMineNeedsRushedModelDealInfo];
    [mutableDict setValue:self.addTime forKey:kMovieMineNeedsRushedModelAddTime];

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

    self.status = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelStatus];
    self.locationName = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelLocationName];
    self.city = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelCity];
    self.movieMineNeedsRushedModelIdentifier = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelId];
    self.rentId = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelRentId];
    self.updateTime = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelUpdateTime];
    self.locationId = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelLocationId];
    self.dealId = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelDealId];
    self.dealInfo = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelDealInfo];
    self.addTime = [aDecoder decodeObjectForKey:kMovieMineNeedsRushedModelAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kMovieMineNeedsRushedModelStatus];
    [aCoder encodeObject:_locationName forKey:kMovieMineNeedsRushedModelLocationName];
    [aCoder encodeObject:_city forKey:kMovieMineNeedsRushedModelCity];
    [aCoder encodeObject:_movieMineNeedsRushedModelIdentifier forKey:kMovieMineNeedsRushedModelId];
    [aCoder encodeObject:_rentId forKey:kMovieMineNeedsRushedModelRentId];
    [aCoder encodeObject:_updateTime forKey:kMovieMineNeedsRushedModelUpdateTime];
    [aCoder encodeObject:_locationId forKey:kMovieMineNeedsRushedModelLocationId];
    [aCoder encodeObject:_dealId forKey:kMovieMineNeedsRushedModelDealId];
    [aCoder encodeObject:_dealInfo forKey:kMovieMineNeedsRushedModelDealInfo];
    [aCoder encodeObject:_addTime forKey:kMovieMineNeedsRushedModelAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieMineNeedsRushedModel *copy = [[MovieMineNeedsRushedModel alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.locationName = [self.locationName copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.movieMineNeedsRushedModelIdentifier = [self.movieMineNeedsRushedModelIdentifier copyWithZone:zone];
        copy.rentId = [self.rentId copyWithZone:zone];
        copy.updateTime = [self.updateTime copyWithZone:zone];
        copy.locationId = [self.locationId copyWithZone:zone];
        copy.dealId = [self.dealId copyWithZone:zone];
        copy.dealInfo = [self.dealInfo copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
