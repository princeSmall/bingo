//
//  MovieTuesdayGoodModel.m
//
//  Created by MACIO 猫爷 on 15/12/11
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieTuesdayGoodModel.h"
#import "MovieTuesdayGoodImageModel.h"


NSString *const kMovieTuesdayGoodModelNumber = @"number";
NSString *const kMovieTuesdayGoodModelDealName = @"deal_name";
NSString *const kMovieTuesdayGoodModelDaojishi = @"daojishi";
NSString *const kMovieTuesdayGoodModelQiang = @"qiang";
NSString *const kMovieTuesdayGoodModelCurrentPrice = @"current_price";
NSString *const kMovieTuesdayGoodModelImgs = @"imgs";
NSString *const kMovieTuesdayGoodModelLocationId = @"location_id";
NSString *const kMovieTuesdayGoodModelRen = @"ren";
NSString *const kMovieTuesdayGoodModelDealId = @"deal_id";
NSString *const kMovieTuesdayGoodModelOriginPrice = @"origin_price";


@interface MovieTuesdayGoodModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieTuesdayGoodModel

@synthesize number = _number;
@synthesize dealName = _dealName;
@synthesize daojishi = _daojishi;
@synthesize qiang = _qiang;
@synthesize currentPrice = _currentPrice;
@synthesize imgs = _imgs;
@synthesize locationId = _locationId;
@synthesize ren = _ren;
@synthesize dealId = _dealId;
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
            self.number = [self objectOrNilForKey:kMovieTuesdayGoodModelNumber fromDictionary:dict];
            self.dealName = [self objectOrNilForKey:kMovieTuesdayGoodModelDealName fromDictionary:dict];
            self.daojishi = [self objectOrNilForKey:kMovieTuesdayGoodModelDaojishi fromDictionary:dict];
            self.qiang = [self objectOrNilForKey:kMovieTuesdayGoodModelQiang fromDictionary:dict];
            self.currentPrice = [self objectOrNilForKey:kMovieTuesdayGoodModelCurrentPrice fromDictionary:dict];
    NSObject *receivedImgs = [dict objectForKey:kMovieTuesdayGoodModelImgs];
    NSMutableArray *parsedImgs = [NSMutableArray array];
    if ([receivedImgs isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedImgs) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedImgs addObject:[MovieTuesdayGoodImageModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedImgs isKindOfClass:[NSDictionary class]]) {
       [parsedImgs addObject:[MovieTuesdayGoodImageModel modelObjectWithDictionary:(NSDictionary *)receivedImgs]];
    }

    self.imgs = [NSArray arrayWithArray:parsedImgs];
            self.locationId = [self objectOrNilForKey:kMovieTuesdayGoodModelLocationId fromDictionary:dict];
            self.ren = [self objectOrNilForKey:kMovieTuesdayGoodModelRen fromDictionary:dict];
            self.dealId = [self objectOrNilForKey:kMovieTuesdayGoodModelDealId fromDictionary:dict];
            self.originPrice = [self objectOrNilForKey:kMovieTuesdayGoodModelOriginPrice fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.number forKey:kMovieTuesdayGoodModelNumber];
    [mutableDict setValue:self.dealName forKey:kMovieTuesdayGoodModelDealName];
    [mutableDict setValue:self.daojishi forKey:kMovieTuesdayGoodModelDaojishi];
    [mutableDict setValue:self.qiang forKey:kMovieTuesdayGoodModelQiang];
    [mutableDict setValue:self.currentPrice forKey:kMovieTuesdayGoodModelCurrentPrice];
    NSMutableArray *tempArrayForImgs = [NSMutableArray array];
    for (NSObject *subArrayObject in self.imgs) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImgs addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImgs addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImgs] forKey:kMovieTuesdayGoodModelImgs];
    [mutableDict setValue:self.locationId forKey:kMovieTuesdayGoodModelLocationId];
    [mutableDict setValue:self.ren forKey:kMovieTuesdayGoodModelRen];
    [mutableDict setValue:self.dealId forKey:kMovieTuesdayGoodModelDealId];
    [mutableDict setValue:self.originPrice forKey:kMovieTuesdayGoodModelOriginPrice];

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

    self.number = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelNumber];
    self.dealName = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelDealName];
    self.daojishi = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelDaojishi];
    self.qiang = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelQiang];
    self.currentPrice = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelCurrentPrice];
    self.imgs = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelImgs];
    self.locationId = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelLocationId];
    self.ren = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelRen];
    self.dealId = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelDealId];
    self.originPrice = [aDecoder decodeObjectForKey:kMovieTuesdayGoodModelOriginPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_number forKey:kMovieTuesdayGoodModelNumber];
    [aCoder encodeObject:_dealName forKey:kMovieTuesdayGoodModelDealName];
    [aCoder encodeObject:_daojishi forKey:kMovieTuesdayGoodModelDaojishi];
    [aCoder encodeObject:_qiang forKey:kMovieTuesdayGoodModelQiang];
    [aCoder encodeObject:_currentPrice forKey:kMovieTuesdayGoodModelCurrentPrice];
    [aCoder encodeObject:_imgs forKey:kMovieTuesdayGoodModelImgs];
    [aCoder encodeObject:_locationId forKey:kMovieTuesdayGoodModelLocationId];
    [aCoder encodeObject:_ren forKey:kMovieTuesdayGoodModelRen];
    [aCoder encodeObject:_dealId forKey:kMovieTuesdayGoodModelDealId];
    [aCoder encodeObject:_originPrice forKey:kMovieTuesdayGoodModelOriginPrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieTuesdayGoodModel *copy = [[MovieTuesdayGoodModel alloc] init];
    
    if (copy) {

        copy.number = [self.number copyWithZone:zone];
        copy.dealName = [self.dealName copyWithZone:zone];
        copy.daojishi = [self.daojishi copyWithZone:zone];
        copy.qiang = self.qiang;
        copy.currentPrice = [self.currentPrice copyWithZone:zone];
        copy.imgs = [self.imgs copyWithZone:zone];
        copy.locationId = [self.locationId copyWithZone:zone];
        copy.ren = [self.ren copyWithZone:zone];
        copy.dealId = [self.dealId copyWithZone:zone];
        copy.originPrice = [self.originPrice copyWithZone:zone];
    }
    
    return copy;
}


@end
