//
//  MovieCommentSecondCell.h
//  MovieIndustry
//
//  Created by 猫爷MACIO on 15/11/18.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCommentSecondCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *goodBtn1;
@property (strong, nonatomic) IBOutlet UIButton *goodBtn2;

@property (strong, nonatomic) IBOutlet UIButton *mediumBtn1;
@property (strong, nonatomic) IBOutlet UIButton *mediumBtn2;

@property (strong, nonatomic) IBOutlet UIButton *barelyBtn1;
@property (strong, nonatomic) IBOutlet UIButton *barelyBtn2;


@property (strong, nonatomic) IBOutlet UITextView *textView;


@property (strong, nonatomic) IBOutlet UIButton *cameraBtn;

@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) IBOutlet UIImageView *image3;


@property (strong, nonatomic) IBOutlet UIView *imageBg1;
@property (strong, nonatomic) IBOutlet UIView *imageBg2;
@property (strong, nonatomic) IBOutlet UIView *imageBg3;



@end
