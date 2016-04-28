//
//  BtnSelectView.h
//  ButtonSelectView
//
//  Created by aaa on 16/1/25.
//  Copyright © 2016年 pengPL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EndBlock)(int arrayIndex);

@interface BtnSelectView : UIView

- (instancetype)initWithFrame:(CGRect)frame AndArray:(NSArray *)array AndClickBlock:(EndBlock)block;


@end
