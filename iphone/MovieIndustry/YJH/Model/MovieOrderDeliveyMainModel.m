//
//  MovieOrderDeliveyMainModel.m
//
//  Created by MACIO 猫爷 on 15/12/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MovieOrderDeliveyMainModel.h"
#import "MovieDeliveyRelatedGoodModel.h"


NSString *const kMovieOrderDeliveyMainModelOrderName = @"order_name";
NSString *const kMovieOrderDeliveyMainModelOrderStatus = @"order_status";
NSString *const kMovieOrderDeliveyMainModelDelivery = @"delivery";
NSString *const kMovieOrderDeliveyMainModelGoods = @"goods";
NSString *const kMovieOrderDeliveyMainModelDeliveryImg = @"delivery_img";
NSString *const kMovieOrderDeliveyMainModelDeliveryStatus = @"delivery_status";


@interface MovieOrderDeliveyMainModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieOrderDeliveyMainModel

@synthesize orderName = _orderName;
@synthesize orderStatus = _orderStatus;
@synthesize delivery = _delivery;
@synthesize goods = _goods;
@synthesize deliveryImg = _deliveryImg;
@synthesize deliveryStatus = _deliveryStatus;


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
            self.orderName = [self objectOrNilForKey:kMovieOrderDeliveyMainModelOrderName fromDictionary:dict];
            self.orderStatus = [self objectOrNilForKey:kMovieOrderDeliveyMainModelOrderStatus fromDictionary:dict];
            self.delivery = [self objectOrNilForKey:kMovieOrderDeliveyMainModelDelivery fromDictionary:dict];
    NSObject *receivedGoods = [dict objectForKey:kMovieOrderDeliveyMainModelGoods];
    NSMutableArray *parsedGoods = [NSMutableArray array];
    if ([receivedGoods isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedGoods) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedGoods addObject:[MovieDeliveyRelatedGoodModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedGoods isKindOfClass:[NSDictionary class]]) {
       [parsedGoods addObject:[MovieDeliveyRelatedGoodModel modelObjectWithDictionary:(NSDictionary *)receivedGoods]];
    }

    self.goods = [NSArray arrayWithArray:parsedGoods];
            self.deliveryImg = [self objectOrNilForKey:kMovieOrderDeliveyMainModelDeliveryImg fromDictionary:dict];
            self.deliveryStatus = [self objectOrNilForKey:kMovieOrderDeliveyMainModelDeliveryStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.orderName forKey:kMovieOrderDeliveyMainModelOrderName];
    [mutableDict setValue:self.orderStatus forKey:kMovieOrderDeliveyMainModelOrderStatus];
    [mutableDict setValue:self.delivery forKey:kMovieOrderDeliveyMainModelDelivery];
    NSMutableArray *tempArrayForGoods = [NSMutableArray array];
    for (NSObject *subArrayObject in self.goods) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGoods addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGoods addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGoods] forKey:kMovieOrderDeliveyMainModelGoods];
    [mutableDict setValue:self.deliveryImg forKey:kMovieOrderDeliveyMainModelDeliveryImg];
    [mutableDict setValue:self.deliveryStatus forKey:kMovieOrderDeliveyMainModelDeliveryStatus];

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

    self.orderName = [aDecoder decodeObjectForKey:kMovieOrderDeliveyMainModelOrderName];
    self.orderStatus = [aDecoder decodeObjectForKey:kMovieOrderDeliveyMainModelOrderStatus];
    self.delivery = [aDecoder decodeObjectForKey:kMovieOrderDeliveyMainModelDelivery];
    self.goods = [aDecoder decodeObjectForKey:kMovieOrderDeliveyMainModelGoods];
    self.deliveryImg = [aDecoder decodeObjectForKey:kMovieOrderDeliveyMainModelDeliveryImg];
    self.deliveryStatus = [aDecoder decodeObjectForKey:kMovieOrderDeliveyMainModelDeliveryStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderName forKey:kMovieOrderDeliveyMainModelOrderName];
    [aCoder encodeObject:_orderStatus forKey:kMovieOrderDeliveyMainModelOrderStatus];
    [aCoder encodeObject:_delivery forKey:kMovieOrderDeliveyMainModelDelivery];
    [aCoder encodeObject:_goods forKey:kMovieOrderDeliveyMainModelGoods];
    [aCoder encodeObject:_deliveryImg forKey:kMovieOrderDeliveyMainModelDeliveryImg];
    [aCoder encodeObject:_deliveryStatus forKey:kMovieOrderDeliveyMainModelDeliveryStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieOrderDeliveyMainModel *copy = [[MovieOrderDeliveyMainModel alloc] init];
    
    if (copy) {

        copy.orderName = [self.orderName copyWithZone:zone];
        copy.orderStatus = [self.orderStatus copyWithZone:zone];
        copy.delivery = [self.delivery copyWithZone:zone];
        copy.goods = [self.goods copyWithZone:zone];
        copy.deliveryImg = [self.deliveryImg copyWithZone:zone];
        copy.deliveryStatus = [self.deliveryStatus copyWithZone:zone];
    }
    
    return copy;
}


@end
