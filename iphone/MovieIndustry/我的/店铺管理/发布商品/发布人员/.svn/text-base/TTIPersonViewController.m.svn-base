//
//  TTIPersonViewController.m
//  发布页面
//
//  Created by aaa on 16/3/29.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import "TTIPersonViewController.h"
#import "JGAddPictureView.h"
#import "TTIChooseCell.h"
#import "AddPictureTableViewCell.h"
#import "TTIInputCell.h"
#import "TTiZCTableViewCell.h"
#import "TTiTypeTableViewCell.h"
#import "TTIDesTableViewCell.h"
#import "AppDelegate.h"
#import "PublishSecondCategoryController.h"
#import "ChooseCityController.h"

#define VIEW_START_TAG 888888
#define BTN_START_TAG 999999

@interface TTIPersonViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,ChooseCityControllerDelegate>
//tableView
@property (nonatomic,strong)UITableView * myTableView;
@property (nonatomic,strong)AddPictureTableViewCell * cell;

/**
 *  上传字段
 */
@property (nonatomic,strong)UITextField * goods_name;//姓名
@property (nonatomic,strong)UITextField * goods_mobile;//联系方式
@property (nonatomic,strong)UITextField * goods_price;//价格
@property (nonatomic,strong)NSString * imgs;//图片
@property (nonatomic,strong)UITextField * goods_number;//数量
@property (nonatomic,strong)NSString * is_deposit;//是否收押金
@property (nonatomic,strong)UITextField * goods_deposit;//押金
@property (nonatomic,strong)UILabel * goods_category_id;//类型
@property (nonatomic,strong)NSString *goods_category;
@property (nonatomic,strong)UITextField * goods_job;//职称；
@property (nonatomic,strong)UITextField * goods_alone;//特点
@property (nonatomic,strong)UITextView * goods_desc;//描述
/**
 *  还有 咔么价 是否积分抵扣，所在地
 */
@property (nonatomic,strong)NSString * is_deduction;
@property (nonatomic,strong)UITextField * market_price;
@property (nonatomic,strong)UILabel * addressLabel;

@property (nonatomic,strong)TTiTypeTableViewCell * cell9;
@property (nonatomic,strong)TTiTypeTableViewCell * cell10;
/**
 *  图片的处理在这里
 */
@property (nonatomic,strong)NSMutableArray * imgArray;
@property (nonatomic,strong)NSMutableArray * imagePathArray;
@property (nonatomic,strong)NSMutableDictionary * issueDict;
@property (nonatomic,strong)NSArray *arrayCareer;
@property (nonatomic,strong)UIView *careerView;
@property (nonatomic,strong)UIButton * selecteBtn;
@property (nonatomic,strong)UIView *maskView;

//遮罩
@property (nonatomic,strong)UIView * coverView;

@property (nonatomic,strong)UISwitch * yajin;
@property (nonatomic,strong)UISwitch * jifen;

@end

@implementation TTIPersonViewController

-(NSArray *)arrayCareer
{
    if(!_arrayCareer)
    {
        _arrayCareer = [NSArray arrayWithObjects:@"摄影师", @"导演",@"模特",@"其他",nil];
    }
    return _arrayCareer;
    
}
/**
 *  创建TableView
 */
- (void)CreateTableView{
    
    CGFloat tableViewH = kViewHeight - 44;
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, tableViewH)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor colorWithRed:0.910 green:0.918 blue:0.922 alpha:1.000];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    
}


#pragma mark - textfieldDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    _myTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return YES;
}

- (void)addWordInputeObservers
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishProductTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.goods_price];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishProductTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.market_price];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishProductTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.goods_mobile];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishProductTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.goods_number];
}


- (void)publishProductTextFiledEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 0;
    
    UITextField *textField = (UITextField *)noti.object;
    
    if ([textField isEqual:self.goods_mobile]) {
        kMaxLength = 11;
    }else{
        //价格
        kMaxLength = 6;
    }
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

- (void)publishProductTextViewEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 150;
    
    UITextView *textView = (UITextView *)noti.object;
    
    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                textView.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textView.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField

