//
//  NewMessageCell.h
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/1.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewMessageCell;
@protocol NewMessageCellDelegate <NSObject>

- (void) NewMessageCell:(NewMessageCell *) newMsgCell btn:(UIButton *) btn;

@end
@interface NewMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *FilmTimeNewMsgContentV;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (nonatomic, weak) id <NewMessageCellDelegate> delegate;


@end
