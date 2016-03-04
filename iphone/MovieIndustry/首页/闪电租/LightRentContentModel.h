//
//  LightRentContentModel.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 3/4/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LightRentContentModel : NSObject


@property (nonatomic,copy)NSString *keyWord;

@property (nonatomic,copy)NSString *address;

@property (nonatomic,copy)NSString *times;

@property (nonatomic,copy)NSString *type;

@property (nonatomic,copy)NSString *price;
/**
 *  备注
 */
@property (nonatomic,copy)NSString *remarks;
@end
