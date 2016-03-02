//
//  JGCoverView.h
//  选择城市按钮demo
//
//  Created by aaa on 16/1/21.
//  Copyright © 2016年 aaa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^SelectBlock)(NSString * string);

@interface JGCoverView : UIView

- (instancetype)initWithFrame:(CGRect)frame And:(NSArray *)sourceArray And:(SelectBlock)block;

@end
