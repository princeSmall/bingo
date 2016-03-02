//
//  MovieDeliveryMethodModel.h
//
//  Created by MACIO 猫爷 on 15/12/4
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieDeliveryMethodModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *deliveryId;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
