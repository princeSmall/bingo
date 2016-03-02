//
//  GoodsDetailTableCell.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/2.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCommentModel.h"

@interface GoodsDetailTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
//创建时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

- (void)config:(GoodsCommentModel *)model;

@end
