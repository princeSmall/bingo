//
//  PayWayCell.h
//  MovieIndustry
//
//  Created by 童乐 Patrick on 3/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayWayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;
@property (weak, nonatomic) IBOutlet UILabel *payWayLbl;
@property (weak, nonatomic) IBOutlet UILabel *payBottomLbl;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