{
    UIView *view = textField.superview;
    while (![view isKindOfClass:[UITableViewCell class]]) {
        view = [view superview];
    }
    UITableViewCell *cell = (UITableViewCell*)view;
    CGRect rect = [cell convertRect:cell.frame toView:self.view];
    if (rect.origin.y / 2 + rect.size.height>=kViewHeight - 216) {
        _myTableView.contentInset = UIEdgeInsetsMake(0, 0, 216, 0);
        [_myTableView scrollToRowAtIndexPath:[_myTableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
      UIView *view = textView.superview;
    while (![view isKindOfClass:[UITableViewCell class]]) {
        view = [view superview];
    }
    UITableViewCell *cell = (UITableViewCell*)view;
    CGRect rect = [cell convertRect:cell.frame toView:self.view];
    if (rect.origin.y / 2 + rect.size.height>=kViewHeight - 216) {
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.view.frame;
            rect.origin.y = 64;
            self.view.frame = rect;
        } completion:nil];
    }
    return YES;

}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    UIView *view = textView.superview;
    while (![view isKindOfClass:[UITableViewCell class]]) {
        view = [view superview];
    }
    UITableViewCell *cell = (UITableViewCell*)view;
    CGRect rect = [cell convertRect:cell.frame toView:self.view];
    if (rect.origin.y / 2 + rect.size.height>=kViewHeight - 216) {
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.view.frame;
            rect.origin.y -= kViewHeight+216 - rect.origin.y / 2 - rect.size.height;
            self.view.frame = rect;
        } completion:nil];
    }
    return YES;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePathArray = [NSMutableArray array];
    self.imgArray = [NSMutableArray array];
    self.issueDict = [NSMutableDictionary dictionary];
    
//    [self createCareerChooseView];
    /**
     *  控制器赋值
     */
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    app.ShowViewController = self;
    [self CreateTableView];
    
    if (self.desModel) {
        [self setNavTabBar:@"修改人员信息"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.goods_name.text = self.desModel.goods_name;
        self.goods_mobile.text = self.desModel.goods_mobile;
        self.goods_price.text = self.desModel.goods_price;
        self.market_price.text = self.desModel.market_price;
        self.goods_number.text = self.desModel.goods_number;
               self.addressLabel.text = self.desModel.people_location;
                        self.addressLabel.text = self.desModel.people_location;
                        self.goods_deposit.text = self.desModel.goods_deposit;
                self.goods_job.text = self.desModel.goods_job;
                self.goods_category_id.text = self.desModel.category_name;
                self.goods_category = self.desModel.goods_category_id;
            if ([self.desModel.is_deduction isEqualToString:@"1"]) {
                    self.jifen.on = YES;
                }else{
                    self.jifen.on = NO;
                }
                if ([self.desModel.is_deposit isEqualToString:@"0"]) {
                    self.yajin.on = YES;
                }else{
                    self.yajin.on = NO;
                }
                NSMutableArray * imarray = [NSMutableArray array];
                
                for (int i = 0;i < self.desModel.imgs.count ; i ++) {
                    
                    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,self.desModel.imgs[i]]];
                    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                    if (image) {
                        [imarray addObject:image];
                    }
                }
                
                self.cell.addView.imageArray = [NSMutableArray arrayWithArray:imarray];
                [imarray addObject:[UIImage imageNamed:@"addPicture"]];
                [self.cell.addView ViewWithPictures:imarray];
            });
        
    }else{
        [self setNavTabBar:@"发布人员"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addWordInputeObservers];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 1) {
        return PictureWH +60;
    }else if(indexPath.row == 11){
        return 207;
    }else{
        return 45;
    }
}
/**
 *  职称按钮点击事件
 */

- (void)RemoveCover{

    [self removeCareerMaskViewAction];
    

}

