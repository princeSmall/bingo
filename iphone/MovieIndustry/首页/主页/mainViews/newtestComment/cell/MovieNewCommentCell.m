//
//  MovieNewCommentCell.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/20.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MovieNewCommentCell.h"
#import "ModelArticleCommentModel.h"
#import "MovieTuesdayCommentModel.h"

@interface MovieNewCommentCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headerImg;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *content;//内容

@property (strong, nonatomic) IBOutlet UILabel *commenCount;//评论数量

@property (strong, nonatomic) IBOutlet UIButton *gradeBtn;//用户等级

@end

@implementation MovieNewCommentCell

- (void)setCommentModel:(ModelArticleCommentModel *)commentModel
{
    _commentModel = commentModel;
    
    self.headerImg.clipsToBounds = YES;
    self.commentImage.clipsToBounds = YES;
    //头像
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,commentModel.iconImg]]];
    
    //用户等级
    if ([commentModel.grade isEqualToString:@""] || [commentModel.grade isEqualToString:@"0"]) {
        self.gradeBtn.hidden = YES;
    }
    else{
        NSString *gradeLevel = [NSString stringWithFormat:@"V%@",commentModel.grade];
        NSMutableAttributedString *levelAtt = [[NSMutableAttributedString alloc] initWithString:gradeLevel];
        [levelAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:NSMakeRange(0,1)];
        [levelAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, gradeLevel.length)];
        [self.gradeBtn setAttributedTitle:levelAtt forState:UIControlStateNormal];
    }

    
    //姓名
    self.name.text = commentModel.nikename;
    
    //时间
    self.time.text = [self transformTimeType:commentModel.addTime];
    
    //内容
    self.content.text = commentModel.content;
    
    //评论数
    self.commenCount.text = [NSString stringWithFormat:@"%@评",commentModel.contentNum];
    
    //点赞数
    [self.blessBtn setTitle:[NSString stringWithFormat:@"%@赞",commentModel.contentPraiseNum] forState:UIControlStateNormal];
    
    //是否被点赞
    if ([commentModel.statuses isEqualToString:@"0"] || [commentModel.statuses isEqualToString:@""]) {
        
        self.blessBtn.selected = NO;
        
    }else
    {
        self.blessBtn.selected = YES;
    }
    
    if (commentModel.img.length) {
        [self.commentImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,commentModel.img]]];
    }
    else{
        self.commentImage.hidden = YES;
    }
    
    
    [self setupCellNewFrame:commentModel];
}

- (void)setActiveModel:(MovieTuesdayCommentModel *)activeModel
{
    _activeModel = activeModel;
    
    //头像
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,activeModel.iconImg]]];
    
    //用户等级
    if ([activeModel.grade isEqualToString:@""] || [activeModel.grade isEqualToString:@"0"]) {
        self.gradeBtn.hidden = YES;
    }
    else{
        NSString *gradeLevel = [NSString stringWithFormat:@"V%@",activeModel.grade];
        NSMutableAttributedString *levelAtt = [[NSMutableAttributedString alloc] initWithString:gradeLevel];
        [levelAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:NSMakeRange(0,1)];
        [levelAtt addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, gradeLevel.length)];
        [self.gradeBtn setAttributedTitle:levelAtt forState:UIControlStateNormal];
    }
    
    
    //姓名
    self.name.text = activeModel.nikename;
    
    //时间
    self.time.text = [self transformTimeType:activeModel.createTime];
    
    //内容
    self.content.text = activeModel.content;
    
    //评论数
//    self.commenCount.text = [NSString stringWithFormat:@"%@评",activeModel.contentNum];
    
    //点赞数
    [self.blessBtn setTitle:[NSString stringWithFormat:@"%@赞",activeModel.contentPraiseNum] forState:UIControlStateNormal];
    
    //是否被点赞
    if ([activeModel.ping isEqualToString:@"0"] || [activeModel.ping isEqualToString:@""]) {
        
        self.blessBtn.selected = NO;
        
    }else
    {
        self.blessBtn.selected = YES;
    }
    
    if (activeModel.img.length) {
        [self.commentImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,activeModel.img]]];
    }
    else{
        self.commentImage.hidden = YES;
    }
    
    
    [self setupCellActiveNewFrame:activeModel];
}

- (NSString *)transformTimeType:(NSString *)interval
{
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    NSString *timeStr = [formatter stringFromDate:timeDate];
    return timeStr;
}


- (void)setupCellActiveNewFrame:(MovieTuesdayCommentModel *)model
{
    CGFloat contentH = [DeliveryUtility caculateContentSizeWithContent:model.content andHight:CGFLOAT_MAX andWidth:(kViewWidth-90) andFont:DefaultFont].height;
    
    CGRect contentFrame = self.content.frame;
    contentFrame.size.height = contentH;
    self.content.frame = contentFrame;
    
    CGFloat blessY;
    if (model.img.length) {
        
        CGRect imageFrame = self.commentImage.frame;
        imageFrame.origin.y = CGRectGetMaxY(contentFrame)+8;
        self.commentImage.frame = imageFrame;
        blessY = CGRectGetMaxY(imageFrame);
    }
    else
    {
        blessY = CGRectGetMaxY(contentFrame);
    }
    
//    CGRect commentNumFrame = self.commenCount.frame;
//    commentNumFrame.origin.y = blessY+10;
//    self.commenCount.frame = commentNumFrame;
//    
    CGRect blessFrame = self.blessBtn.frame;
    blessFrame.origin.y = blessY + 7;
    self.blessBtn.frame = blessFrame;
    
    CGRect timeFrame = self.time.frame;
    timeFrame.origin.y = blessY+12;
    self.time.frame = timeFrame;
}

#pragma mark - 设置frame
- (void)setupCellNewFrame:(ModelArticleCommentModel *)model
{
    CGFloat contentH = [DeliveryUtility caculateContentSizeWithContent:model.content andHight:CGFLOAT_MAX andWidth:(kViewWidth-90) andFont:DefaultFont].height;
    
    CGRect contentFrame = self.content.frame;
    contentFrame.size.height = contentH;
    self.content.frame = contentFrame;
    
    CGFloat blessY;
    if (model.img.length) {
        
        CGRect imageFrame = self.commentImage.frame;
        imageFrame.origin.y = CGRectGetMaxY(contentFrame)+8;
        self.commentImage.frame = imageFrame;
        blessY = CGRectGetMaxY(imageFrame);
    }
    else
    {
        blessY = CGRectGetMaxY(contentFrame);
    }
    
    CGRect commentNumFrame = self.commenCount.frame;
    commentNumFrame.origin.y = blessY+10;
    self.commenCount.frame = commentNumFrame;
    
    CGRect blessFrame = self.blessBtn.frame;
    blessFrame.origin.y = blessY + 5;
    self.blessBtn.frame = blessFrame;
    
    CGRect timeFrame = self.time.frame;
    timeFrame.origin.y = blessY+10;
    self.time.frame = timeFrame;
}


- (void)awakeFromNib {

    self.headerImg.clipsToBounds = YES;
    self.headerImg.layer.cornerRadius = 25.0f;
    
    self.commentImage.contentMode = UIViewContentModeScaleAspectFit;
    
    self.gradeBtn.clipsToBounds = YES;
    self.gradeBtn.layer.cornerRadius = 7.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
