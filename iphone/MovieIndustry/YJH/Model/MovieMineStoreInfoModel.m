//
//  MovieMineStoreInfoModel.m
//
//  Created by MACIO 猫爷 on 15/11/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieMineStoreInfoModel.h"


NSString *const kMovieMineStoreInfoModelPreview = @"preview";
NSString *const kMovieMineStoreInfoModelMoney = @"money";
NSString *const kMovieMineStoreInfoModelLocationId = @"location_id";
NSString *const kMovieMineStoreInfoModelBrief = @"brief";
NSString *const kMovieMineStoreInfoModelName = @"name";
NSString *const kMovieMineStoreInfoModelIncome = @"income";


@interface MovieMineStoreInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieMineStoreInfoModel

@synthesize preview = _preview;
@synthesize money = _money;
@synthesize locationId = _locationId;
@synthesize brief = _brief;
@synthesize name = _name;
@synthesize income = _income;


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
            self.preview = [self objectOrNilForKey:kMovieMineStoreInfoModelPreview fromDictionary:dict];
            self.money = [self objectOrNilForKey:kMovieMineStoreInfoModelMoney fromDictionary:dict];
            self.locationId = [self objectOrNilForKey:kMovieMineStoreInfoModelLocationId fromDictionary:dict];
            self.brief = [self objectOrNilForKey:kMovieMineStoreInfoModelBrief fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieMineStoreInfoModelName fromDictionary:dict];
            self.income = [self objectOrNilForKey:kMovieMineStoreInfoModelIncome fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.preview forKey:kMovieMineStoreInfoModelPreview];
    [mutableDict setValue:self.money forKey:kMovieMineStoreInfoModelMoney];
    [mutableDict setValue:self.locationId forKey:kMovieMineStoreInfoModelLocationId];
    [mutableDict setValue:self.brief forKey:kMovieMineStoreInfoModelBrief];
    [mutableDict setValue:self.name forKey:kMovieMineStoreInfoModelName];
    [mutableDict setValue:self.income forKey:kMovieMineStoreInfoModelIncome];

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

    self.preview = [aDecoder decodeObjectForKey:kMovieMineStoreInfoModelPreview];
    self.money = [aDecoder decodeObjectForKey:kMovieMineStoreInfoModelMoney];
    self.locationId = [aDecoder decodeObjectForKey:kMovieMineStoreInfoModelLocationId];
    self.brief = [aDecoder decodeObjectForKey:kMovieMineStoreInfoModelBrief];
    self.name = [aDecoder decodeObjectForKey:kMovieMineStoreInfoModelName];
    self.income = [aDecoder decodeObjectForKey:kMovieMineStoreInfoModelIncome];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_preview forKey:kMovieMineStoreInfoModelPreview];
    [aCoder encodeObject:_money forKey:kMovieMineStoreInfoModelMoney];
    [aCoder encodeObject:_locationId forKey:kMovieMineStoreInfoModelLocationId];
    [aCoder encodeObject:_brief forKey:kMovieMineStoreInfoModelBrief];
    [aCoder encodeObject:_name forKey:kMovieMineStoreInfoModelName];
    [aCoder encodeObject:_income forKey:kMovieMineStoreInfoModelIncome];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieMineStoreInfoModel *copy = [[MovieMineStoreInfoModel alloc] init];
    
    if (copy) {

        copy.preview = [self.preview copyWithZone:zone];
        copy.money = [self.money copyWithZone:zone];
        copy.locationId = [self.locationId copyWithZone:zone];
        copy.brief = [self.brief copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.income = [self.income copyWithZone:zone];
    }
    
    return copy;
}


@end
