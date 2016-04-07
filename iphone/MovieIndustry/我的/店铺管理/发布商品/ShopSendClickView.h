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

@property (nonatomic,strong)UIButton * button1;
//顺风送货
@property (nonatomic,strong)UIButton * button2;
//申通送货
@property (nonatomic,strong)UIButton * button3;

@property (nonatomic,strong)NSString * line;

- (instancetype)initWithFrame:(CGRect)frame AndClickBlock:(ClickBlock)block;

@end
