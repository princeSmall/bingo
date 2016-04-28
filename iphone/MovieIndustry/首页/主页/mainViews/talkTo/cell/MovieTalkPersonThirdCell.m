//
//  MovieTalkPersonThirdCell.m
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieTalkPersonThirdCell.h"
#import "MovieArticleDetailModel.h"

@implementation MovieTalkPersonThirdCell


- (void)setArticleModel:(MovieArticleDetailModel *)articleModel
{
    _articleModel = articleModel;
    
    //内容
    self.content.text = articleModel.content;
    
    //图片
    if ([articleModel.image isEqualToString:@""])
    {
        self.articleImage.hidden = YES;
        [self setNewFrameWithContent:articleModel.content andImage:nil];
    }
    else
    {
        [self.articleImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,articleModel.image]]];
        [self setNewFrameWithContent:articleModel.content andImage:articleModel.image];
    }
}

- (void)setNewFrameWithContent:(NSString *)content andImage:(NSString *)imageName
{
//    CGFloat contentH = [DeliveryUtility caculateContentSizeWithContent:content andHight:<#(CGFloat)#> andWidth:<#(CGFloat)#> andFont:<#(UIFont *)#>]
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
