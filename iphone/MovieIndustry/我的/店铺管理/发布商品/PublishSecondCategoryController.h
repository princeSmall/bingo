//
//  PublishSecondCategoryController.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 3/10/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^backViewFn)(NSDictionary *dict);
@interface PublishSecondCategoryController : BaseViewController
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)backViewFn backFn;

@end
