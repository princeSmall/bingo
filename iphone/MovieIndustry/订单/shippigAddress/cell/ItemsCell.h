//
//  ItemsCell.h
//  TTIChooseAddress
//
//  Created by 童乐 Patrick on 3/31/16.
//  Copyright © 2016 EC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameStringLbl;


-(instancetype)initWithTableView:(UITableView *)tableView
                       indexpath:(NSIndexPath *)indexpath;
@end
