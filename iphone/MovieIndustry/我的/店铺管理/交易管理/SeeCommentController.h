//
//  SeeCommentController.h
//  MovieIndustry
//
//  Created by baokuanxun on 16/4/20.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDataModel.h"

@interface SeeCommentController : BaseViewController

@property (nonatomic ,strong)OrderDataModel *orderModel;

@property (nonatomic ,strong)NSString *order_id;

@end
