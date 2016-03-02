//
//  ShopSendClickView.h
//  商家送货按钮事件处理view
//
//  Created by aaa on 16/1/26.
//  Copyright © 2016年 pengPL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBlock)(NSString *possType);


@interface ShopSendClickView : UIView

@property (nonatomic,strong)NSString * line;

- (instancetype)initWithFrame:(CGRect)frame AndClickBlock:(ClickBlock)block;

@end
