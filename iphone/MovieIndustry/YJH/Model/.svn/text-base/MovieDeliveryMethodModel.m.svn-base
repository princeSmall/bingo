//
//  MovieDeliveryMethodModel.m
//
//  Created by MACIO 猫爷 on 15/12/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieDeliveryMethodModel.h"


NSString *const kMovieDeliveryMethodModelId = @"id";
NSString *const kMovieDeliveryMethodModelName = @"name";


@interface MovieDeliveryMethodModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieDeliveryMethodModel

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
            self.deliveryId = [self objectOrNilForKey:kMovieDeliveryMethodModelId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieDeliveryMethodModelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.deliveryId forKey:kMovieDeliveryMethodModelId];
    [mutableDict setValue:self.name forKey:kMovieDeliveryMethodModelName];

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

    self.deliveryId = [aDecoder decodeObjectForKey:kMovieDeliveryMethodModelId];
    self.name = [aDecoder decodeObjectForKey:kMovieDeliveryMethodModelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_deliveryId forKey:kMovieDeliveryMethodModelId];
    [aCoder encodeObject:_name forKey:kMovieDeliveryMethodModelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieDeliveryMethodModel *copy = [[MovieDeliveryMethodModel alloc] init];
    
    if (copy) {

        copy.deliveryId = [self.deliveryId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
