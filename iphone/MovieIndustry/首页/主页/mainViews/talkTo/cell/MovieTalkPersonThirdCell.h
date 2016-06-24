//
//  MovieTalkPersonThirdCell.h
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieArticleDetailModel;

@interface MovieTalkPersonThirdCell : UITableViewCell


@property (nonatomic,strong) MovieArticleDetailModel *articleModel;


@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIImageView *articleImage;

@end
