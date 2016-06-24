//
//  MovieRelateArticleCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/12/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieRelateArticleCell.h"
#import "MovieRelatedArticleModel.h"

@interface MovieRelateArticleCell ()

@property (strong, nonatomic) IBOutlet UILabel *aticleTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *authorLab;


@end

@implementation MovieRelateArticleCell


- (void)setRelateModel:(MovieRelatedArticleModel *)relateModel
{
    _relateModel = relateModel;
    
    self.aticleTitleLab.text = relateModel.title;
    self.dateLab.text = [relateModel.time substringToIndex:9];
    self.authorLab.text = relateModel.userName;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
