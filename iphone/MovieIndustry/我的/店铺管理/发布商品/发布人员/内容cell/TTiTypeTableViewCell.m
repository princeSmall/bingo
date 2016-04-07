//
//  TTiTypeTableViewCell.m
//  发布页面
//
//  Created by aaa on 16/3/29.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "TTiTypeTableViewCell.h"

@implementation TTiTypeTableViewCell

- (instancetype)initWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    UINib * nib = [UINib nibWithNibName:@"TTiTypeTableViewCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:ID];
    return  [tableView dequeueReusableCellWithIdentifier:ID];
}

@end
