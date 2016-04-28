//
//  IndexCell.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "IndexCell.h"
#import "MovieDiscoveryArticleModel.h"

@interface IndexCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation IndexCell

- (void)config:(IndexModel *)model
{
    self.titleLabel.text = model.title;
    
    if ([model.image isEqualToString:@""]) {
        
    }else
    {
        [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,model.image]] placeholderImage:[UIImage imageNamed:@"index4.png"]];
    }
    //设置图片
    
    self.descLabel.text = model.brief;
    self.commentLabel.text = [NSString stringWithFormat:@"%@评",model.comment_number];
    
}

- (void)setArticleModel:(MovieDiscoveryArticleModel *)articleModel
{
    _articleModel = articleModel;
    
    if (![articleModel.image isEqualToString:@""]) {
        
        [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PREFIX,articleModel.image]] placeholderImage:[UIImage imageNamed:@"index4.png"]];
    }
    
    self.titleLabel.text = articleModel.title;
    self.descLabel.text = articleModel.brief;
    self.commentLabel.text = [NSString stringWithFormat:@"%@评",articleModel.commentNumber];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
