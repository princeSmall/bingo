//
//  HHMTableViewCell.h
//  个人中心页面
//
//  Created by 童乐 on 16/3/31.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHMTableViewCell : UITableViewCell
- (instancetype)initWithTableView:(UITableView *)tableView;

- (void)SetTitle:(NSString *)string AndIcon:(UIImage *)image;
- (void)SettitleContent:(NSString *)string;
@end
