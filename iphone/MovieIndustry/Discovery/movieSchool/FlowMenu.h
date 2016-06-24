//
//  FlowMenu.h
//  MovieIndustry
//
//  Created by 童乐 on 16/3/11.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieClassesController;
@interface FlowMenu : UIView
@property (nonatomic,strong)NSArray * vcArray;
@property (nonatomic, strong) MovieClassesController *fatherController;
- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)viewControllers;
@end
