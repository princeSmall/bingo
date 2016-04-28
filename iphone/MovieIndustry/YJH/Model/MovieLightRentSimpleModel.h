//
//  CateList.h
//
//  Created by MACIO 猫爷 on 15/11/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MovieLightRentSimpleModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *infoId;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
