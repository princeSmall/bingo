//
//  MovieUserTopicDetailCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieUserTopicDetailCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *title;//标题

@property (strong, nonatomic) IBOutlet UIImageView *headerImg;//头像

@property (strong, nonatomic) IBOutlet UIImageView *level;//等级图标

@property (strong, nonatomic) IBOutlet UILabel *name;//姓名

@property (strong, nonatomic) IBOutlet UILabel *time;//时间

@property (strong, nonatomic) IBOutlet UILabel *commentCount;//评论数量


@property (strong, nonatomic) IBOutlet UILabel *content;//内容

@end
