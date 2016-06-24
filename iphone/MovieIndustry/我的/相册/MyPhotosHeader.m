//
//  MyPhotosHeader.m
//  MovieIndustry
//
//  Created by 童乐 on 15/11/9.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "MyPhotosHeader.h"

@implementation MyPhotosHeader

- (IBAction)headBtnClicked:(UIButton *)sender {
    [self.delegate MyPhotosHeader:self headBtn:sender];
}

@end
