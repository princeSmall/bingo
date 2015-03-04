//
//  MovieMineNeedsRushedModel.h
//
//  Created by MACIO 猫爷 on 15/12/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieMineNeedsRushedModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *movieMineNeedsRushedModelIdentifier;
@property (nonatomic, strong) NSString *rentId;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *locationId;
@property (nonatomic, strong) NSString *dealId;
@property (nonatomic, strong) NSArray *dealInfo;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
