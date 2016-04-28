//
//  MovieIncomeDetailModel.m
//
//  Created by MACIO 猫爷 on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieIncomeDetailModel.h"


NSString *const kMovieIncomeDetailModelOrderStatus = @"order_status";
NSString *const kMovieIncomeDetailModelNames = @"names";
NSString *const kMovieIncomeDetailModelTotalPrice = @"total_price";
NSString *const kMovieIncomeDetailModelTime = @"time";
NSString *const kMovieIncomeDetailModelName = @"name";


@interface MovieIncomeDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieIncomeDetailModel

@synthesize orderStatus = _orderStatus;
@synthesize names = _names;
@synthesize totalPrice = _totalPrice;
@synthesize time = _time;
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
            self.orderStatus = [self objectOrNilForKey:kMovieIncomeDetailModelOrderStatus fromDictionary:dict];
            self.names = [self objectOrNilForKey:kMovieIncomeDetailModelNames fromDictionary:dict];
            self.totalPrice = [self objectOrNilForKey:kMovieIncomeDetailModelTotalPrice fromDictionary:dict];
            self.time = [self objectOrNilForKey:kMovieIncomeDetailModelTime fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieIncomeDetailModelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orderStatus forKey:kMovieIncomeDetailModelOrderStatus];
    [mutableDict setValue:self.names forKey:kMovieIncomeDetailModelNames];
    [mutableDict setValue:self.totalPrice forKey:kMovieIncomeDetailModelTotalPrice];
    [mutableDict setValue:self.time forKey:kMovieIncomeDetailModelTime];
    [mutableDict setValue:self.name forKey:kMovieIncomeDetailModelName];

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

    self.orderStatus = [aDecoder decodeObjectForKey:kMovieIncomeDetailModelOrderStatus];
    self.names = [aDecoder decodeObjectForKey:kMovieIncomeDetailModelNames];
    self.totalPrice = [aDecoder decodeObjectForKey:kMovieIncomeDetailModelTotalPrice];
    self.time = [aDecoder decodeObjectForKey:kMovieIncomeDetailModelTime];
    self.name = [aDecoder decodeObjectForKey:kMovieIncomeDetailModelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderStatus forKey:kMovieIncomeDetailModelOrderStatus];
    [aCoder encodeObject:_names forKey:kMovieIncomeDetailModelNames];
    [aCoder encodeObject:_totalPrice forKey:kMovieIncomeDetailModelTotalPrice];
    [aCoder encodeObject:_time forKey:kMovieIncomeDetailModelTime];
    [aCoder encodeObject:_name forKey:kMovieIncomeDetailModelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieIncomeDetailModel *copy = [[MovieIncomeDetailModel alloc] init];
    
    if (copy) {

        copy.orderStatus = [self.orderStatus copyWithZone:zone];
        copy.names = [self.names copyWithZone:zone];
        copy.totalPrice = [self.totalPrice copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
