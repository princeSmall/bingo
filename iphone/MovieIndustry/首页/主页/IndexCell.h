//
//  IndexCell.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexModel.h"

@class MovieDiscoveryArticleModel;

@interface IndexCell : UITableViewCell

@property (nonatomic,strong) MovieDiscoveryArticleModel *articleModel;

- (void)config:(IndexModel *)model;

@end
