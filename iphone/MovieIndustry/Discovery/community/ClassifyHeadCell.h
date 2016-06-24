//
//  ClassifyHeadCell.h
//  MovieIndustry
//
//  Created by 童乐 on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassifyHeadCell;
@protocol ClassifyHeadCellDelegate <NSObject>

- (void) ClassifyHeadCell:(ClassifyHeadCell *) cell postingBtn:(UIButton *) btn;

@end
@interface ClassifyHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *postingBtn;
@property (nonatomic, weak) id <ClassifyHeadCellDelegate> delegate;


@end
