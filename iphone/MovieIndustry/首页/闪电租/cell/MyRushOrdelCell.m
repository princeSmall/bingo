//
//  MyRushOrdelCell.m
//  MovieIndustry
//
//  Created by Hopkins Patrick on 3/1/16.
//  Copyright © 2016 MovieIndustry. All rights reserved.
//

#import "MyRushOrdelCell.h"

@implementation MyRushOrdelCell

- (void)awakeFromNib {
    // Initialization code
    self.pointView.layer.cornerRadius = 4.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
