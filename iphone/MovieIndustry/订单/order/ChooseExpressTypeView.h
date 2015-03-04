//
//  ChooseExpressTypeView.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/25.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseExpressTypeView : UIView

@property (nonatomic,strong) UIButton *topBtn;
@property (nonatomic,strong) UIButton *midleBtn;
@property (nonatomic,strong) UIButton *bottomBtn;

- (void)show;
///点击按钮时移除视图
- (void)removeTapGesAction;

@end
