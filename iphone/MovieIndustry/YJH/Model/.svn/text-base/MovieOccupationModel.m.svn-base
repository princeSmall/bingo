//
//  MovieOccupationModel.m
//
//  Created by MACIO 猫爷 on 15/12/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieOccupationModel.h"


NSString *const kMovieOccupationModelId = @"id";
NSString *const kMovieOccupationModelValue = @"value";


@interface MovieOccupationModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieOccupationModel

@synthesize occupationId = _occupationId;
@synthesize value = _value;


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
            self.occupationId = [self objectOrNilForKey:kMovieOccupationModelId fromDictionary:dict];
            self.value = [self objectOrNilForKey:kMovieOccupationModelValue fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.occupationId forKey:kMovieOccupationModelId];
    [mutableDict setValue:self.value forKey:kMovieOccupationModelValue];

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

    self.occupationId = [aDecoder decodeObjectForKey:kMovieOccupationModelId];
    self.value = [aDecoder decodeObjectForKey:kMovieOccupationModelValue];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_occupationId forKey:kMovieOccupationModelId];
    [aCoder encodeObject:_value forKey:kMovieOccupationModelValue];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieOccupationModel *copy = [[MovieOccupationModel alloc] init];
    
    if (copy) {

        copy.occupationId = [self.occupationId copyWithZone:zone];
        copy.value = [self.value copyWithZone:zone];
    }
    
    return copy;
}


@end
