//
//  FourTableViewCell.m
//  MovieIndustry
//
//  Created by 童乐 on 16/3/30.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "FourTableViewCell.h"

@implementation FourTableViewCell

- (instancetype)initWithTableView:(UITableView *)tableView{

    static NSString * cellID = @"cell";
        FourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
        if(cell==nil){
    
            cell = [[[NSBundle mainBundle]loadNibNamed:@"FourTableViewCell" owner:nil options:nil]lastObject];
        }
        return cell;
}

@end
