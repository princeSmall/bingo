//
//  MovieTalkPersonSecondCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieTalkPersonSecondCell.h"
#import "MovieArticleDetailModel.h"

@interface MovieTalkPersonSecondCell ()

@property (strong, nonatomic) IBOutlet UILabel *authorBriefLab;
@property (strong, nonatomic) IBOutlet UIButton *authorName;


@end

@implementation MovieTalkPersonSecondCell


- (void)setArticleModel:(MovieArticleDetailModel *)articleModel
{
    _articleModel = articleModel;
    
    //作者名称
    NSString *name = articleModel.author;
    if (![name isEqualToString:@""]) {
        [self.authorName setTitle:articleModel.author forState:UIControlStateNormal];
    }
    else{
        self.authorName.hidden = YES;
    }
    
    //作者简介
    self.authorBriefLab.text = articleModel.brief;
    
    [self setAuthorCellNewFrame:articleModel];
}


- (void)setAuthorCellNewFrame:(MovieArticleDetailModel *)model
{
    CGRect brieflyFrame = self.content.frame;
    brieflyFrame.size.height = [DeliveryUtility caculateContentSizeWithContent:model.brief andHight:CGFLOAT_MAX andWidth:screenWidth-30 andFont:[UIFont systemFontOfSize:17.0f]].height;
    self.content.frame = brieflyFrame;
    
    NSLog(@"cell中计算的高度 --> %@",NSStringFromCGRect(self.content.frame));
}

- (void)awakeFromNib {

    self.nameBtn.layer.borderWidth = 1.0f;
    self.nameBtn.layer.borderColor = RGBColor(0, 122, 255, 1).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
