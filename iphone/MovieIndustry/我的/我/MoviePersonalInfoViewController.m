//
//  MoviePersonalInfoViewController.m
//  个人中心页面
//
//  Created by 童乐 on 16/3/31.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "MoviePersonalInfoViewController.h"
#import "UIImage+Blur.h"
#import "DeliveryUtility.h"
#import "HHMTableViewCell.h"
#import "SysTool.h"
#import "MoviePersonInfoTableViewCell.h"
@interface MoviePersonalInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  顶部视图
 */
@property (nonatomic,strong)UIView * headView;
/**
 *  TableView视图
 */
@property (nonatomic,strong)UITableView * mainTableView;

@property (nonatomic,strong)UIImageView * backImageView;
@property (nonatomic,strong)UIImageView * headImage;
//姓名
@property (nonatomic,strong)NSString * nameString;
//职称
@property (nonatomic,strong)NSString * desString;
//粉丝
@property (nonatomic,strong)NSString * fansString;
@property (nonatomic,strong)UILabel * fans;
//关注
@property (nonatomic,strong)NSString * noticeString;
@property (nonatomic,strong)UILabel * notices;
//积分
@property (nonatomic,strong)NSString * countString;
@property (nonatomic,strong)UILabel * counts;


//底部输入参数

@property (nonatomic,strong)NSString * nameStr;
@property (nonatomic,strong)NSString * sexStr;
@property (nonatomic,strong)NSString * jobStr;
@property (nonatomic,strong)NSString * addressStr;
@property (nonatomic,strong)NSString * phoneStr;
@property (nonatomic,strong)NSString * scWorkPlaceStr;

@property (nonatomic,strong)UIImage * postImage;

@property (nonatomic,strong)UILabel * labelzc;

@property (nonatomic,assign)CGRect tableRect;

@end

@implementation MoviePersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setNavTabBar:@"个人信息"];
    
    if (self.model.nickname) {
        self.nameStr = self.model.nickname;
    }else{
      
    }
    self.sexStr = self.model.sex;
    self.phoneStr = self.model.mobile;
    self.jobStr = self.model.job;
    self.addressStr = self.model.address;
    self.scWorkPlaceStr = self.model.com_name;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.918 alpha:1.000];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self CreateHeadView];
    [self CreateIconAndLv];
    [self CreateMainTableView];
    /**
     *  下面方法是在请求到数据后才调用的
     */
    [self CreateNameAndDesLabel];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    self.mainTableView.frame = newTextViewFrame;
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
     self.mainTableView.frame = CGRectMake(0, CGRectGetMaxY(self.headView.frame)+1, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.headView.frame));
    
    [UIView commitAnimations];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.view endEditing:YES];
}


- (void)CreateMainTableView{
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+1, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(self.headView.frame))];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.backgroundColor = [UIColor clearColor];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TAPsssss)];
    [self.mainTableView addGestureRecognizer:tap];
    
    self.tableRect = self.mainTableView.frame;
    [self CreateFootView];
}

- (void)TAPsssss{

    [self.view endEditing:YES];
}



