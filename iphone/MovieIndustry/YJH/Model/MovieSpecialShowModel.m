//
//  MovieSpecialShowModel.m
//
//  Created by MACIO 猫爷 on 15/12/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieSpecialShowModel.h"
#import "MovieSpecialShowGoodIndoModel.h"


NSString *const kMovieSpecialShowModelCarrousel = @"carrousel";
NSString *const kMovieSpecialShowModelSessionList = @"session_list";
NSString *const kMovieSpecialShowModelLefttimes = @"lefttimes";
NSString *const kMovieSpecialShowModelCountdown = @"countdown";


@interface MovieSpecialShowModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieSpecialShowModel

@synthesize carrousel = _carrousel;
@synthesize sessionList = _sessionList;
@synthesize lefttimes = _lefttimes;
@synthesize countdown = _countdown;


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
    NSObject *receivedCarrousel = [dict objectForKey:kMovieSpecialShowModelCarrousel];
    NSMutableArray *parsedCarrousel = [NSMutableArray array];
    if ([receivedCarrousel isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCarrousel) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCarrousel addObject:[MovieSpecialShowGoodIndoModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCarrousel isKindOfClass:[NSDictionary class]]) {
       [parsedCarrousel addObject:[MovieSpecialShowGoodIndoModel modelObjectWithDictionary:(NSDictionary *)receivedCarrousel]];
    }

    self.carrousel = [NSArray arrayWithArray:parsedCarrousel];
    NSObject *receivedSessionList = [dict objectForKey:kMovieSpecialShowModelSessionList];
    NSMutableArray *parsedSessionList = [NSMutableArray array];
    if ([receivedSessionList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSessionList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSessionList addObject:[MovieSpecialShowGoodIndoModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSessionList isKindOfClass:[NSDictionary class]]) {
       [parsedSessionList addObject:[MovieSpecialShowGoodIndoModel modelObjectWithDictionary:(NSDictionary *)receivedSessionList]];
    }

    self.sessionList = [NSArray arrayWithArray:parsedSessionList];
            self.lefttimes = [self objectOrNilForKey:kMovieSpecialShowModelLefttimes fromDictionary:dict];
            self.countdown = [self objectOrNilForKey:kMovieSpecialShowModelCountdown fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCarrousel = [NSMutableArray array];
    for (NSObject *subArrayObject in self.carrousel) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCarrousel addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCarrousel addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCarrousel] forKey:kMovieSpecialShowModelCarrousel];
    NSMutableArray *tempArrayForSessionList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sessionList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSessionList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSessionList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSessionList] forKey:kMovieSpecialShowModelSessionList];
    [mutableDict setValue:self.lefttimes forKey:kMovieSpecialShowModelLefttimes];
    [mutableDict setValue:self.countdown forKey:kMovieSpecialShowModelCountdown];

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

    self.carrousel = [aDecoder decodeObjectForKey:kMovieSpecialShowModelCarrousel];
    self.sessionList = [aDecoder decodeObjectForKey:kMovieSpecialShowModelSessionList];
    self.lefttimes = [aDecoder decodeObjectForKey:kMovieSpecialShowModelLefttimes];
    self.countdown = [aDecoder decodeObjectForKey:kMovieSpecialShowModelCountdown];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_carrousel forKey:kMovieSpecialShowModelCarrousel];
    [aCoder encodeObject:_sessionList forKey:kMovieSpecialShowModelSessionList];
    [aCoder encodeObject:_lefttimes forKey:kMovieSpecialShowModelLefttimes];
    [aCoder encodeObject:_countdown forKey:kMovieSpecialShowModelCountdown];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieSpecialShowModel *copy = [[MovieSpecialShowModel alloc] init];
    
    if (copy) {

        copy.carrousel = [self.carrousel copyWithZone:zone];
        copy.sessionList = [self.sessionList copyWithZone:zone];
        copy.lefttimes = self.lefttimes;
        copy.countdown = self.countdown;
    }
    
    return copy;
}


@end
