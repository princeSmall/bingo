//
//  TTiZCTableViewCell.h
//  发布页面
//
//  Created by aaa on 16/3/29.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTiZCTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ZClabel;

@property (weak, nonatomic) IBOutlet UIButton *btnClick;


- (instancetype)initWithTableView:(UITableView *)tableView;

@end
