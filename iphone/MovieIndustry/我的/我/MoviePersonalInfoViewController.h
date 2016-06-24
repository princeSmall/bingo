//
//  MoviePersonalInfoViewController.h
//  个人中心页面
//
//  Created by 童乐 on 16/3/31.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDesModel.h"

typedef void (^BackBlock)(BOOL isChange);

@interface MoviePersonalInfoViewController : BaseViewController

@property (nonatomic,strong)UserDesModel * model;

@property (nonatomic,strong)NSData * headImageData;

@property (nonatomic,strong)BackBlock block;

@end
