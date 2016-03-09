//
//  MovieCircle_KeyboardToolBar.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "MovieCircle_KeyboardToolBar.h"

@implementation MovieCircle_KeyboardToolBar

+(instancetype) initKeyboardToolBar {
    return [[[NSBundle mainBundle] loadNibNamed:@"MovieCircle_KeyboardToolBar" owner:nil options:nil] lastObject];
}

@end
