//
//  CustomPageControl.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/11.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "CustomPageControl.h"

@implementation CustomPageControl

-(void)setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 10;
        size.width = 10;
        subview.layer.cornerRadius = 5;
        subview.layer.masksToBounds = YES;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,size.width,size.height)];
//        if (subviewIndex == page)
//            [subview setImage:[UIImage imageNamed:@"page_normal.png"]];
//        else
//            [subview setImage:[UIImage imageNamed:@"page_selected.png"]];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