- (void)ZCbtnClcik{
    NSLog(@"职称");
    [self.view endEditing:YES];
    HHNSLog(@"商家送货被点击");
    
    self.coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RemoveCover)];
    [self.coverView addGestureRecognizer:tap];
    
    self.coverView.backgroundColor = [UIColor lightGrayColor];
    self.coverView.alpha = 0.3;
    [self.view addSubview:self.coverView];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [self createCareerChooseView];
    [window addSubview:self.maskView];
    [window bringSubviewToFront:self.careerView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.careerView.frame;
        frame.origin.y -= frame.size.height;
        self.careerView.frame = frame;
    }];
}
/**
 *  选择类型按钮点击事件
 */
- (void)TypeClick{
    NSLog(@"选择类型");
    [self.view endEditing:YES];
    
    PublishSecondCategoryController *secondCategory = [[PublishSecondCategoryController alloc]init];
    secondCategory.type = @"2";
    //返回的回调
    __weak typeof(self)wself = self;
    secondCategory.backFn = ^(NSDictionary * dict){

        wself.goods_category_id.text = dict[@"category_name"];
        wself.goods_category = dict[@"category_id"];
        NSLog( @"%@",self.goods_job.text);
        if(self.goods_job.text .length==0)
        {
            self.goods_job.text = wself.goods_category_id.text;
        }
    };
    [self.navigationController pushViewController:secondCategory animated:YES];
    NSLog(@"选择类型");
    
}








- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TTIInputCell * cell = [[TTIInputCell alloc]initWithTableView:tableView];
        [cell inputWithSring:@"标题"];
        cell.inputTxfield.delegate = self;
        self.goods_name = cell.inputTxfield;
        if (self.desModel) {
            self.goods_name.text = self.desModel.goods_name;
        }else{
            cell.inputTxfield.text = self.goods_name.text;
        }
        
        
        return cell;
    }
    if (indexPath.row == 1) {
        static NSString * cellIdentify = @"goodCell";
        AddPictureTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (cell == nil) {
            cell = [[AddPictureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        }
        self.cell = cell;
        [cell setTitle:@"上传图片（5张）"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 3) {
        TTIInputCell *cell = [[TTIInputCell alloc]initWithTableView:tableView];
        cell.inputTxfield.placeholder = @"请输入职称";
        cell.inputTxfield.keyboardType =UIKeyboardTypeDefault;
        self.goods_job = cell.inputTxfield;
        cell.itemsLbl.text = @"职称";
//        TTiZCTableViewCell * cell = [[TTiZCTableViewCell alloc]initWithTableView:tableView];
//        [cell.btnClick addTarget:self action:@selector(ZCbtnClcik) forControlEvents:UIControlEventTouchUpInside];
//        self.goods_job = cell.ZClabel;
        return cell;
    }
    
    if(indexPath.row == 10){
        TTiTypeTableViewCell * cell = [[TTiTypeTableViewCell alloc]initWithTableView:tableView];
        self.cell10 = cell;
        cell.TYPE.text = @"宝贝所在地";
          cell.myLabel.text = self.cell10.myLabel.text;
        [cell.btnClick addTarget:self action:@selector(PlaceClick) forControlEvents:UIControlEventTouchUpInside];
        self.addressLabel = cell.myLabel;
        cell.lineLabel.hidden = YES;
        if (self.desModel) {
            self.addressLabel.text = self.desModel.people_location;
        }else{
           
//        self.addressLabel.text = @"请选择";
        }
//         cell.myLabel.text = self.addressLabel.text;
        return cell;
    
    
    }
    if(indexPath.row == 2){
        TTIInputCell * cell = [[TTIInputCell alloc]initWithTableView:tableView];
        [cell inputWithSring:@"联系方式"];
        cell.inputTxfield.delegate = self;
        self.goods_mobile = cell.inputTxfield;
        cell.inputTxfield.keyboardType = UIKeyboardTypeNumberPad;
        return cell;
    }
    if(indexPath.row == 4){
        TTIInputCell * cell = [[TTIInputCell alloc]initWithTableView:tableView];
        cell.inputTxfield.delegate = self;
        [cell inputWithSring:@"市场价"];
        cell.inputTxfield.delegate = self;
        self.market_price = cell.inputTxfield;
        cell.inputTxfield.keyboardType = UIKeyboardTypeNumberPad;
        return cell;
    }
    if(indexPath.row == 5){
        TTIInputCell * cell = [[TTIInputCell alloc]initWithTableView:tableView];
        [cell inputWithSring:@"咔么价"];
        cell.inputTxfield.delegate = self;
        self.goods_price = cell.inputTxfield;
        cell.inputTxfield.keyboardType = UIKeyboardTypeNumberPad;
        return cell;
    }
    if(indexPath.row == 6){
        TTIInputCell * cell = [[TTIInputCell alloc]initWithTableView:tableView];
        [cell inputWithSring:@"数量"];
        cell.inputTxfield.delegate = self;
        self.goods_number = cell.inputTxfield;
        
        if (self.desModel) {
            self.goods_number.text = self.desModel.goods_number;
        }
        
        cell.inputTxfield.keyboardType = UIKeyboardTypeNumberPad;
        return cell;
    }
//    if(indexPath.row == 9){
//        /**
//         *  积分抵扣View
//         */
//        TTIChooseCell * cell = [[TTIChooseCell alloc]initWithTableView:tableView];
//        [cell inputWithString:@"是否积分抵扣"];
//        self.is_deduction = @"1";
//        cell.changeOn = ^(UISwitch * number){
//            if (number.on) {
//                NSLog(@"可以使用积分");
//                self.is_deduction = @"1";
//            }else{
//                NSLog(@"不可以使用积分");
//                self.is_deduction = @"0";
//            }
//        };
//        self.jifen = cell.cellSwitch;
//        return cell;
//    }
//    
    if (indexPath.row == 7) {
        /**
         *  押金View
         */
        TTIChooseCell * cell = [[TTIChooseCell alloc]initWithTableView:tableView];
        [cell inputWithString:@"押金"];
        self.is_deposit = @"0";
        
        cell.changeOn = ^(UISwitch * number){
            if (number.on) {
                NSLog(@"需要押金");
                 self.is_deposit = @"1";
                self.goods_deposit.text = @"";
                self.goods_deposit.userInteractionEnabled = YES;
            }else{
                NSLog(@"不需要押金");
                 self.is_deposit = @"0";
                self.goods_deposit.text = @"0";
                self.goods_deposit.userInteractionEnabled = NO;
            }
        };
        self.yajin = cell.cellSwitch;
        return cell;
    }
    if (indexPath.row == 8) {
        TTIInputCell * cell = [[TTIInputCell alloc]initWithTableView:tableView];
        [cell inputWithSring:@"押金金额"];
        cell.inputTxfield.delegate = self;
        self.goods_deposit = cell.inputTxfield;
        self.goods_deposit.text = @"0";
        cell.inputTxfield.keyboardType = UIKeyboardTypeNumberPad;
        cell.inputTxfield.userInteractionEnabled = NO;
        return cell;
    }
    
    if(indexPath.row == 9){
        TTiTypeTableViewCell * cell = [[TTiTypeTableViewCell alloc]initWithTableView:tableView];
        self.cell9 = cell;
        cell.TYPE.text = @"选择类型";
          cell.myLabel.text = self.cell9.myLabel.text;
        [cell.btnClick addTarget:self action:@selector(TypeClick) forControlEvents:UIControlEventTouchUpInside];
        self.goods_category_id = cell.myLabel;
          cell.myLabel.text = self.cell9.myLabel.text;
        if (self.desModel) {
             self.goods_category_id.text = self.desModel.category_name;
        }else{
          
        }
        

        return cell;
    }
//    if (indexPath.row == 11) {
//        TTIInputCell * cell = [[TTIInputCell alloc]initWithTableView:tableView];
//        [cell inputWithSring:@"商品简介"];
//        cell.inputTxfield.delegate = self;
//         self.goods_alone = cell.inputTxfield;
//        if (self.desModel) {
////            self.goods_alone.text = self.desModel.goods_alone;
//            self.goods_alone.text = @"";
//            self.goods_alone.userInteractionEnabled = NO;
//        }else{
////            cell.inputTxfield.text = self.goods_alone.text;
//            cell.inputTxfield.text = @"";
//            cell.inputTxfield.userInteractionEnabled = NO;
//        }
//       
//        return cell;
    
//    }
else{
        static NSString * cellID = @"cellss";
        TTIDesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[TTIDesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textView.delegate = self;
        self.goods_desc = cell.textView;
        if (self.desModel) {
            [cell.textView setPlaceholderHidden];
            self.goods_desc.text = self.desModel.goods_desc;
        }
        
        if (self.desModel) {
            [cell.button setTitle:@"修改" forState:UIControlStateNormal];
            [cell.button addTarget:self action:@selector(doXIUGAI) forControlEvents:UIControlEventTouchUpInside];
        }else{
        
            [cell.button addTarget:self action:@selector(dofabu) forControlEvents:UIControlEventTouchUpInside];}
        return cell;
    }
}

- (void)dofabu{
    [self.view endEditing:YES];
    if ([self checkIssueInfoWhetherValid]) {
         [self issuePersonComfimrAction:nil];
    }
}

- (void)doXIUGAI{
    
    NSLog(@"%@",self.goods_job.text);
    [self.issueDict setObject:self.desModel.goods_id forKey:@"goods_id"];
    
    if ([self checkIssueInfoWhetherValid]) {
        [self issuePersonComfimrAction:nil];
    }

}

-(void)cityName:(NSString *)CityName andCityId:(NSString *)cityId{
    self.addressLabel.text = CityName;
}
- (void)PlaceClick{
    ChooseCityController * chooseCity = [[ChooseCityController alloc]init];
    chooseCity.delegate = self;
    [self.navigationController pushViewController:chooseCity animated:YES];
}

- (void)createCareerChooseView
{
    CGFloat viewH = 45.0f;
    NSInteger count = self.arrayCareer.count;
    
    self.careerView = [[UIView alloc] initWithFrame:CGRectMake(0,screenHeight,screenWidth,viewH*(count+1))];
    
    for (int i = 0; i < 4; i++) {
        
        CGRect frame = CGRectMake(0,viewH*(i+1),screenWidth, viewH);
        UIView *chooseView = [[UIView alloc] initWithFrame:frame];
        chooseView.userInteractionEnabled = YES;
        chooseView.tag = VIEW_START_TAG + i;
        chooseView.backgroundColor = [UIColor whiteColor];
        
        
        //MovieOccupationModel *model = _careerArray[i];
        NSString *value = [self.arrayCareer objectAtIndex:i];
        UILabel *label = [DeliveryUtility createLabelFrame:CGRectMake(10, 13, 100, 21) title:value textAlignment:0];
        label.font = [UIFont systemFontOfSize:15.0f];
        [chooseView addSubview:label];
        
        UIButton *button = [DeliveryUtility createBtnFrame:CGRectMake(kViewWidth-30, 7, 20, 20) image:@"tick_off" selectedImage:@"tick_on" target:self action:nil];
        button.tag = BTN_START_TAG;
        button.userInteractionEnabled = NO;
        [chooseView addSubview:button];
        
        if (0 == i) {
            button.selected = YES;
            self.selecteBtn = button;
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,viewH-1, kViewWidth, 1)];
        line.backgroundColor = RGBColor(212, 212, 212, 0.47);
        [chooseView addSubview:line];
        
        UITapGestureRecognizer *chooseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseMineOccupationAction:)];
        [chooseView addGestureRecognizer:chooseTap];
        
        [self.careerView addSubview:chooseView];
    }
    
    
    //完成按钮
    UIView *doneView = [WNController createImageViewWithFrame:CGRectMake(0,0, kViewWidth,viewH) ImageName:nil];
    doneView.backgroundColor = [UIColor whiteColor];
    
    UIButton *doneBtn = [DeliveryUtility createBtnFrame:CGRectMake(kViewWidth-60,7,60,30) title:@"完成" andFont:DefaultFont target:self action:@selector(finishChooseMineOccupation)];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneView addSubview:doneBtn];
    
    [self.careerView addSubview:doneView];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    //    self.careerView .frame = CGRectMake(0, screenHeight-20*4-45, screenWidth, 20*4+45);
    [window addSubview:self.careerView];
}

