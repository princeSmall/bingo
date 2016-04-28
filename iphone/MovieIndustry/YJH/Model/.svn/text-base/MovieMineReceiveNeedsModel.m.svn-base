//
//  MovieMineReceiveNeedsModel.m
//
//  Created by MACIO 猫爷 on 15/11/28
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieMineReceiveNeedsModel.h"
#import "MovieReceiveNeedsOtherInfo.h"


NSString *const kMovieMineReceiveNeedsModelStatus = @"status";
NSString *const kMovieMineReceiveNeedsModelUpdateTime = @"update_time";
NSString *const kMovieMineReceiveNeedsModelId = @"id";
NSString *const kMovieMineReceiveNeedsModelRentId = @"rent_id";
NSString *const kMovieMineReceiveNeedsModelLocationId = @"location_id";
NSString *const kMovieMineReceiveNeedsModelDealId = @"deal_id";
NSString *const kMovieMineReceiveNeedsModelOtherInfo = @"other_info";
NSString *const kMovieMineReceiveNeedsModelAddTime = @"add_time";


@interface MovieMineReceiveNeedsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieMineReceiveNeedsModel

@synthesize status = _status;
@synthesize updateTime = _updateTime;
@synthesize receiveMsgId = _receiveMsgId;
@synthesize rentId = _rentId;
@synthesize locationId = _locationId;
@synthesize dealId = _dealId;
@synthesize otherInfo = _otherInfo;
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
            self.status = [self objectOrNilForKey:kMovieMineReceiveNeedsModelStatus fromDictionary:dict];
            self.updateTime = [self objectOrNilForKey:kMovieMineReceiveNeedsModelUpdateTime fromDictionary:dict];
            self.receiveMsgId = [self objectOrNilForKey:kMovieMineReceiveNeedsModelId fromDictionary:dict];
            self.rentId = [self objectOrNilForKey:kMovieMineReceiveNeedsModelRentId fromDictionary:dict];
            self.locationId = [self objectOrNilForKey:kMovieMineReceiveNeedsModelLocationId fromDictionary:dict];
            self.dealId = [self objectOrNilForKey:kMovieMineReceiveNeedsModelDealId fromDictionary:dict];
            self.otherInfo = [MovieReceiveNeedsOtherInfo modelObjectWithDictionary:[dict objectForKey:kMovieMineReceiveNeedsModelOtherInfo]];
            self.addTime = [self objectOrNilForKey:kMovieMineReceiveNeedsModelAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kMovieMineReceiveNeedsModelStatus];
    [mutableDict setValue:self.updateTime forKey:kMovieMineReceiveNeedsModelUpdateTime];
    [mutableDict setValue:self.receiveMsgId forKey:kMovieMineReceiveNeedsModelId];
    [mutableDict setValue:self.rentId forKey:kMovieMineReceiveNeedsModelRentId];
    [mutableDict setValue:self.locationId forKey:kMovieMineReceiveNeedsModelLocationId];
    [mutableDict setValue:self.dealId forKey:kMovieMineReceiveNeedsModelDealId];
    [mutableDict setValue:[self.otherInfo dictionaryRepresentation] forKey:kMovieMineReceiveNeedsModelOtherInfo];
    [mutableDict setValue:self.addTime forKey:kMovieMineReceiveNeedsModelAddTime];

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

    self.status = [aDecoder decodeObjectForKey:kMovieMineReceiveNeedsModelStatus];
    self.updateTime = [aDecoder decodeObjectForKey:kMovieMineReceiveNeedsModelUpdateTime];
    self.receiveMsgId = [aDecoder decodeObjectForKey:kMovieMineReceiveNeedsModelId];
    self.rentId = [aDecoder decodeObjectForKey:kMovieMineReceiveNeedsModelRentId];
    self.locationId = [aDecoder decodeObjectForKey:kMovieMineReceiveNeedsModelLocationId];
    self.dealId = [aDecoder decodeObjectForKey:kMovieMineReceiveNeedsModelDealId];
    self.otherInfo = [aDecoder decodeObjectForKey:kMovieMineReceiveNeedsModelOtherInfo];
    self.addTime = [aDecoder decodeObjectForKey:kMovieMineReceiveNeedsModelAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kMovieMineReceiveNeedsModelStatus];
    [aCoder encodeObject:_updateTime forKey:kMovieMineReceiveNeedsModelUpdateTime];
    [aCoder encodeObject:_receiveMsgId forKey:kMovieMineReceiveNeedsModelId];
    [aCoder encodeObject:_rentId forKey:kMovieMineReceiveNeedsModelRentId];
    [aCoder encodeObject:_locationId forKey:kMovieMineReceiveNeedsModelLocationId];
    [aCoder encodeObject:_dealId forKey:kMovieMineReceiveNeedsModelDealId];
    [aCoder encodeObject:_otherInfo forKey:kMovieMineReceiveNeedsModelOtherInfo];
    [aCoder encodeObject:_addTime forKey:kMovieMineReceiveNeedsModelAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieMineReceiveNeedsModel *copy = [[MovieMineReceiveNeedsModel alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.updateTime = [self.updateTime copyWithZone:zone];
        copy.receiveMsgId = [self.receiveMsgId copyWithZone:zone];
        copy.rentId = [self.rentId copyWithZone:zone];
        copy.locationId = [self.locationId copyWithZone:zone];
        copy.dealId = [self.dealId copyWithZone:zone];
        copy.otherInfo = [self.otherInfo copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
