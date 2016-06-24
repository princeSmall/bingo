//
//  HHMTableViewCell.m
//  个人中心页面
//
//  Created by 童乐 on 16/3/31.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "HHMTableViewCell.h"

@interface HHMTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end


@implementation HHMTableViewCell

- (instancetype)initWithTableView:(UITableView *)tableView{

    static NSString * cellID = @"cell";
    
    HHMTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HHMTableViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}

- (void)SetTitle:(NSString *)string AndIcon:(UIImage *)image{
    self.myLabel.hidden = YES;
    self.myImageView.hidden = NO;
    self.nameLabel.hidden = NO;
    self.myImageView.image = image;
    self.nameLabel.text = string;
}

- (void)SettitleContent:(NSString *)string{
    self.myLabel.hidden = NO;
    self.myImageView.hidden = YES;
    self.nameLabel.hidden = YES;
    self.myLabel.text = string;

}


@end
