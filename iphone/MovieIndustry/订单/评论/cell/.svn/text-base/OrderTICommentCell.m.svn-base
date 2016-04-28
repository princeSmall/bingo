//
//  OrderTICommentCell.m
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/19.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "OrderTICommentCell.h"


@implementation OrderTICommentCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.layer.borderColor = [UIColor colorWithRed:0.918 green:0.925 blue:0.925 alpha:1.000].CGColor;
    self.imageView.layer.borderWidth = 1;
    
    self.goodsDesripeTField.layer.borderWidth = 1;
    self.goodsDesripeTField.layer.borderColor=[UIColor colorWithRed:0.918 green:0.925 blue:0.925 alpha:1.000].CGColor;
    self.goodsDesripeTField.layer.cornerRadius = 7;
    self.goodsDesripeTField.text =@"";
    
    self.photoBtn.layer.cornerRadius = 7;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.starView =[[StarView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.textLbl.frame), CGRectGetMinY(self.textLbl.frame), 88, 20) score:0 canscore:@"1"];
    [self addSubview:self.starView];
    
}
/*@interface OrderTICommentCell : UITableViewCell
 @property (weak, nonatomic) IBOutlet UIImageView *goodsImage;//图片
 @property (weak, nonatomic) IBOutlet UILabel *goodsTitleLbl;//商品名
 @property (weak, nonatomic) IBOutlet UILabel *goodsPriceLbl;//商品价格
 
 @property (weak, nonatomic) IBOutlet UITextView *goodsDesripeTField;//商品描述textView
 @property (weak, nonatomic) IBOutlet UIButton *photoBtn;//选择图片按钮
 @property (weak, nonatomic) IBOutlet UILabel *textLbl;//描述lbl*/
/**
 *  赋值
 *
 *  @param model 参数
 *  @param image 评论图片
 *  @param text  评论内容
 *  @param score 分数
 */
-(void)config:(OrderGoodsModel *)model
        image:(UIImage *)image
         text:(NSString *)text
        score:(int)score
{
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.img_path]]];
    self.goodsTitleLbl.text = model.goods_name;
    self.goodsPriceLbl.text = model.goods_price;
    if(image !=nil)
    {
        [self.photoBtn setImage:image forState:UIControlStateNormal];
    }
    else
    {
        [self.photoBtn setImage:[UIImage imageNamed:@"evaluation_camera"] forState:UIControlStateNormal];
    }
    
    if(text !=nil)
    {
        self.goodsDesripeTField.text = text;
    }
    else
    {
        self.goodsDesripeTField.text = @"";
    }
    //打分星星
    [self.starView setViewWithScore:score canscore:@"1"];
//    self.starView.
}

-(void)configWithModel:(SeeModel *)model
{
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.img_path]]];
    self.goodsTitleLbl.text = model.goods_name;
    self.goodsPriceLbl.text = model.goods_price;
    self.goodsDesripeTField.text = model.content;
    self.goodsDesripeTField.userInteractionEnabled = NO;
    [self.photoBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIMIDDLEImage,model.pics]] forState:UIControlStateNormal];
    [self.starView setViewWithScore:[model.score intValue]canscore:@"0"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
