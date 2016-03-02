//
//  FilmBannerCell.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/13.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class MovieDiscoveryArticleModel;

@interface FilmBannerCell : UITableViewCell

//@property (nonatomic,strong) MovieDiscoveryArticleModel *articleModel;

@property (nonatomic,retain) NSArray *dataArray;



@property (weak, nonatomic) IBOutlet UIButton *leftImageBtn;

@property (weak, nonatomic) IBOutlet UIButton *rightImageBtn;

@end
