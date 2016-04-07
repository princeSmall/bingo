//
//  TTIChooseCell.h
//  kamefengzhuang
//
//  Created by Hopkins Patrick on 3/29/16.
//  Copyright © 2016 EC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^changeOn)(UISwitch * number);

@interface TTIChooseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;

@property (weak, nonatomic) IBOutlet UILabel *itemLbl;
@property (nonatomic ,copy)changeOn changeOn;

-(instancetype)initWithTableView:(UITableView *)tableView ;
-(void)inputWithString:(NSString *)string;
@end
