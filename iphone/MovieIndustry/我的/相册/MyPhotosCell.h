//
//  MyPhotosCell.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPhotosModel.h"
@interface MyPhotosCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)config:(MyPhotosModel *)model;

@end
