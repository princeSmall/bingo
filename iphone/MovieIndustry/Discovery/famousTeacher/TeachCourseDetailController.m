//
//  TeachCourseDetailController.m
//  MovieIndustry
//
//  Created by 石冬冬 on 16/3/2.
//  Copyright © 2016年 MovieIndustry. All rights reserved.
//

#import "TeachCourseDetailController.h"
#import "TeacherCoures_AboutArticleCell.h"
#import "WMPlayer.h"
#import "BottomInputView.h"
@interface TeachCourseDetailController () <UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    WMPlayer *wmPlayer;
    CGRect playerFrame;
}

@property (weak, nonatomic) IBOutlet UIView *mediaPlayerContentV;
/**视屏封面*/
@property (weak, nonatomic) IBOutlet UIImageView *mediaPlayerImageV;
@property (nonatomic,strong) UIView *bottomView;
/**视屏播放按钮*/
@property (nonatomic, strong) UIButton *playBtn;
/**视屏时间长度*/
@property (nonatomic, strong) UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoContentVCT;
@property (weak, nonatomic) IBOutlet UIView *videoContentV;

@end
//最后一行分隔线顶头显示
static void setLastCellSeperatorToLeft(UITableViewCell* cell)
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}
@implementation TeachCourseDetailController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, self.view.frame.size.height,self.view.frame.size.width);
    
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view.frame.size.width-40);
        make.width.mas_equalTo(self.view.frame.size.height);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmPlayer).with.offset((-self.view.frame.size.height/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
        
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    wmPlayer.isFullscreen = YES;
    wmPlayer.fullScreenBtn.selected = YES;
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
    
}
-(void)toNormal{
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = self.mediaPlayerContentV.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [self.mediaPlayerContentV addSubview:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
        }];
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
        
    }];
}
-(void)fullScreenBtnClick:(NSNotification *)notice{
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        [self toNormal];
    }
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (wmPlayer.isFullscreen) {
                [self toNormal];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            if (wmPlayer.isFullscreen == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            if (wmPlayer.isFullscreen == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        default:
            break;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTabBar:@"名师课堂"];
    [self creatUI];
    self.view.backgroundColor = [UIColor whiteColor];

    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
}

- (void) creatUI {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.mediaPlayerContentV.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(50);
    }];
    
    _playBtn = [[UIButton alloc] init];
    [_mediaPlayerImageV addSubview:_playBtn];
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_mediaPlayerImageV.mas_centerX);
        make.centerY.equalTo(_mediaPlayerImageV.mas_centerY);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80);
    }];
    [_playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(playMovie) forControlEvents:UIControlEventTouchUpInside];
    _timeLbl = [[UILabel alloc] init];
    [_mediaPlayerImageV addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_mediaPlayerImageV.mas_right).offset(-15);
        make.bottom.equalTo(_mediaPlayerImageV.mas_bottom).offset(-10);
    }];
    _timeLbl.text = @"10:12";
    _timeLbl.textColor = [UIColor whiteColor];
    _timeLbl.font = [UIFont systemFontOfSize:15];
    
    
    BottomInputView *bottomInputV = [[BottomInputView alloc] init];
    [self.view addSubview:bottomInputV];
}


-(void)playMovie{
    [self.mediaPlayerImageV removeFromSuperview];
    playerFrame = self.mediaPlayerContentV.bounds;
    wmPlayer = [[WMPlayer alloc]initWithFrame:playerFrame videoURLStr:@"http://baobab.cdn.wandoujia.com/14468618701471.mp4"];
    wmPlayer.closeBtn.hidden = YES;
    [self.mediaPlayerContentV addSubview:wmPlayer];
    [wmPlayer.player play];
}
-(void)releaseWMPlayer{
    [wmPlayer.player.currentItem cancelPendingSeeks];
    [wmPlayer.player.currentItem.asset cancelLoading];
    
    [wmPlayer.player pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer = nil;
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
}

-(void)dealloc{
    [self releaseWMPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"player deallco");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 15;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *Id = @"aboutArticleCell";
    TeacherCoures_AboutArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TeacherCoures_AboutArticleCell" owner:nil options:nil] lastObject];
    }
    setLastCellSeperatorToLeft(cell);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
        UIView *hView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 26)];
        hView.backgroundColor = kViewBackColor;
        UILabel *label = [WNController createLabelWithFrame:CGRectMake(6,3,128, 21) Font:15 Text:@"相关文章" textAligment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1];
        [hView addSubview:label];
        return hView;
 
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
float lastContentOffset;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (lastContentOffset < scrollView.contentOffset.y) {
       
        [UIView animateWithDuration:0.5 animations:^{
            self.videoContentVCT.constant = 0;
            [self.videoContentV layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.videoContentVCT.constant = 363;
            [self.videoContentV layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
