//
//  PublishPersonnelController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/17.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "PublishPersonnelController.h"
#import "MoviePictureCollectionCell.h"
#import "PublishSecondCategoryController.h"
#import "MovieOccupationModel.h"

#define IMAGE_START_TAG 300
#define VIEW_START_TAG  600
#define BTN_START_TAG 400

#define PLACE_HOLDER  @"请输入简介"

@interface PublishPersonnelController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/** 图片选择器 */
@property (nonatomic,strong) UIImagePickerController *imagePicker;

/** 人员图片数据 */
@property (nonatomic,strong) NSMutableArray *imageArray;

/** 人员图片路径 */
@property (nonatomic,strong) NSMutableArray *imagePathArray;

/** 所有职业数据 */
@property (nonatomic,strong) NSArray *careerArray;

/** 选中的职业 */
@property (nonatomic,strong) MovieOccupationModel *careerModel;
@property (weak, nonatomic) IBOutlet UITextField *goodsCount;

/** 黑色透明遮罩 */
@property (nonatomic,strong) UIView *maskView;

/** 职业选择视图 */
@property (nonatomic,strong) UIView *careerView;

/** 选中的职业按钮 */
@property (nonatomic,strong) UIButton *selecteBtn;

@property (nonatomic,assign) NSInteger imageIndex;

/**
 *  职业数组
 */
@property (nonatomic,strong) NSArray *arrayCareer;

/** 发布商品信息 */
@property (nonatomic,strong) NSMutableDictionary *issueDict;

@end

@implementation PublishPersonnelController

/*
 摄影师
 导演
 模特
 其他
 */
-(NSArray *)arrayCareer
{
    if(!_arrayCareer)
    {
        _arrayCareer = [NSArray arrayWithObjects:@"摄影师", @"导演",@"模特",@"其他",nil];
    }
    return _arrayCareer;
    
}
- (NSMutableDictionary *)issueDict{
    if (nil == _issueDict) {
        _issueDict = [NSMutableDictionary new];
    }
    return _issueDict;
}

- (NSMutableArray *)imagePathArray
{
    if (nil == _imagePathArray) {
        _imagePathArray = [NSMutableArray new];
        [_imagePathArray addObject:@""];
        [_imagePathArray addObject:@""];
        [_imagePathArray addObject:@""];
        [_imagePathArray addObject:@""];
        [_imagePathArray addObject:@""];
    }
    return _imagePathArray;
}
- (IBAction)yajinswitchChange:(id)sender {
    
    if (self.yajinSwitch.on) {
        self.yajinCount.userInteractionEnabled = YES;
        self.yajinCount.text = @"";
    }
    else{
        self.yajinCount.text = @"0";
        self.yajinCount.userInteractionEnabled = NO;
    }
    
}

- (NSMutableArray *)imageArray
{
    if (nil == _imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSArray *)careerArray
{
    if (nil == _careerArray) {
        _careerArray = [NSArray new];
    }
    return _careerArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagePathArray = nil;
    
    if (self.desModel) {
        [self setNavTabBar:@"修改人员信息"];
        self.txtPersonName.text = self.desModel.goods_name;
        self.txtPrice.text = self.desModel.goods_price;
        self.careerLab.text = self.desModel.goods_job;
        self.txtPhoneNum.text = self.desModel.goods_mobile;
        self.goodsCount.text = self.desModel.goods_number;
//        self.address.text = self.desModel.spare_address;
        self.txtSpecial.text = self.desModel.goods_alone;
        if ([self.desModel.is_deposit isEqualToString:@"1"]) {
            self.yajinSwitch.on = YES;
        }else{
            
            self.yajinSwitch.on = NO;}
        [self.imagePathArray removeAllObjects];
        for (int i = 0; i < self.desModel.imgs.count; i ++) {
            [self.imagePathArray addObject:self.desModel.imgs[i]];
        }
        
        self.yajinCount.text = self.desModel.goods_deposit;
#warning 选择类型 没有做
#warning 选择类型没有做TUPIAN
//        self.deliveryMethod.text = self.desModel.goods_express;
        self.textViewBriefly.text = self.desModel.goods_desc;
        
        for (int i = 0;i < self.desModel.imgs.count; i ++) {
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TIBIGImage,self.desModel.imgs[i]]];
            UIImage *image =[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            if (image) {
                [self.imageArray addObject:image];
            }
        }
    }else{
    
        [self setNavTabBar:@"发布人员"];
    for (int i = 0; i < 5; i ++) {
        UIImage * image = [UIImage imageNamed:@"addPicture"];
        [self.imageArray addObject:image];
    }
        
    }
    [self initIssuePersonView];
   
    [self addTextFileAndTextViewInputeObserver];
}

