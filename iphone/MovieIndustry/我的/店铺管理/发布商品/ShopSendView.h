//
//  ShopSendView.h
//  MovieIndustry
//
//  Created by 童乐 on 16/2/24.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBlock)(NSString *possType);

@interface ShopSendView : UIView

- (instancetype)initWithFrame:(CGRect)frame AndClickBlock:(ClickBlock)block;

- (UIView *)CoverViewShow;


@end
