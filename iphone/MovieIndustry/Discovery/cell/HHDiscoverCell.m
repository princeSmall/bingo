//
//  HHDiscoverCell.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/8.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "HHDiscoverCell.h"

@implementation HHDiscoverCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype) HHDiscoverCellWithTableView:(UITableView *) tableView {
    static NSString *ID = @"discoverCell";
    HHDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HHDiscoverCell" owner:nil options:nil ] lastObject];
    }

    return cell;
}
@end