- (void)CreateFootView{
    UIView * viewFoot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 55)];
    self.mainTableView.tableFooterView = viewFoot;
    UIButton * buttonSure = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20 , 45)];
    [buttonSure setTitle:@"确认" forState:UIControlStateNormal];
    [buttonSure setTitleColor:[UIColor colorWithRed:0.271 green:0.275 blue:0.275 alpha:1.000] forState:UIControlStateNormal];
    buttonSure.titleLabel.font = [UIFont systemFontOfSize:18];
    [buttonSure addTarget:self action:@selector(SureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    buttonSure.layer.cornerRadius = 4;
    buttonSure.layer.masksToBounds = YES;
    buttonSure.backgroundColor = [UIColor whiteColor];
    [viewFoot addSubview:buttonSure];
}

- (void)SureBtnClick{
    NSLog(@"确认按钮被点击");
    [self.view endEditing:YES];
    if (!self.nameStr) {
        self.nameStr = @"";
    }
    if (!self.sexStr) {
        self.sexStr = @"";
    }
    if (!self.jobStr) {
        self.jobStr = @"";
    }
    if (!self.addressStr) {
        self.addressStr = @"";
    }
    if (!self.phoneStr) {
        /**
         *  这边手机号码是不能随意修改的，只能看
         */
        self.phoneStr = @"15890268277";
    }
    if (!self.scWorkPlaceStr) {
        self.scWorkPlaceStr = @"";
    }
    
    if (self.postImage) {
        
        //上传图片
        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在修改个人信息";
        [HUD show:YES];
        CGFloat i = self.postImage.size.width/400;
        UIImage * postImage = [DeliveryUtility imageWithImageSimple:self.postImage scaledToSize:CGSizeMake(self.postImage.size.width/i, self.postImage.size.height/i)];
        NSData * imageData = UIImagePNGRepresentation(postImage);
        [UserDesModel GetUploadImageDictWithData:imageData WithType:@"1" With:^(NSString *string) {
            if ([string isEqualToString:@"F"]) {
                HUD.labelText = @"图片上传失败";
                [HUD hide:YES];
            }else{
                NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                dict[@"user_id"] = APP_DELEGATE.user_id;
                dict[@"nickname"] = self.nameStr;
                dict[@"sex"] = self.sexStr;
                dict[@"mobile"] = self.phoneStr;
                dict[@"img"] = string;
                dict[@"full"] = @"0";
                dict[@"is_full"] = @"0";
                dict[@"job"] = self.jobStr;
                dict[@"address"] = self.addressStr;
                dict[@"com_name"] = self.scWorkPlaceStr;
                
                [HttpRequestServers requestBaseUrl:TIPerson_UpdateUser withParams:dict withRequestFinishBlock:^(id result) {
                    NSDictionary * dict = result;
                    if ([dict[@"code"] intValue] == 0) {
                        HUD.labelText = @"修改成功";
                        [HUD hide:YES afterDelay:1.0];
                        self.block(YES);
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                } withFieldBlock:^{
                    HUD.labelText = @"修改失败";
                    [HUD hide:YES];
                }];
            }
        }];
        
    }else{
        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"正在修改个人信息";
        [HUD show:YES];
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"user_id"] = APP_DELEGATE.user_id;
        dict[@"nickname"] = self.nameStr;
        dict[@"sex"] = self.sexStr;
        dict[@"mobile"] = self.model.mobile;
        dict[@"full"] = @"0";
        dict[@"is_full"] = @"0";
        if(self.model.img.length > 5){
            dict[@"img"] =self.model.img;
        }else{
           dict[@"img"] =@"2313.jpg";
        }

        
        dict[@"job"] = self.jobStr;
        dict[@"address"] = self.addressStr;
        dict[@"com_name"] = self.scWorkPlaceStr;
        [HttpRequestServers requestBaseUrl:TIPerson_UpdateUser withParams:dict withRequestFinishBlock:^(id result) {
            NSDictionary * dict = result;
            if ([dict[@"code"] intValue] == 0) {
                HUD.labelText = @"修改成功";
                [HUD hide:YES afterDelay:1.0];
                self.block(YES);
                [self.navigationController popViewControllerAnimated:YES];
            }
        } withFieldBlock:^{
            HUD.labelText = @"修改失败";
            [HUD hide:YES];
        }];
    }
}






- (void)CreateNameAndDesLabel{
    /**
     *  之前的时候 要给fansS等 赋值。
     */
    
    if (self.model.nickname) {
        self.nameString = self.model.nickname;
    }else{
        self.nameString = self.model.mobile;
    }
    self.desString = self.model.job;
    self.fansString = @"0";
    self.noticeString = @"0";
    self.countString = @"0";
    //姓名
    UIFont * font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    CGSize nameSize = [DeliveryUtility caculateContentSizeWithContent:self.nameString andHight:MAXFLOAT andWidth:MAXFLOAT andFont:font];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImage.frame) + 30, _headImage.frame.origin.y, nameSize.width, nameSize.height)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = font;
    nameLabel.text = self.nameString;
    [self.headView addSubview:nameLabel];
    //竖线
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+10, nameLabel.frame.origin.y, 0.7, nameLabel.frame.size.height)];
    lineLabel.backgroundColor = [UIColor whiteColor];
    
    if ([self.model.job isEqualToString:@""]) {
        [self.labelzc removeFromSuperview];
    }else{
    
    [self.headView addSubview:lineLabel];
    //职称
    CGSize ZCSize = [DeliveryUtility caculateContentSizeWithContent:self.nameString andHight:MAXFLOAT andWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:15]];
    UILabel * labelZC = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineLabel.frame) +10, CGRectGetMaxY(nameLabel.frame)-ZCSize.height, [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(lineLabel.frame)-30, ZCSize.height)];
    labelZC.textColor = [UIColor whiteColor];
    labelZC.font = [UIFont systemFontOfSize:15];
    labelZC.text = self.desString;
    [self.headView addSubview:labelZC];
        self.labelzc = labelZC;
    }
    self.fans.text = self.fansString;
    self.notices.text = self.noticeString;
    self.counts.text = self.countString;
    if (self.headImageData) {
    self.headImage.image = [UIImage imageWithData:self.headImageData];
    self.backImageView.image = [[UIImage imageWithData:self.headImageData] blurredImage:0.5];
    }
}


