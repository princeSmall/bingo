//
//  MovieTalkPersonSecondCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieArticleDetailModel;

@interface MovieTalkPersonSecondCell : UITableViewCell

@property (nonatomic,strong) MovieArticleDetailModel *articleModel;

@property (strong, nonatomic) IBOutlet UIButton *nameBtn;

@property (strong, nonatomic) IBOutlet UILabel *content;

@end
