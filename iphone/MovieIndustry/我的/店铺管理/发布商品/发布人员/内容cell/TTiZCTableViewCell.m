//
//  TTiZCTableViewCell.m
//  发布页面
//
//  Created by 童乐 on 16/3/29.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "TTiZCTableViewCell.h"

@implementation TTiZCTableViewCell

- (instancetype)initWithTableView:(UITableView *)tableView{
      static NSString *ID = @"cell";
    UINib * nib = [UINib nibWithNibName:@"TTiZCTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:ID];
    return  [tableView dequeueReusableCellWithIdentifier:ID];
}

@end
