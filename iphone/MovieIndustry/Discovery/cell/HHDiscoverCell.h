//
//  HHDiscoverCell.h
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/8.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHDiscoverCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
+(instancetype) HHDiscoverCellWithTableView:(UITableView *) tableView;
@end