- (void)CreateHeadView{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/2 - 40)];
    UIImageView * BackGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    BackGroundImageView.center = headView.center;
    UIImage * backImage = [UIImage imageNamed:@"testImage.jpg"];
    BackGroundImageView.image = [backImage blurredImage:0.5];
    self.backImageView = BackGroundImageView;
    BackGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [headView addSubview:BackGroundImageView];
    headView.layer.masksToBounds = YES;
    [self.view addSubview:headView];
    self.headView = headView;
}

- (void)IconClickAction{
    
    [[SysTool ShareTool]ShowActionSheetInViewController:self AndChoseBlock:^(UIImage *img, NSData *data) {
        self.postImage = img;
        self.headImage.image = img;
        self.headImageData = data;
        }];
    
}



- (void)CreateIconAndLv{
    //头像
    UIImageView * headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10,([UIScreen mainScreen].bounds.size.width/2 - 30 -  [UIScreen mainScreen].bounds.size.width/4 + 10)/2 ,  [UIScreen mainScreen].bounds.size.width/4 - 10,  [UIScreen mainScreen].bounds.size.width/4 - 10)];
    headerImage.image = [UIImage imageNamed:@"defualt_headerImg"];
    headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
    headerImage.layer.borderWidth = 2;
    headerImage.layer.cornerRadius = ([UIScreen mainScreen].bounds.size.width/4 - 10)/2;
    headerImage.layer.masksToBounds = YES;
    headerImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headImage = headerImage;
    [self.headView addSubview:headerImage];
    
    //头像按钮
    UIButton * iconBtn = [[UIButton alloc]initWithFrame:self.headImage.frame];
    [iconBtn addTarget:self action:@selector(IconClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:iconBtn];
    //等级
    UILabel * lvLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImage.frame)-25, CGRectGetMaxY(headerImage.frame)- 16, 35, 16)];
    lvLabel.backgroundColor = [UIColor colorWithRed:0.976 green:0.408 blue:0.047 alpha:1.000];
    lvLabel.textColor = [UIColor whiteColor];
    lvLabel.text = @"V1";
    lvLabel.font = [UIFont systemFontOfSize:16];
    lvLabel.layer.cornerRadius = 8;
    lvLabel.layer.masksToBounds = YES;
    lvLabel.textAlignment = 1;
