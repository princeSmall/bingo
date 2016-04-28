//
//  OrderTICommentCell.h
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/19.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderGoodsModel.h"
#import "StarView.h"
#import "SeeModel.h"

@interface OrderTICommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;//图片
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLbl;//商品名
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLbl;//商品价格

@property (weak, nonatomic) IBOutlet UITextView *goodsDesripeTField;//商品描述textView
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;//选择图片按钮
@property (weak, nonatomic) IBOutlet UILabel *textLbl;//描述lbl
/**
 *  星星View
 */
@property (nonatomic ,strong) StarView *starView;
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
        score:(int)score;

-(void)configWithModel:(SeeModel *)model;
@end
