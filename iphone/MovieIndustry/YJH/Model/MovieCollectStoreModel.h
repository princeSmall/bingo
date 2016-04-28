//
//  MovieCollectStoreModel.h
//
//  Created by MACIO 猫爷 on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieCollectStoreModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *brief;
@property (nonatomic, strong) NSString *movieCollectStoreModelIdentifier;
@property (nonatomic, strong) NSString *preview;
@property (nonatomic, strong) NSString *currentPrice;
@property (nonatomic, strong) NSString *aid;
@property (nonatomic, strong) NSString *shangpin;
@property (nonatomic, strong) NSString *originPrice;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
