//
//  MovieIncomeDetailModel.h
//
//  Created by MACIO 猫爷 on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieIncomeDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *names;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
