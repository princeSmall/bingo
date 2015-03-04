//
//  PassGrapTableViewCell.m
//  MovieIndustry
//
//  Created by aaa on 16/1/28.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "PassGrapTableViewCell.h"

@interface PassGrapTableViewCell ()
//第多少期
//@property (weak, nonatomic) IBOutlet UILabel *indexCoutLabel;
////多少人参加
//@property (weak, nonatomic) IBOutlet UILabel *personCount;
////发生的时间
//@property (weak, nonatomic) IBOutlet UILabel *timelabel;
////标题
//@property (weak, nonatomic) IBOutlet UILabel *titleName;
////咖么价
//@property (weak, nonatomic) IBOutlet UILabel *kamoMoney;
////标价
//
//@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
////工多少件
//@property (weak, nonatomic) IBOutlet UILabel *countNumL;
////5人抢购成功
//@property (weak, nonatomic) IBOutlet UILabel *personGarpS;

@end





@implementation PassGrapTableViewCell

- (instancetype)initWithTableView:(UITableView *)tableView;{

    static NSString * cellIdentify = @"cell";
      PassGrapTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
        if(cell == nil){
    
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PassGrapTableViewCell" owner:nil options:nil]lastObject];
        }
    return cell;

}

//抢购详情按钮
- (IBAction)buttonAction:(id)sender {
}



@end
