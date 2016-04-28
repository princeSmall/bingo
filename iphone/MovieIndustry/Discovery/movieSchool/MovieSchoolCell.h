//
//  MovieSchoolCell.h
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/9.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieSchoolCell;
@protocol MovieSchoolCellDelegate <NSObject>

- (void) MovieNewsCell:(MovieSchoolCell *) cell movieNewsBtn:(UIButton *) btn;
- (void) MovieNewsCell:(MovieSchoolCell *) cell movieClassBtn:(UIButton *) btn;
@end
@interface MovieSchoolCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *movieNewsBtn;
@property (weak, nonatomic) IBOutlet UIButton *movieClassBtn;
@property (nonatomic, weak) id<MovieSchoolCellDelegate> delegate;


@end
