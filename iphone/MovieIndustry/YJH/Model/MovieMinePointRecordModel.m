//
//  MovieMinePointRecordModel.m
//
//  Created by MACIO 猫爷 on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieMinePointRecordModel.h"


NSString *const kMovieMinePointRecordModelJfTime = @"jf_time";
NSString *const kMovieMinePointRecordModelJfUserId = @"jf_user_id";
NSString *const kMovieMinePointRecordModelJfPoints = @"jf_points";
NSString *const kMovieMinePointRecordModelJfId = @"jf_id";
NSString *const kMovieMinePointRecordModelJfTitle = @"jf_title";


@interface MovieMinePointRecordModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieMinePointRecordModel

@synthesize jfTime = _jfTime;
@synthesize jfUserId = _jfUserId;
@synthesize jfPoints = _jfPoints;
@synthesize jfId = _jfId;
@synthesize jfTitle = _jfTitle;


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
            self.jfTime = [self objectOrNilForKey:kMovieMinePointRecordModelJfTime fromDictionary:dict];
            self.jfUserId = [self objectOrNilForKey:kMovieMinePointRecordModelJfUserId fromDictionary:dict];
            self.jfPoints = [self objectOrNilForKey:kMovieMinePointRecordModelJfPoints fromDictionary:dict];
            self.jfId = [self objectOrNilForKey:kMovieMinePointRecordModelJfId fromDictionary:dict];
            self.jfTitle = [self objectOrNilForKey:kMovieMinePointRecordModelJfTitle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.jfTime forKey:kMovieMinePointRecordModelJfTime];
    [mutableDict setValue:self.jfUserId forKey:kMovieMinePointRecordModelJfUserId];
    [mutableDict setValue:self.jfPoints forKey:kMovieMinePointRecordModelJfPoints];
    [mutableDict setValue:self.jfId forKey:kMovieMinePointRecordModelJfId];
    [mutableDict setValue:self.jfTitle forKey:kMovieMinePointRecordModelJfTitle];

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

    self.jfTime = [aDecoder decodeObjectForKey:kMovieMinePointRecordModelJfTime];
    self.jfUserId = [aDecoder decodeObjectForKey:kMovieMinePointRecordModelJfUserId];
    self.jfPoints = [aDecoder decodeObjectForKey:kMovieMinePointRecordModelJfPoints];
    self.jfId = [aDecoder decodeObjectForKey:kMovieMinePointRecordModelJfId];
    self.jfTitle = [aDecoder decodeObjectForKey:kMovieMinePointRecordModelJfTitle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_jfTime forKey:kMovieMinePointRecordModelJfTime];
    [aCoder encodeObject:_jfUserId forKey:kMovieMinePointRecordModelJfUserId];
    [aCoder encodeObject:_jfPoints forKey:kMovieMinePointRecordModelJfPoints];
    [aCoder encodeObject:_jfId forKey:kMovieMinePointRecordModelJfId];
    [aCoder encodeObject:_jfTitle forKey:kMovieMinePointRecordModelJfTitle];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieMinePointRecordModel *copy = [[MovieMinePointRecordModel alloc] init];
    
    if (copy) {

        copy.jfTime = [self.jfTime copyWithZone:zone];
        copy.jfUserId = [self.jfUserId copyWithZone:zone];
        copy.jfPoints = [self.jfPoints copyWithZone:zone];
        copy.jfId = [self.jfId copyWithZone:zone];
        copy.jfTitle = [self.jfTitle copyWithZone:zone];
    }
    
    return copy;
}


@end
