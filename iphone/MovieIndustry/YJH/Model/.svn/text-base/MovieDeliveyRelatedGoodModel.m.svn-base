//
//  MovieDeliveyRelatedGoodModel.m
//
//  Created by MACIO 猫爷 on 15/12/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieDeliveyRelatedGoodModel.h"


NSString *const kMovieDeliveyRelatedGoodModelNumber = @"number";
NSString *const kMovieDeliveyRelatedGoodModelImg = @"img";
NSString *const kMovieDeliveyRelatedGoodModelOrderStatus = @"order_status";
NSString *const kMovieDeliveyRelatedGoodModelYanse = @"yanse";
NSString *const kMovieDeliveyRelatedGoodModelDeliveryStatus = @"delivery_status";
NSString *const kMovieDeliveyRelatedGoodModelTotalPrice = @"total_price";
NSString *const kMovieDeliveyRelatedGoodModelName = @"name";


@interface MovieDeliveyRelatedGoodModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieDeliveyRelatedGoodModel

@synthesize number = _number;
@synthesize img = _img;
@synthesize orderStatus = _orderStatus;
@synthesize yanse = _yanse;
@synthesize deliveryStatus = _deliveryStatus;
@synthesize totalPrice = _totalPrice;
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
            self.number = [self objectOrNilForKey:kMovieDeliveyRelatedGoodModelNumber fromDictionary:dict];
            self.img = [self objectOrNilForKey:kMovieDeliveyRelatedGoodModelImg fromDictionary:dict];
            self.orderStatus = [self objectOrNilForKey:kMovieDeliveyRelatedGoodModelOrderStatus fromDictionary:dict];
            self.yanse = [self objectOrNilForKey:kMovieDeliveyRelatedGoodModelYanse fromDictionary:dict];
            self.deliveryStatus = [self objectOrNilForKey:kMovieDeliveyRelatedGoodModelDeliveryStatus fromDictionary:dict];
            self.totalPrice = [self objectOrNilForKey:kMovieDeliveyRelatedGoodModelTotalPrice fromDictionary:dict];
            self.name = [self objectOrNilForKey:kMovieDeliveyRelatedGoodModelName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.number forKey:kMovieDeliveyRelatedGoodModelNumber];
    [mutableDict setValue:self.img forKey:kMovieDeliveyRelatedGoodModelImg];
    [mutableDict setValue:self.orderStatus forKey:kMovieDeliveyRelatedGoodModelOrderStatus];
    [mutableDict setValue:self.yanse forKey:kMovieDeliveyRelatedGoodModelYanse];
    [mutableDict setValue:self.deliveryStatus forKey:kMovieDeliveyRelatedGoodModelDeliveryStatus];
    [mutableDict setValue:self.totalPrice forKey:kMovieDeliveyRelatedGoodModelTotalPrice];
    [mutableDict setValue:self.name forKey:kMovieDeliveyRelatedGoodModelName];

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

    self.number = [aDecoder decodeObjectForKey:kMovieDeliveyRelatedGoodModelNumber];
    self.img = [aDecoder decodeObjectForKey:kMovieDeliveyRelatedGoodModelImg];
    self.orderStatus = [aDecoder decodeObjectForKey:kMovieDeliveyRelatedGoodModelOrderStatus];
    self.yanse = [aDecoder decodeObjectForKey:kMovieDeliveyRelatedGoodModelYanse];
    self.deliveryStatus = [aDecoder decodeObjectForKey:kMovieDeliveyRelatedGoodModelDeliveryStatus];
    self.totalPrice = [aDecoder decodeObjectForKey:kMovieDeliveyRelatedGoodModelTotalPrice];
    self.name = [aDecoder decodeObjectForKey:kMovieDeliveyRelatedGoodModelName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_number forKey:kMovieDeliveyRelatedGoodModelNumber];
    [aCoder encodeObject:_img forKey:kMovieDeliveyRelatedGoodModelImg];
    [aCoder encodeObject:_orderStatus forKey:kMovieDeliveyRelatedGoodModelOrderStatus];
    [aCoder encodeObject:_yanse forKey:kMovieDeliveyRelatedGoodModelYanse];
    [aCoder encodeObject:_deliveryStatus forKey:kMovieDeliveyRelatedGoodModelDeliveryStatus];
    [aCoder encodeObject:_totalPrice forKey:kMovieDeliveyRelatedGoodModelTotalPrice];
    [aCoder encodeObject:_name forKey:kMovieDeliveyRelatedGoodModelName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieDeliveyRelatedGoodModel *copy = [[MovieDeliveyRelatedGoodModel alloc] init];
    
    if (copy) {

        copy.number = [self.number copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.orderStatus = [self.orderStatus copyWithZone:zone];
        copy.yanse = [self.yanse copyWithZone:zone];
        copy.deliveryStatus = [self.deliveryStatus copyWithZone:zone];
        copy.totalPrice = [self.totalPrice copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