/** 选择我的职业 */
- (void)chooseMineOccupationAction:(UITapGestureRecognizer *)ges
{
    UIView *superView = ges.view;
    UIButton *button = (UIButton *)[superView viewWithTag:BTN_START_TAG];
    
    NSInteger index = superView.tag - VIEW_START_TAG;

    
    self.selecteBtn.selected = NO;
    button.selected = YES;
    self.selecteBtn = button;
}

/** 移除遮罩 */
- (void)removeCareerMaskViewAction
{
    [self.maskView removeFromSuperview];
    [self.coverView removeFromSuperview];
    self.coverView = nil;
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.careerView.frame;
        frame.origin.y += frame.size.height;
        self.careerView.frame = frame;
    }];
}

/** 完成职业选择 */
- (void)finishChooseMineOccupation
{
    [self removeCareerMaskViewAction];
    
    NSInteger index = (self.selecteBtn.superview.tag - VIEW_START_TAG);
    NSString *value = [self.arrayCareer objectAtIndex:index];
    self.goods_job.text = value;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.view endEditing:YES];
}

- (void)uploadStoreLogoImage:(UIImage *)originImage
{
    NSLog(@"%f___%f",originImage.size.width,originImage.size.height);
    CGFloat i = originImage.size.width/400;
    UIImage *postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(originImage.size.width/i, originImage.size.height/i)];
    NSData * imageData = UIImagePNGRepresentation(postImage);
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在上传图片";
    [HUD show:YES];
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"device"] = @"0";
    parameters[@"stream"] = imageData;
    parameters[@"flag"] = @"1";
    [HttpRequestServers requestBaseUrl:TICommon_Uploadify withParams:parameters withRequestFinishBlock:^(id result) {
        NSDictionary * dict = result[@"data"];
        [self.imgArray removeObjectAtIndex:0];
        [self.imagePathArray addObject:dict[@"img"]];
        
        if (self.imgArray.count > 0) {
             [self uploadStoreLogoImage:self.imgArray[0]];
        }else{
            
            NSLog(@"%@",self.imagePathArray);
            
            HUD.labelText = @"图片上传成功";
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            
            
           [self PostPersonInfo];
        }
    } withFieldBlock:^{
        HUD.labelText = @"图片上传失败！";
        [HUD hide:YES];
    }];
}


