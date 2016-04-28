//
//  MovieTuesdayRushedPersonModel.m
//
//  Created by MACIO 猫爷 on 15/12/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieTuesdayRushedPersonModel.h"


NSString *const kMovieTuesdayRushedPersonModelNumber = @"number";
NSString *const kMovieTuesdayRushedPersonModelIconImg = @"icon_img";
NSString *const kMovieTuesdayRushedPersonModelTime = @"time";
NSString *const kMovieTuesdayRushedPersonModelUserId = @"user_id";
NSString *const kMovieTuesdayRushedPersonModelDealId = @"deal_id";
NSString *const kMovieTuesdayRushedPersonModelTotalPrice = @"total_price";
NSString *const kMovieTuesdayRushedPersonModelName = @"name";
NSString *const kMovieTuesdayRushedPersonModelUserName = @"user_name";


@interface MovieTuesdayRushedPersonModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieTuesdayRushedPersonModel

@synthesize number = _number;
@synthesize iconImg = _iconImg;
@synthesize time = _time;
@synthesize userId = _userId;
@synthesize dealId = _dealId;
@synthesize totalPrice = _totalPrice;
@synthesize name = _name;
@synthesize userName = _userName;


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
            self.number = [self objectOrNilForKey:kMovieTuesdayRushedPersonModelNumber fromDictionary:dict];
            self.iconImg = [self objectOrNilForKey:kMovieTuesdayRushedPersonModelIconImg fromDictionary:dict];
            self.time = [self objectOrNilForKey:kMovieTuesdayRushedPersonModelTime fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kMovieTuesdayRushedPersonModelUserId fromDictionary:dict];
            self.dealId = [self objectOrNilForKey:kMovieTuesdayRushedPersonModelDealId fromDictionary:dict];
            self.totalPrice = [self objectOrNilForKey:kMovieTuesdayRushedPersonModelTotalPrice fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieTuesdayRushedPersonModelName fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kMovieTuesdayRushedPersonModelUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.number forKey:kMovieTuesdayRushedPersonModelNumber];
    [mutableDict setValue:self.iconImg forKey:kMovieTuesdayRushedPersonModelIconImg];
    [mutableDict setValue:self.time forKey:kMovieTuesdayRushedPersonModelTime];
    [mutableDict setValue:self.userId forKey:kMovieTuesdayRushedPersonModelUserId];
    [mutableDict setValue:self.dealId forKey:kMovieTuesdayRushedPersonModelDealId];
    [mutableDict setValue:self.totalPrice forKey:kMovieTuesdayRushedPersonModelTotalPrice];
    [mutableDict setValue:self.name forKey:kMovieTuesdayRushedPersonModelName];
    [mutableDict setValue:self.userName forKey:kMovieTuesdayRushedPersonModelUserName];

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

    self.number = [aDecoder decodeObjectForKey:kMovieTuesdayRushedPersonModelNumber];
    self.iconImg = [aDecoder decodeObjectForKey:kMovieTuesdayRushedPersonModelIconImg];
    self.time = [aDecoder decodeObjectForKey:kMovieTuesdayRushedPersonModelTime];
    self.userId = [aDecoder decodeObjectForKey:kMovieTuesdayRushedPersonModelUserId];
    self.dealId = [aDecoder decodeObjectForKey:kMovieTuesdayRushedPersonModelDealId];
    self.totalPrice = [aDecoder decodeObjectForKey:kMovieTuesdayRushedPersonModelTotalPrice];
    self.name = [aDecoder decodeObjectForKey:kMovieTuesdayRushedPersonModelName];
    self.userName = [aDecoder decodeObjectForKey:kMovieTuesdayRushedPersonModelUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_number forKey:kMovieTuesdayRushedPersonModelNumber];
    [aCoder encodeObject:_iconImg forKey:kMovieTuesdayRushedPersonModelIconImg];
    [aCoder encodeObject:_time forKey:kMovieTuesdayRushedPersonModelTime];
    [aCoder encodeObject:_userId forKey:kMovieTuesdayRushedPersonModelUserId];
    [aCoder encodeObject:_dealId forKey:kMovieTuesdayRushedPersonModelDealId];
    [aCoder encodeObject:_totalPrice forKey:kMovieTuesdayRushedPersonModelTotalPrice];
    [aCoder encodeObject:_name forKey:kMovieTuesdayRushedPersonModelName];
    [aCoder encodeObject:_userName forKey:kMovieTuesdayRushedPersonModelUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieTuesdayRushedPersonModel *copy = [[MovieTuesdayRushedPersonModel alloc] init];
    
    if (copy) {

        copy.number = [self.number copyWithZone:zone];
        copy.iconImg = [self.iconImg copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.dealId = [self.dealId copyWithZone:zone];
        copy.totalPrice = [self.totalPrice copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}


@end
