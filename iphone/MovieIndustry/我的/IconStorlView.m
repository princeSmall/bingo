//
//  IconStorlView.m
//  scroll
//
//  Created by aaa on 16/4/13.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "IconStorlView.h"

#define ImageA [UIImage imageNamed:@"1_"]
#define ImageB [UIImage imageNamed:@"2_"]
#define ImageC [UIImage imageNamed:@"3_"]
#define ImageD [UIImage imageNamed:@"4_"]
@implementation IconStorlView

- (instancetype)initWithFrame:(CGRect)frame AndScore:(int )score{
    if (self = [super initWithFrame:frame]) {
    CGFloat imageW = 18;
    CGFloat imageH = 15;
    CGFloat mar = 5;
    int a = score;
    CGRect f = frame;
    if (a<=1) {
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        [self addSubview:imageV];
        imageV.image = ImageA;
        f.size.width = imageW+10;
        self.frame = f;
    }
    if (a>1&&a<=5) {
        UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        imageV1.image = ImageA;
        UIImageView * imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW+mar, 0, imageW, imageH)];
        imageV2.image = ImageA;
        [self addSubview:imageV1];
        [self addSubview:imageV2];
        f.size.width = imageW*2+15;
        self.frame = f;
    }
    if (a>5&&a<=10) {
        UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        imageV1.image = ImageA;
        UIImageView * imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW + mar, 0, imageW, imageH)];
        imageV2.image = ImageA;
        UIImageView * imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake((imageW+mar)*2, 0, imageW, imageH)];
        imageV3.image = ImageA;
        [self addSubview:imageV1];
        [self addSubview:imageV2];
        [self addSubview:imageV3];
        
        f.size.width = imageW*3+20;
        self.frame = f;

    }
    /**
     *  <#Description#>
     */
    
    if (a>10&&a<=50) {
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        [self addSubview:imageV];
        imageV.image = ImageB;
        f.size.width = imageW+10;
        self.frame = f;

    }
    if (a>50&&a<=200) {
        UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        imageV1.image = ImageB;
        UIImageView * imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW+mar, 0, imageW, imageH)];
        imageV2.image = ImageB;
        [self addSubview:imageV1];
        [self addSubview:imageV2];
        f.size.width = imageW*2+15;
        self.frame = f;
    }
    if (a>200&&a<=500) {
        UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        imageV1.image = ImageB;
        UIImageView * imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW + mar, 0, imageW, imageH)];
        imageV2.image = ImageB;
        UIImageView * imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake((imageW+mar)*2, 0, imageW, imageH)];
        imageV3.image = ImageB;
        [self addSubview:imageV1];
        [self addSubview:imageV2];
        [self addSubview:imageV3];
        
        f.size.width = imageW*3+20;
        self.frame = f;
    }
    /**
     *  <#Description#>
     */
    if (a>500&&a<=1000) {
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        [self addSubview:imageV];
        imageV.image = ImageC;
        f.size.width = imageW+10;
        self.frame = f;
    }
    if (a>1000&&a<=2000) {
        UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        imageV1.image = ImageC;
        UIImageView * imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW+mar, 0, imageW, imageH)];
        imageV2.image = ImageC;
        [self addSubview:imageV1];
        [self addSubview:imageV2];
        
        f.size.width = imageW*2+15;
        self.frame = f;
    }
    if (a>2000&&a<=4000) {
        UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        imageV1.image = ImageC;
        UIImageView * imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW + mar, 0, imageW, imageH)];
        imageV2.image = ImageC;
        UIImageView * imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake((imageW+mar)*2, 0, imageW, imageH)];
        imageV3.image = ImageC;
        [self addSubview:imageV1];
        [self addSubview:imageV2];
        [self addSubview:imageV3];
        f.size.width = imageW*3+20;
        self.frame = f;
    }
    /**
     *  <#Description#>
     */
    if (a>4000&&a<=8000) {
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        [self addSubview:imageV];
        imageV.image = ImageD;
        f.size.width = imageW+10;
        self.frame = f;
    }
    if (a>8000&&a<=16000) {
        UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        imageV1.image = ImageD;
        UIImageView * imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW+mar, 0, imageW, imageH)];
        imageV2.image = ImageD;
        [self addSubview:imageV1];
        [self addSubview:imageV2];
        f.size.width = imageW*2+15;
        self.frame = f;
    }
    if (a>16000) {
        UIImageView * imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, imageH)];
        imageV1.image = ImageD;
        UIImageView * imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageW + mar, 0, imageW, imageH)];
        imageV2.image = ImageD;
        UIImageView * imageV3 = [[UIImageView alloc]initWithFrame:CGRectMake((imageW+mar)*2, 0, imageW, imageH)];
        imageV3.image = ImageD;
        [self addSubview:imageV1];
        [self addSubview:imageV2];
        [self addSubview:imageV3];
        f.size.width = imageW*3+20;
        self.frame = f;
    }
    }
    return self;
}



@end