- (void)PostPersonInfo{
    if ([self checkIssueInfoWhetherValid]) {
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
        [HUD show:YES];
        
        
        self.issueDict[@"type"] = @"1";
        
        if (self.desModel) {
            [HttpRequestServers requestBaseUrl:TIPublish_UpdatePeople withParams:self.issueDict withRequestFinishBlock:^(id result) {
                
                if ([result[@"code"] intValue] == 0) {
                    HUD.labelText = @"修改成功";
                    [self performSelector:@selector(goBack) withObject:self afterDelay:1.0];
                    [HUD hide:YES afterDelay:1.0];
                }
                
            } withFieldBlock:^{
                
            }];
        }else{
            
            
            
            [MovieHttpRequest createPublishMinePersonnelWith:self.issueDict CallBack:^(id obj) {
                
                if ([obj isEqual:@"success"]) {
                    HUD.labelText = @"发布成功";
                    [self performSelector:@selector(goBack) withObject:self afterDelay:1.0];
                }else{
                    HUD.labelText = @"发布失败";
                }
                [HUD hide:YES];
            } andSCallBack:^(id obj) {
                [HUD hide:YES];
                [self performSelector:@selector(goBack) withObject:self afterDelay:0.25];
            }];
        }
    }


}


- (void)issuePersonComfimrAction:(id)sender
{
    HHNSLog(@"确定发布人员");
    [self.imagePathArray removeAllObjects];
    NSArray *imageArray = [self.cell getPictureArray];
    
    if (imageArray.count == 0) {
        [DeliveryUtility showMessage:@"请上传1-5张图片" target:self];
    }else{
    self.imgArray = [NSMutableArray arrayWithArray:imageArray];
    [self uploadStoreLogoImage:self.imgArray[0]];
    }
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)checkIssueInfoWhetherValid
{
    NSString *personName = [self.goods_name.text asTrim];
    NSString *phoneNum = [self.goods_mobile.text asTrim];
    NSString *price = [self.goods_price.text asTrim];
    NSString *feature = [self.goods_alone.text asTrim];
    NSString *goodsBrify = [self.goods_desc.text asTrim];
    
    //判断姓名
    if (0 == personName.length) {
        [DeliveryUtility showMessage:@"请输入人员姓名" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:personName]){
        [DeliveryUtility showMessage:@"姓名不可包含非法字符" target:self];
        return NO;
    }
    
    //判断联系方式
    if (0 == phoneNum) {
        [DeliveryUtility showMessage:@"请输入电话号码" target:self];
        return NO;
    }
    else if (11 != phoneNum.length || ![DeliveryUtility isPureInt:phoneNum]) {
        [DeliveryUtility showMessage:@"请输入正确的电话号码" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:phoneNum]){
        [DeliveryUtility showMessage:@"电话号码不可包含非法字符" target:self];
        return NO;
    }
/**
 请选择职称、 请选择所在地
 */
    if ([self.goods_job.text isEqualToString:@"请选择职称"]){
        [DeliveryUtility showMessage:@"请选择职称" target:self];
        return NO;
    }
    if ([self.addressLabel.text isEqualToString:@"请选择"]) {
        [DeliveryUtility showMessage:@"请选择所在地" target:self];
        return NO;
    }
    
    if ([self.goods_category_id.text isEqual:@"请选择"]) {
        [DeliveryUtility showMessage:@"请选择类型" target:self];
        return NO;
    }
    //判断价格
    if (0 == price) {
        [DeliveryUtility showMessage:@"请输入价格" target:self];
        return NO;
    }
    if([self.goods_number.text isEqualToString:@""]){
        [DeliveryUtility showMessage:@"请输入数量" target:self];
        return NO;
        
    }
    if([self.goods_deposit.text isEqualToString:@""]){
        
        [DeliveryUtility showMessage:@"请输入押金" target:self];
        return NO;
        
    }
    //判断类型
//    NSString *type = self.goods_category_id.text;
//    if(type.length==0)
//    {
//        [DeliveryUtility showMessage:@"请点击选择类型" target:self];
//        return NO;
//        
//    }
    //判断特点

    //判断简介
    if (0 == goodsBrify.length ) {
        
        [DeliveryUtility showMessage:@"请输入简介" target:self];
        return NO;
    }
    
    
    
    NSString *imagePath = [self.imagePathArray componentsJoinedByString:@","];
    
    [self.issueDict setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    [self.issueDict setObject:personName forKey:@"goods_name"]; //姓名
    [self.issueDict setObject:phoneNum forKey:@"goods_mobile"];//联系方式
    [self.issueDict setObject:price forKey:@"goods_price"];//价格
    [self.issueDict setObject:@"" forKey:@"goods_alone"];  //特点
    [self.issueDict setObject:goodsBrify forKey:@"goods_desc"]; //简介
#warning 这里图片的字符串哦
    [self.issueDict setObject:imagePath forKey:@"imgs"]; //图片(逗号拼接)
    [self.issueDict setObject:self.goods_number.text forKey:@"goods_number"];
    
    [self.issueDict setObject:self.is_deposit forKey:@"is_deposit"];
    [self.issueDict setObject:self.goods_deposit.text forKey:@"goods_deposit"];
    [self.issueDict setObject:self.goods_job.text forKey:@"goods_job"];
    [self.issueDict setObject:self.goods_category forKey:@"goods_category_id"];
    
    [self.issueDict setObject:self.market_price.text forKey:@"market_price"];
    [self.issueDict setObject:self.addressLabel.text forKey:@"people_location"];
    if (self.is_deduction) {
         [self.issueDict setObject:self.is_deduction forKey:@"is_deduction"];
    }else{
    
     [self.issueDict setObject:@"0" forKey:@"is_deduction"];
    }
    
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

}




@end
