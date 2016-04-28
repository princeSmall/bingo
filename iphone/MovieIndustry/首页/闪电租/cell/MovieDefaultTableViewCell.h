//
//  MovieDefaultTableViewCell.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDefaultTableViewCell : UITableViewCell


@property (nonatomic,copy) NSString *mainContent;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
