//
//  PayOrderBottomView.h
//  MovieIndustry
//
//  Created by Hopkins Patrick on 3/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PayOrderBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *shipAddressLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *dealPriceLbl;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (nonatomic,strong)UITableView *tableView;
/**
 *  创建tableview
 */
-(void)createMyTableView;
@end
