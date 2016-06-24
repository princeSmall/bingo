//
//  MovieTopicTitleCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTopicTitleCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *goodImage;//商品图片

@property (strong, nonatomic) IBOutlet UILabel *goodName;//商品名称


@property (strong, nonatomic) IBOutlet UILabel *commentCount;//总帖数


@property (strong, nonatomic) IBOutlet UIButton *publishBtn;//发帖按钮


@end
