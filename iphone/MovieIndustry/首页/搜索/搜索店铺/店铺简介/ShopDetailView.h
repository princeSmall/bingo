//
//  ShopDetailView.h
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/19.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailView : UIView

@property (weak, nonatomic) IBOutlet UITextView *shopDescTextView;

@property (weak, nonatomic) IBOutlet UILabel *shopCreateTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

///星星评价View
@property (weak, nonatomic) IBOutlet UIView *startView;



@end
