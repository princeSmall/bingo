//
//  JGSecondCoverView.h
//  MovieIndustry
//
//  Created by aaa on 16/2/19.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^SelectBlock)(NSString * string);

@interface JGSecondCoverView : UIView
- (instancetype)initWithFrame:(CGRect)frame And:(NSArray *)sourceArray WithBlock:(SelectBlock)block;
@property (nonatomic,strong)UITableView *myTableView;
@end
