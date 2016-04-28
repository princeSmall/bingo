//
//  MyTableViewCell.h
//  烦恼光
//
//  Created by aaa on 16/1/29.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EndBlock)(NSString * qs);

@interface MyTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *kamoLabel;
@property (strong, nonatomic) UILabel *lineLabel;

@property (weak, nonatomic) IBOutlet UILabel *whichTime;
@property (weak, nonatomic) IBOutlet UILabel *howMany;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

- (instancetype)initWithTableView:(UITableView *)tableView;

- (void)CreateCameLabelWithPrice:(NSString *)price;

//创建划线label
- (void)CreateCameLabelWithLine:(NSString *)price;
//创建共五件 label
- (void)CreateCountLabel:(NSString *)count;
//多少人抢购成功
- (void)CreateHowManyPeople:(NSString *)count;
//点击事件的传出
- (void)SetQishu:(NSString *)qs AndPeopleJoinCount:(NSString *)pj AndEndTime:(NSString *)endtime AndEndBlock:(EndBlock)block;
@end
