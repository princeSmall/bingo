//
//  FourTableViewCell.h
//  MovieIndustry
//
//  Created by aaa on 16/3/30.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *myIcon;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@property (weak, nonatomic) IBOutlet UILabel *myPrice;


- (instancetype)initWithTableView:(UITableView *)tableView;


@end
