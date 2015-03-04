//
//  MovieReportReasonModel.m
//
//  Created by MACIO 猫爷 on 15/11/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieReportReasonModel.h"


NSString *const kMovieReportReasonModelRemark = @"remark";
NSString *const kMovieReportReasonModelId = @"id";
NSString *const kMovieReportReasonModelValue = @"value";
NSString *const kMovieReportReasonModelOrd = @"ord";
NSString *const kMovieReportReasonModelTypeId = @"type_id";
NSString *const kMovieReportReasonModelValue2 = @"value_2";


@interface MovieReportReasonModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieReportReasonModel

@synthesize remark = _remark;
@synthesize movieReportReasonModelIdentifier = _movieReportReasonModelIdentifier;
@synthesize value = _value;
@synthesize ord = _ord;
@synthesize typeId = _typeId;
@synthesize value2 = _value2;


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
            self.remark = [self objectOrNilForKey:kMovieReportReasonModelRemark fromDictionary:dict];
            self.movieReportReasonModelIdentifier = [self objectOrNilForKey:kMovieReportReasonModelId fromDictionary:dict];
            self.value = [self objectOrNilForKey:kMovieReportReasonModelValue fromDictionary:dict];
            self.ord = [self objectOrNilForKey:kMovieReportReasonModelOrd fromDictionary:dict];
            self.typeId = [self objectOrNilForKey:kMovieReportReasonModelTypeId fromDictionary:dict];
            self.value2 = [self objectOrNilForKey:kMovieReportReasonModelValue2 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.remark forKey:kMovieReportReasonModelRemark];
    [mutableDict setValue:self.movieReportReasonModelIdentifier forKey:kMovieReportReasonModelId];
    [mutableDict setValue:self.value forKey:kMovieReportReasonModelValue];
    [mutableDict setValue:self.ord forKey:kMovieReportReasonModelOrd];
    [mutableDict setValue:self.typeId forKey:kMovieReportReasonModelTypeId];
    [mutableDict setValue:self.value2 forKey:kMovieReportReasonModelValue2];

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

    self.remark = [aDecoder decodeObjectForKey:kMovieReportReasonModelRemark];
    self.movieReportReasonModelIdentifier = [aDecoder decodeObjectForKey:kMovieReportReasonModelId];
    self.value = [aDecoder decodeObjectForKey:kMovieReportReasonModelValue];
    self.ord = [aDecoder decodeObjectForKey:kMovieReportReasonModelOrd];
    self.typeId = [aDecoder decodeObjectForKey:kMovieReportReasonModelTypeId];
    self.value2 = [aDecoder decodeObjectForKey:kMovieReportReasonModelValue2];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_remark forKey:kMovieReportReasonModelRemark];
    [aCoder encodeObject:_movieReportReasonModelIdentifier forKey:kMovieReportReasonModelId];
    [aCoder encodeObject:_value forKey:kMovieReportReasonModelValue];
    [aCoder encodeObject:_ord forKey:kMovieReportReasonModelOrd];
    [aCoder encodeObject:_typeId forKey:kMovieReportReasonModelTypeId];
    [aCoder encodeObject:_value2 forKey:kMovieReportReasonModelValue2];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieReportReasonModel *copy = [[MovieReportReasonModel alloc] init];
    
    if (copy) {

        copy.remark = [self.remark copyWithZone:zone];
        copy.movieReportReasonModelIdentifier = [self.movieReportReasonModelIdentifier copyWithZone:zone];
        copy.value = [self.value copyWithZone:zone];
        copy.ord = [self.ord copyWithZone:zone];
        copy.typeId = [self.typeId copyWithZone:zone];
        copy.value2 = [self.value2 copyWithZone:zone];
    }
    
    return copy;
}


@end
