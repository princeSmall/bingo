//
//  MovieTuesdayRushHistoryModel.m
//
//  Created by MACIO 猫爷 on 15/12/8
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieTuesdayRushHistoryModel.h"
#import "MovieTuesdayRushedPersonModel.h"

NSString *const kMovieTuesdayRushHistoryModelStatus = @"status";
NSString *const kMovieTuesdayRushHistoryModelShijain = @"shijain";
NSString *const kMovieTuesdayRushHistoryModelDealId = @"deal_id";
NSString *const kMovieTuesdayRushHistoryModelName = @"name";
NSString *const kMovieTuesdayRushHistoryModelShu = @"shu";
NSString *const kMovieTuesdayRushHistoryModelGoods = @"goods";


@interface MovieTuesdayRushHistoryModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieTuesdayRushHistoryModel

@synthesize status = _status;
@synthesize shijain = _shijain;
@synthesize dealId = _dealId;
@synthesize name = _name;
@synthesize shu = _shu;
@synthesize goods = _goods;


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
            self.status = [self objectOrNilForKey:kMovieTuesdayRushHistoryModelStatus fromDictionary:dict];
            self.shijain = [self objectOrNilForKey:kMovieTuesdayRushHistoryModelShijain fromDictionary:dict];
            self.dealId = [self objectOrNilForKey:kMovieTuesdayRushHistoryModelDealId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieTuesdayRushHistoryModelName fromDictionary:dict];
            self.shu = [self objectOrNilForKey:kMovieTuesdayRushHistoryModelShu fromDictionary:dict];
    NSObject *receivedGoods = [dict objectForKey:kMovieTuesdayRushHistoryModelGoods];
    NSMutableArray *parsedGoods = [NSMutableArray array];
    if ([receivedGoods isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGoods) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGoods addObject:[MovieTuesdayRushedPersonModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGoods isKindOfClass:[NSDictionary class]]) {
       [parsedGoods addObject:[MovieTuesdayRushedPersonModel modelObjectWithDictionary:(NSDictionary *)receivedGoods]];
    }

    self.goods = [NSArray arrayWithArray:parsedGoods];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kMovieTuesdayRushHistoryModelStatus];
    [mutableDict setValue:self.shijain forKey:kMovieTuesdayRushHistoryModelShijain];
    [mutableDict setValue:self.dealId forKey:kMovieTuesdayRushHistoryModelDealId];
    [mutableDict setValue:self.name forKey:kMovieTuesdayRushHistoryModelName];
    [mutableDict setValue:self.shu forKey:kMovieTuesdayRushHistoryModelShu];
    NSMutableArray *tempArrayForGoods = [NSMutableArray array];
    for (NSObject *subArrayObject in self.goods) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGoods addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGoods addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGoods] forKey:kMovieTuesdayRushHistoryModelGoods];

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

    self.status = [aDecoder decodeObjectForKey:kMovieTuesdayRushHistoryModelStatus];
    self.shijain = [aDecoder decodeObjectForKey:kMovieTuesdayRushHistoryModelShijain];
    self.dealId = [aDecoder decodeObjectForKey:kMovieTuesdayRushHistoryModelDealId];
    self.name = [aDecoder decodeObjectForKey:kMovieTuesdayRushHistoryModelName];
    self.shu = [aDecoder decodeObjectForKey:kMovieTuesdayRushHistoryModelShu];
    self.goods = [aDecoder decodeObjectForKey:kMovieTuesdayRushHistoryModelGoods];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_status forKey:kMovieTuesdayRushHistoryModelStatus];
    [aCoder encodeObject:_shijain forKey:kMovieTuesdayRushHistoryModelShijain];
    [aCoder encodeObject:_dealId forKey:kMovieTuesdayRushHistoryModelDealId];
    [aCoder encodeObject:_name forKey:kMovieTuesdayRushHistoryModelName];
    [aCoder encodeObject:_shu forKey:kMovieTuesdayRushHistoryModelShu];
    [aCoder encodeObject:_goods forKey:kMovieTuesdayRushHistoryModelGoods];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieTuesdayRushHistoryModel *copy = [[MovieTuesdayRushHistoryModel alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.shijain = [self.shijain copyWithZone:zone];
        copy.dealId = [self.dealId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.shu = self.shu;
        copy.goods = [self.goods copyWithZone:zone];
    }
    
    return copy;
}


@end