#pragma mark - 创建视图
- (void)initIssuePersonView
{
    
    if (!self.desModel) {
            self.textViewBriefly.text = PLACE_HOLDER;
    }
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    //创建尾部视图确认按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(20, 20, kViewWidth-40, 40);
    [comfirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    comfirmBtn.backgroundColor = [UIColor whiteColor];
    
    if (self.desModel) {
        [comfirmBtn setTitle:@"修改" forState:UIControlStateNormal];
        comfirmBtn.clipsToBounds = YES;
        comfirmBtn.layer.cornerRadius = 8;
        [comfirmBtn addTarget:self action:@selector(ChangePersonCom:) forControlEvents:UIControlEventTouchUpInside];
    }else{
    [comfirmBtn setTitle:@"发布" forState:UIControlStateNormal];
    comfirmBtn.clipsToBounds = YES;
    comfirmBtn.layer.cornerRadius = 8;
    [comfirmBtn addTarget:self action:@selector(issuePersonComfimrAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [footerView addSubview:comfirmBtn];
    self.tableView.tableFooterView = footerView;
    
    //注册UICollectionViewCell
    CGFloat itemW = (kViewWidth-20)/5;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize=CGSizeMake(itemW,itemW);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.collectionViewLayout = flowLayout;
    
    UINib *nib = [UINib nibWithNibName:@"MoviePictureCollectionCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"pictureCellID"];
    
    //创建maskView
    self.maskView = [WNController createViewFrame:CGRectMake(0, 0,screenWidth, screenHeight)];
    self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCareerMaskViewAction)];
    [self.maskView addGestureRecognizer:tapGes];
}

//返回上一层
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)issusePersonKeyboardDown
{
    [self.view endEditing:YES];
    [self.tableView endEditing:YES];
}

#pragma mark - 确定发布人员

- (void)ChangePersonCom:(UIButton *)sender{
    HHNSLog(@"修改人员信息");
    if ([self checkIssueInfoWhetherValid]) {
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
        HUD.labelText = @"修改信息";
        [HUD show:YES];
        
        
        self.issueDict[@"type"] = @"1";
        self.issueDict[@"goods_id"] = self.desModel.goods_id;
        
        [HttpRequestServers requestBaseUrl:TIPublish_UpdatePeople withParams:self.issueDict withRequestFinishBlock:^(id result) {
            
            if ([result[@"code"] intValue] == 0) {
                
                HUD.labelText = @"修改成功";
                [HUD hide:YES];
                [self performSelector:@selector(goBack) withObject:self afterDelay:0.25];
            }
         
            
        } withFieldBlock:^{
            HUD.labelText = @"修改失败";
            [HUD hide:YES];
            
        }];
        
//        [MovieHttpRequest createPublishMinePersonnelWith:self.issueDict CallBack:^(id obj) {
//            
//            if ([obj isEqual:@"success"]) {
//                HUD.labelText = @"发布成功";
//            }else{
//                HUD.labelText = @"发布失败";
//            }
//            [HUD hide:YES];
//            
//            [self performSelector:@selector(goBack) withObject:self afterDelay:0.25];
//            
//        } andSCallBack:^(id obj) {
//            
//            [HUD hide:YES];
//            [DeliveryUtility showMessage:obj target:self];
//        }];
    }
//
//
}


- (void)issuePersonComfimrAction:(id)sender
{
    HHNSLog(@"确定发布人员");
    
    if ([self checkIssueInfoWhetherValid]) {
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
        HUD.labelText = @"正在发布";
        [HUD show:YES];
        
        
        self.issueDict[@"type"] = @"1";
        
        [MovieHttpRequest createPublishMinePersonnelWith:self.issueDict CallBack:^(id obj) {
            
            if ([obj isEqual:@"success"]) {
                  HUD.labelText = @"发布成功";
                    [self performSelector:@selector(goBack) withObject:self afterDelay:0.25];
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

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)checkIssueInfoWhetherValid
{
    NSString *personName = [self.txtPersonName.text asTrim];
    NSString *phoneNum = [self.txtPhoneNum.text asTrim];
    NSString *price = [self.txtPrice.text asTrim];
    NSString *feature = [self.txtSpecial.text asTrim];
    NSString *goodsBrify = [self.textViewBriefly.text asTrim];
    
    //判断姓名
    if (0 == personName.length) {
        [DeliveryUtility showMessage:@"请输入人员姓名" target:self];
        return NO;
    }
    else if ([DeliveryUtility isNotLegal:personName]){
        [DeliveryUtility showMessage:@"姓名不可包含非法字符" target:self];
        return NO;
    }
    //判断图片
    int imageNum = 0;
    for (int i = 0; i < self.imagePathArray.count; i ++) {
        if ([_imagePathArray[i] isEqual:@""]) {
            imageNum++;
        }
    }
    if (imageNum>=5) {
        [DeliveryUtility showMessage:@"请上传至少1张商品图片" target:self];
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
    
    //判断价格
    if (0 == price) {
        [DeliveryUtility showMessage:@"请输入价格" target:self];
        return NO;
    }
    if([self.goodsCount.text isEqualToString:@""]){
        [DeliveryUtility showMessage:@"请输入数量" target:self];
        return NO;
    
    }
    if([self.yajinCount.text isEqualToString:@""]){
    
        [DeliveryUtility showMessage:@"请输入押金" target:self];
        return NO;
        
    }
    //判断类型
    NSString *type = self.typeLbl.text;
    if(type.length==0)
    {
        [DeliveryUtility showMessage:@"请点击选择类型" target:self];
        return NO;

    }
    //判断特点
    if (0 == feature) {
        [DeliveryUtility showMessage:@"请输入特点信息" target:self];
        return NO;
    }
    
    //判断简介
    if (0 == goodsBrify.length || [goodsBrify isEqualToString:PLACE_HOLDER]) {
        
         [DeliveryUtility showMessage:@"请输入简介信息" target:self];
         return NO;
    }



    NSString *imagePath = [self.imagePathArray componentsJoinedByString:@","];
    
    [self.issueDict setObject:APP_DELEGATE.user_id forKey:@"user_id"];
    [self.issueDict setObject:personName forKey:@"goods_name"]; //姓名
//    [self.issueDict setObject:@"" forKey:@"deal_id"];     //图片Id
    [self.issueDict setObject:phoneNum forKey:@"goods_mobile"];//联系方式
//    [self.issueDict setObject:self.careerModel.occupationId forKey:@"post_id"];//职业Id
    [self.issueDict setObject:price forKey:@"goods_price"];//价格
    [self.issueDict setObject:feature forKey:@"goods_alone"];  //特点
    [self.issueDict setObject:goodsBrify forKey:@"goods_desc"]; //简介
#warning 这里图片的字符串哦
    [self.issueDict setObject:imagePath forKey:@"imgs"]; //图片(逗号拼接)
    [self.issueDict setObject:self.goodsCount.text forKey:@"goods_number"];
    NSString * isYaJin;
    if (self.yajinSwitch.on) {
        isYaJin = @"1";
    }else{
        isYaJin = @"0";
    }
    
    [self.issueDict setObject:isYaJin forKey:@"is_deposit"];
    [self.issueDict setObject:self.yajinCount.text forKey:@"goods_deposit"];
    [self.issueDict setObject:self.careerLab.text forKey:@"goods_job"];
    //[self.issueDict setObject:@"1" forKey:@"goods_category_id"];
    
    return YES;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self issusePersonKeyboardDown];
    
    if (3 == indexPath.row) {
        
        HHNSLog(@"商家送货被点击");
        
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
    if(8 ==indexPath.row)
    {
        PublishSecondCategoryController *secondCategory = [[PublishSecondCategoryController alloc]init];
        secondCategory.type = @"2";
        //返回的回调
        __weak typeof(self)wself = self;
        secondCategory.backFn = ^(NSDictionary * dict){
            [wself.issueDict setObject:dict[@"category_id"] forKey:@"goods_category_id"];  ;
            UITableViewCell *cell = [wself.tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryNone;
            wself.typeLbl .frame=CGRectMake(kViewWidth-100, 0, 80, cell.frame.size.height);
            wself.typeLbl.textColor = [UIColor blackColor];
            wself.typeLbl.text = dict[@"category_name"];
            wself.typeLbl.textAlignment = NSTextAlignmentRight;
        };
        [self.navigationController pushViewController:secondCategory animated:YES];
        NSLog(@"选择类型");

    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self takeShopImageFromCamera];
            break;
        case 1:
            [self takeShopImageFromAlbum];
            break;
        default:
            break;
    }
}

#pragma mark - 拍照获取图片
- (void)takeShopImageFromCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = sourceType;
        self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.imagePicker.allowsEditing = YES;
        
        [self.imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        if (isiOS8) {
            
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
    else
    {
        [DeliveryUtility showMessage:@"该设备不支持拍照功能" target:self];
    }
}

#pragma mark - 从相册获取图片
- (void)takeShopImageFromAlbum
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.imagePicker.allowsEditing =YES;
    
    [self.imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消相册选择");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 上传图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
            [self uploadIssuePersonImages:image];
            
        }
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //如果选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
            [self uploadIssuePersonImages:image];

        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadIssuePersonImages:(UIImage *)originImage
{
    NSLog(@"%f___%f",originImage.size.width,originImage.size.height);
    CGFloat i = originImage.size.width/400;
    UIImage *postImage = [DeliveryUtility imageWithImageSimple:originImage scaledToSize:CGSizeMake(originImage.size.width/i, originImage.size.height/i)];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在上传图片";
    [HUD show:YES];
    NSData * imageData = UIImagePNGRepresentation(postImage);
    [UserDesModel GetUploadImageDictWithData:imageData WithType:@"0" With:^(NSString *string) {
        if ([string isEqualToString:@"F"]) {
            HUD.labelText = @"添加失败";
            [HUD hide:YES afterDelay:1.5];
        }else{
            HUD.labelText = @"添加成功";
            if (self.imageArray.count >= (_imageIndex+1))
                
            {
                [self.imageArray replaceObjectAtIndex:_imageIndex withObject:originImage];
            }else{
                
                [self.imageArray addObject:originImage];
                
            }
            
            [self.collectionView reloadData];
            
            
            
            [HUD hide:YES afterDelay:1.5];
            if(self.imagePathArray.count==5)
            {
                [self.imagePathArray replaceObjectAtIndex:_imageIndex withObject:string];
            }
            else
            {
                [self.imagePathArray addObject:string];
            }
            
        }
    }];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = _imageArray.count;
    return (5 == count)?count:count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MoviePictureCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pictureCellID" forIndexPath:indexPath];
    
    cell.delectBtn.tag = 600+indexPath.item;
    [cell.delectBtn addTarget:self action:@selector(delectChooseImageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger imageCount = self.imageArray.count;
    
    if ((0 == imageCount && 0 == indexPath.item) || (0 != imageCount && imageCount == indexPath.item))
    {
        cell.pcImage.image = [UIImage imageNamed:@"addPicture"];
        cell.delectBtn.hidden = YES;
    }
    else
    {
        cell.pcImage.image = _imageArray[indexPath.item];
        [cell.pcImage sizeThatFits:cell.pcImage.frame.size];
//        cell.delectBtn.hidden = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self issusePersonKeyboardDown];
    
    self.imageIndex = indexPath.item;
    
    UIActionSheet *sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [sheetView showInView:self.view];
}

- (void)delectChooseImageBtnClicked:(UIButton *)button
{
    NSInteger index = button.tag - 600;
    [self.imageArray removeObjectAtIndex:index];
    [self.collectionView reloadData];
}



#pragma mark - 创建职业选择视图
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
//    NSLog(@"选中的职业 --> %zd",index);
    self.careerModel = _careerArray[index];
    
    self.selecteBtn.selected = NO;
    button.selected = YES;
    self.selecteBtn = button;
}

/** 移除遮罩 */
- (void)removeCareerMaskViewAction
{
    [self.maskView removeFromSuperview];
    
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
    self.careerLab.text = value;
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([PLACE_HOLDER isEqualToString:[textView.text asTrim]])
    {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([@"" isEqualToString:[textView.text asTrim]])
    {
        textView.text = PLACE_HOLDER;
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtPersonName) {
        [self.txtPersonName resignFirstResponder];
        [self.txtPhoneNum becomeFirstResponder];
    }
    else if (textField == self.txtPhoneNum){
        [self.txtPhoneNum resignFirstResponder];
        [self.txtPrice becomeFirstResponder];
    }
    else if (textField == self.txtPrice){
        [self.txtPrice resignFirstResponder];
        [self.txtSpecial becomeFirstResponder];
    }
    else if (textField == self.txtSpecial){
        [self.txtSpecial resignFirstResponder];
    }
    
    return YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 添加文本输入框文字字数
- (void)addTextFileAndTextViewInputeObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishWorkerTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtPersonName];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishWorkerTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtPhoneNum];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishWorkerTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtPrice];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishWorkerTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.txtSpecial];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(publishWorkerTextViewEditChanged:) name:@"UITextViewTextDidChangeNotification" object:self.textViewBriefly];
}

- (void)publishWorkerTextFiledEditChanged:(NSNotification *)noti
{
    NSInteger kMaxLength = 0;
    
    UITextField *textField = (UITextField *)noti.object;
    if (textField == self.txtSpecial || textField == self.txtPersonName) {
        //特点 和 姓名
        kMaxLength = 20;
    }
    else if (textField == self.txtPrice)
    {
        //价格
        kMaxLength = 20;
    }
    else{
        //手机号
        kMaxLength = 11;
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

- (void)publishWorkerTextViewEditChanged:(NSNotification *)noti
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