//    [self.headView addSubview:lvLabel];
    
    //粉丝
    CGSize fansSize = [DeliveryUtility caculateContentSizeWithContent:@"粉丝：" andHight:MAXFLOAT andWidth:MAXFLOAT andFont:[UIFont systemFontOfSize:15]];
    UILabel * fansLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImage.frame) + 30, CGRectGetMaxY(self.headImage.frame) - self.headImage.frame.size.height/2 - fansSize.height/2, fansSize.width, fansSize.height)];
    fansLabel.textColor = [UIColor whiteColor];
    fansLabel.font = [UIFont systemFontOfSize:15];
    fansLabel.text = @"粉丝：";
    [self.headView addSubview:fansLabel];
    
    UILabel * fans = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fansLabel.frame), fansLabel.frame.origin.y, 60, fansSize.height)];
    fans.textColor = [UIColor whiteColor];
    fans.font = [UIFont systemFontOfSize:15];
    fans.text = @"0";
    self.fans = fans;
    [self.headView addSubview:self.fans];
    //关注
    UILabel * noticeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fans.frame), fans.frame.origin.y, fansSize.width, fansSize.height)];
    noticeLabel.textColor = [UIColor whiteColor];
    noticeLabel.font = [UIFont systemFontOfSize:15];
    noticeLabel.text = @"关注：";
    [self.headView addSubview:noticeLabel];
    
    UILabel * notices = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noticeLabel.frame), fans.frame.origin.y, 60, fansSize.height)];
    notices.textColor = [UIColor whiteColor];
    notices.font = [UIFont systemFontOfSize:15];
    notices.text = @"0";
    self.notices = notices;
    [self.headView addSubview:notices];
    //积分
    UILabel * countLabel = [[UILabel alloc]initWithFrame:CGRectMake(fansLabel.frame.origin.x,CGRectGetMaxY(self.headImage.frame) - fansSize.height, fansSize.width, fansSize.height)];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.text = @"积分：";
    countLabel.font = [UIFont systemFontOfSize:15];
    [self.headView addSubview:countLabel];
    
    UILabel * counts = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(countLabel.frame), countLabel.frame.origin.y, 60, fansSize.height)];
    counts.textColor = [UIColor whiteColor];
    counts.font = [UIFont systemFontOfSize:15];
    counts.text = @"0";
    self.counts = counts;
    [self.headView addSubview:self.counts];
    
    //积分Button
    UIButton * countsBtn = [[UIButton alloc]initWithFrame:CGRectMake(countLabel.frame.origin.x, countLabel.frame.origin.y, 300, 50)];
    [countsBtn addTarget:self action:@selector(CountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:countsBtn];
}

- (void)CountBtnClick{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 2) {
        return 0;
    }else{
        return 46;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoviePersonInfoTableViewCell * cell = [[MoviePersonInfoTableViewCell alloc]initWithTableView:tableView];
    if (indexPath.row == 0) {
        [cell setTitle:@"昵称：" AndTextFiled:@""];
        cell.myTextfiled.text = self.nameStr;
        cell.block = ^(NSString * string){
            self.nameStr = string;
        };
    }
    if (indexPath.row == 1) {
        [cell setTitle:@"性别" AndTextFiled:@""];
        [cell settextFiledType:@"1"];
       
        if ([self.sexStr isEqualToString:@"0"]) {
            cell.girlBtn.selected = YES;
        }else if([self.sexStr isEqualToString:@"1"]){
            cell.boyBtn.selected = YES;
        }
        
        cell.block = ^(NSString * string){
            self.sexStr = string;
        };
    }
    if (indexPath.row == 2) {
        /**
         *  这边暂时不显示这个页面
         包括之前的frame 高度也修改为0
         */
//        cell = nil;
        [cell.contentView removeFromSuperview];
//        [cell setTitle:@"认证会员" AndTextFiled:@""];
//        [cell settextFiledType:@"2"];
    }
    
    if (indexPath.row == 3) {
        [cell setTitle:@"职业身份：" AndTextFiled:self.jobStr];
        cell.block = ^(NSString * string){
            self.jobStr = string;
        };
    }
    if (indexPath.row == 4) {
        [cell setTitle:@"我的地址：" AndTextFiled:self.addressStr];
        cell.block = ^(NSString * string){
            self.addressStr = string;
        };
    }
    if (indexPath.row == 5) {
        [cell setTitle:@"手机号码：" AndTextFiled:self.phoneStr];
        cell.myTextfiled.text = self.model.mobile;
        [cell settextFiledType:nil];
        cell.myTextfiled.userInteractionEnabled = NO;
        cell.block = ^(NSString * string){
            self.phoneStr = string;
        };
    }
    if (indexPath.row == 6) {
        [cell setTitle:@"学校/单位：" AndTextFiled:self.scWorkPlaceStr];
        cell.block = ^(NSString * string){
            self.scWorkPlaceStr = string;
        };
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
