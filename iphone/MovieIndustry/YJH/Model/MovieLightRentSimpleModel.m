//
//  CateList.m
//
//  Created by MACIO 猫爷 on 15/11/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieLightRentSimpleModel.h"


NSString *const kCateListId = @"id";
NSString *const kCateListName = @"name";


@interface MovieLightRentSimpleModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieLightRentSimpleModel

@synthesize infoId = _infoId;
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
            self.infoId = [self objectOrNilForKey:kCateListId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kCateListName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.infoId forKey:kCateListId];
    [mutableDict setValue:self.name forKey:kCateListName];

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

    self.infoId = [aDecoder decodeObjectForKey:kCateListId];
    self.name = [aDecoder decodeObjectForKey:kCateListName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_infoId forKey:kCateListId];
    [aCoder encodeObject:_name forKey:kCateListName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieLightRentSimpleModel *copy = [[MovieLightRentSimpleModel alloc] init];
    
    if (copy) {

        copy.infoId = [self.infoId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
