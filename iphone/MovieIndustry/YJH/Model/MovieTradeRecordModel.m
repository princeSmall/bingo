//
//  MovieTradeRecordModel.m
//
//  Created by MACIO 猫爷 on 15/12/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieTradeRecordModel.h"


NSString *const kMovieTradeRecordModelName = @"name";
NSString *const kMovieTradeRecordModelTime = @"time";
NSString *const kMovieTradeRecordModelTotalPrice = @"total_price";


@interface MovieTradeRecordModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieTradeRecordModel

@synthesize name = _name;
@synthesize time = _time;
@synthesize totalPrice = _totalPrice;


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
            self.name = [self objectOrNilForKey:kMovieTradeRecordModelName fromDictionary:dict];
            self.time = [self objectOrNilForKey:kMovieTradeRecordModelTime fromDictionary:dict];
            self.totalPrice = [self objectOrNilForKey:kMovieTradeRecordModelTotalPrice fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kMovieTradeRecordModelName];
    [mutableDict setValue:self.time forKey:kMovieTradeRecordModelTime];
    [mutableDict setValue:self.totalPrice forKey:kMovieTradeRecordModelTotalPrice];

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

    self.name = [aDecoder decodeObjectForKey:kMovieTradeRecordModelName];
    self.time = [aDecoder decodeObjectForKey:kMovieTradeRecordModelTime];
    self.totalPrice = [aDecoder decodeObjectForKey:kMovieTradeRecordModelTotalPrice];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kMovieTradeRecordModelName];
    [aCoder encodeObject:_time forKey:kMovieTradeRecordModelTime];
    [aCoder encodeObject:_totalPrice forKey:kMovieTradeRecordModelTotalPrice];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieTradeRecordModel *copy = [[MovieTradeRecordModel alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.time = [self.time copyWithZone:zone];
        copy.totalPrice = [self.totalPrice copyWithZone:zone];
    }
    
    return copy;
}


@end
