//
//  FilmBannerCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/13.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "FilmBannerCell.h"
#import "MovieDiscoveryArticleModel.h"

@interface FilmBannerCell ()

@property (strong, nonatomic) IBOutlet UILabel *leftTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *rightTitleLab;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end

@implementation FilmBannerCell


- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    MovieDiscoveryArticleModel *firstModel = [dataArray firstObject];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,firstModel.image]]];
    self.leftTitleLab.text = firstModel.title;
    
    MovieDiscoveryArticleModel *lastModel = [dataArray lastObject];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,lastModel.image]]];
    self.rightTitleLab.text = lastModel.title;
    
}

//- (void)setArticleModel:(MovieDiscoveryArticleModel *)articleModel
//{
//    _articleModel = articleModel;
//    
//    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,articleModel.image]]];
//    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,articleModel.image]]];
//    
//    self.leftTitleLab.text = articleModel.title;
//    self.rightTitleLab.text = articleModel.title;
//}







- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
