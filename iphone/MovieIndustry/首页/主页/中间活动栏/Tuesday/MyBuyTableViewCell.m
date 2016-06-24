//
//  MyBuyTableViewCell.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MyBuyTableViewCell.h"

@interface MyBuyTableViewCell ()
//日期label eg 2015/07/30
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//活动进行中label
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
//产品名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//产品数量 eg 共3件
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
//等级 eg v13
@property (weak, nonatomic) IBOutlet UILabel *LVlabel;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
//抢购中label
@property (weak, nonatomic) IBOutlet UILabel *buyingLabel;
//时间label
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//价格label eg共1件商品 合计：￥1.00
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end


@implementation MyBuyTableViewCell

- (void)awakeFromNib{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:@"http://gtb.baidu.com/HttpService/get?p=dHlwZT1pbWFnZS9qcGVnJm49dmlzJnQ9YWRpbWcmYz10YjppZyZyPTk4Mzc5Mjg4MCw5MzIwNjU2MDc童乐A"]];
    self.iconImage.backgroundColor = [UIColor greenColor];
    self.iconImage.layer.cornerRadius = 30;
    self.iconImage.clipsToBounds = YES;
    self.iconImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.iconImage.layer.borderWidth = 2;
    self.LVlabel.layer.cornerRadius = 6;
    self.LVlabel.layer.masksToBounds = YES;
}

- (instancetype)initWithTableView:(UITableView *)tableView{

    static NSString * cellIdentify = @"cell";
    MyBuyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyBuyTableViewCell" owner:self options:nil]lastObject];
    }
    
    return cell;
}

- (void)ChangeActivityLabelWithType:(NSString *)type{
    if ([type isEqualToString:@"0"]) {
        //活动进行中
        self.activityLabel.text = @"活动进行中";
        self.activityLabel.textColor = [UIColor orangeColor];
    }
    if ([type isEqualToString:@"1"]) {
        self.activityLabel.text = @"活动已结束";
        self.activityLabel.textColor = [UIColor darkGrayColor];
    }

}

- (void)ChangeBuyingLabelWithString:(NSString *)type{

    if ([type isEqualToString:@"0"]) {
        self.buyingLabel.text = @"抢购中";
        self.buyingLabel.textColor = [UIColor orangeColor];
    }
    if ([type isEqualToString:@"1"]) {
        self.buyingLabel.text = @"抢购成功";
        self.buyingLabel.textColor = [[UIColor alloc]initWithRed:200/255.0 green:0 blue:0 alpha:1.0];
    }
    if ([type isEqualToString:@"2"]) {
        self.buyingLabel.text = @"抢购失败";
        self.buyingLabel.textColor = [UIColor darkGrayColor];
    }


}


@end
