//
//  AreaButton.h
//  选择城市按钮demo
//
//  Created by 童乐 on 16/1/21.
//  Copyright © 2016年 童乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaButton : UIButton
//初始化之后，为了方便再次设置button上面的内容
@property (nonatomic,strong)NSString * buttonTitle;
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame AndString:(NSString *)String;
@end
