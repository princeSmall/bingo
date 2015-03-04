//
//  ShippingAddressController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/23.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ShippingAddressController.h"
#import "JGButtonAreaView.h"

@interface ShippingAddressController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>
{
    UIView *_pickBgView;
    
    NSString *_proviceStr;
    NSString *_cityStr;
    NSString *_areaStr;
}

@property (nonatomic,strong)JGButtonAreaView * areaView;

@property (nonatomic,strong) UIPickerView *cityPickView;
///城市选择
@property (nonatomic,strong) UITextField *cityPickTextField;
///省
@property (nonatomic,strong) NSMutableArray *provinceArray;
//城市
@property (nonatomic,strong) NSMutableArray *cityArray;
//区
@property (nonatomic,strong) NSMutableArray *areaArray;
///省市区字符串
@property (nonatomic,copy) NSString *areaString;
///选择了地址
@property (nonatomic,assign) BOOL isChooseCity;
//省份label
@property (weak, nonatomic) IBOutlet UILabel *provinceStr;
//城市label
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
//区域label
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
//省市区id
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (nonatomic,strong)NSString * proID;
@property (nonatomic,strong)NSString * citID;
@property (nonatomic,strong)NSString * areID;

@end

@implementation ShippingAddressController
- (UITextField *)cityPickTextField
{
    if (!_cityPickTextField) {
        _cityPickTextField = [[UITextField alloc] init];
    }
    return _cityPickTextField;
}

- (NSMutableArray *)areaArray
{
    if (!_areaArray) {
        _areaArray = [NSMutableArray array];
    }
    return _areaArray;
}

- (NSMutableArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}
- (IBAction)provinceBtnClick:(id)sender {
    NSLog(@"省份");
    //   [self chooseCityAreaAction:sender];
    
    [self.view endEditing:YES];
    [self.areaView provinceActionEndWithBlock:^(NSString *provinceStr) {
        NSArray * array = [provinceStr componentsSeparatedByString:@","];
        self.provinceStr.text = array[0];
        self.proID = array[1];
    }];
    
    
    
}
- (IBAction)areaBtn:(id)sender {
    [self.view endEditing:YES];
    [self.areaView areaActionEndWithBlock:^(NSString * areaStr) {
        NSArray * array = [areaStr componentsSeparatedByString:@","];
        self.areaLabel.text = array[0];
        self.areID = array[1];
    }];
    
    
}
- (IBAction)CityBtN:(id)sender {
    
     [self.view endEditing:YES];
    [self.areaView cityActionEndWithBlock:^(NSString *cityStr) {
        NSArray * array = [cityStr componentsSeparatedByString:@","];
        self.cityLabel.text = array[0];
        self.citID = array[1];
    }];
}
- (IBAction)SaveBtnClick:(id)sender {
    NSLog(@"保存");
    [self saveButtonAction];
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (UIPickerView *)cityPickView
{
    if (!_cityPickView) {
        _cityPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 150)];
        
        //    显示选中框
        _cityPickView.showsSelectionIndicator = YES;
        _cityPickView.delegate = self;
        _cityPickView.dataSource = self;
        _cityPickView.backgroundColor = [UIColor whiteColor];
    }
    return _cityPickView;
}

- (void)DownSwip{
    [self.view endEditing:YES];
    CGRect rect = self.view.frame;
    rect.origin.y = 64;
    self.view.frame = rect;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![self.addressDetailTextView isExclusiveTouch]) {
        [self.addressDetailTextView resignFirstResponder];
    }
    [self.view endEditing:YES];
    CGRect rect = self.view.frame;
    rect.origin.y = 64;
    self.view.frame = rect;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"新建收货地址"];
    self.areaView = [[JGButtonAreaView alloc]initWithFrame:self.view.frame WithController:self];
    self.addressDetailTextView.delegate = self;
    self.addressDetailTextView.returnKeyType = UIReturnKeyDone;
    //从本地读取plist文件
    self.postCodeLabel.delegate = self;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    self.provinceArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    self.cityArray = self.provinceArray[0][@"cities"];
    self.areaArray = self.cityArray[0][@"areas"];
    _proviceStr = @"";
    _cityStr = @"";
    _areaStr = @"";
    
    UISwipeGestureRecognizer * swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(DownSwip)];
    [self.rightView addGestureRecognizer:swipeGesture];
    
    [self.consigneeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.phoneNumberText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.postCodeLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    [self.view addSubview:self.cityPickTextField];
    [self.proviceAreaButton addTarget:self action:@selector(chooseCityAreaAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)setNavTabBar:(NSString *)title
{
    UILabel *ntitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ntitle.textAlignment = NSTextAlignmentCenter;
    ntitle.textColor = [UIColor whiteColor];
    ntitle.text = title;
    ntitle.font = [UIFont systemFontOfSize:BigBigFont];
    self.navigationItem.titleView = ntitle;
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    //    [self.navigationController.navigationBar addSubview:leftBtn];
    
    //设置TabBar左边的按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (void)backAction
{
    if (self.isQuerenOrder) {
        
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate backleftViewController];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 选择省市区
- (void)chooseCityAreaAction:(UIButton *)btn
{
    //创建大的背景View
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    _pickBgView = bgView;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePickerView)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:tapGes];
    [self.view addSubview:bgView];
    //创建工具条
    UIToolbar *toolbar=[[UIToolbar alloc]init];
    //设置工具条的颜色
    toolbar.barTintColor=kNavBarColor;
    //设置工具条的frame
    toolbar.frame=CGRectMake(0, 0, kViewWidth, 30);
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton *cusBtn = [WNController createButtonWithFrame:CGRectMake(0, 0, 40, 20) ImageName:@"" Target:self Action:@selector(finishCityAction) Title:@"完成" fontSize:14];
    [cusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *item3=[[UIBarButtonItem alloc] initWithCustomView:cusBtn];
    item3.tintColor = [UIColor whiteColor];
    toolbar.items = @[item2,item2,item2,item3];
    
    self.cityPickTextField.inputAccessoryView = toolbar;
    self.cityPickTextField.inputView = self.cityPickView;
    [self.cityPickTextField becomeFirstResponder];
    
    self.areaString = @"北京通州";
    [self.proviceAreaButton setTitle:@"北京通州" forState:UIControlStateNormal];
    self.isChooseCity = YES;
    
}
#pragma mark - 点击之后文字改变
- (void)finishCityAction
{
    //    if (!_proviceStr) {
    //        [PromptLabel custemAlertPromAddView:self.view text:@"请选择省市区"];
    //    }else
    //    {
    [self.proviceAreaButton setTitle:self.areaString forState:UIControlStateNormal];
    [self removePickerView];
    //    }
    
    
}
//移除PickerView
- (void)removePickerView
{
    //收起日期选择框
    [self.cityPickTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        
    } completion:^(BOOL finished) {
        [_pickBgView removeFromSuperview];
    }];
    
}

#pragma mark - 保存地址
- (void)saveButtonAction
{
    
    if ([self.consigneeTextField.text isEqualToString:@""]) {
        [PromptLabel custemAlertPromAddView:self.view text:@"请输入收货人姓名"];
    }else
    {
        //这边需要判断 手机号码是否合法
        if ([self.phoneNumberText.text isEqualToString:@""]) {
            [PromptLabel custemAlertPromAddView:self.view text:@"请输入手机号码"];
        }else
        {
            if ([self.postCodeLabel.text isEqualToString:@""]) {
                [PromptLabel custemAlertPromAddView:self.view text:@"请输入邮编"];
            }else
            {
               if ([self.addressDetailTextView.text isEqualToString:@""]||[self.addressDetailTextView.text isEqualToString:@"详细地址"]) {
                        [PromptLabel custemAlertPromAddView:self.view text:@"请输入详细地址"];
                    }else
                    {
                        
                        MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
                        
                        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                        dict[@"user_id"] = APP_DELEGATE.user_id;
                        dict[@"consignee_name"] = self.consigneeTextField.text;
                        dict[@"mobile"] = self.phoneNumberText.text;
                        dict[@"tel"] = self.telPhone.text;
                        dict[@"post_code"] = self.postCodeLabel.text;
                        dict[@"addr_detail"] = self.addressDetailTextView.text;
                        dict[@"province_id"] = self.proID;
                        dict[@"city_id"] = self.citID;
                        dict[@"province_name"] = self.provinceStr.text;
                        dict[@"city_name"] = self.cityLabel.text;
                        dict[@"post_code"] = self.postCodeLabel.text;
                        dict[@"district_id"] = self.areID;
                        dict[@"district_name"] = self.areaLabel.text;
                        dict[@"spare_address"] = [NSString stringWithFormat:@"%@,%@",self.provinceStr.text,self.cityLabel.text];
                        [HttpRequestServers requestBaseUrl:TIShipping_AddSAddr withParams:dict withRequestFinishBlock:^(id result) {
                            
                            NSDictionary *dict1 = result;
//                            HHNSLog(@"%@",dict1);
                            if ([dict1[@"code"] intValue] == 0 ) {
                                
                                
                                hud.labelText = @"保存成功";
                                
                                
                                [self backAction];
                                
                                
                            }
                            
                            [MBHudManager removeHud:hud scallBack:^(id obj) {
                                
                            }];
                            
                        } withFieldBlock:^{
                            [MBHudManager removeHud:hud scallBack:^(id obj) {
                                
                            }];
                        }];
                    }
                    
                    
                }
            }
            
        }
    }


#pragma mark - UIPickerView代理方法
//返回多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//每组返回的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1)
    {
        return self.cityArray.count;
    }else
    {
        return self.areaArray.count;
    }
}

//返回每一列的字符串
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [NSString stringWithFormat:@"%@",self.provinceArray[row][@"state"]];
        
    }else if(component == 1)
    {
        
        return [NSString stringWithFormat:@"%@",self.cityArray[row][@"city"]];
    }else
    {
        
        return [NSString stringWithFormat:@"%@",self.areaArray[row]];
    }
}

//当改变省份时，重新加载第2列的数据，部分加载
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        ///城市读取的数据会改变
        self.cityArray = self.provinceArray[row][@"cities"];
        
        [self.cityPickView selectRow:0 inComponent:1 animated:YES];
        [self.cityPickView reloadComponent:1];
        
        self.areaArray = self.cityArray[0][@"areas"];
        [self.cityPickView selectRow:0 inComponent:2 animated:YES];
        [self.cityPickView reloadComponent:2];
        //        HHNSLog(@"%@",[NSString stringWithFormat:@"%@",_provinceArray[row][@"state"]]);
        
        
        _proviceStr =self.provinceArray[row][@"state"];
        _cityStr = self.cityArray[0][@"city"];
        if (self.areaArray.count<1) {
            _areaStr = @"";
        }else
        {
            _areaStr = self.areaArray[0];
        }
        
    }
    else if(component == 1)
    {
        self.areaArray = self.cityArray[row][@"areas"];
        [self.cityPickView selectRow:0 inComponent:2 animated:YES];
        [self.cityPickView reloadComponent:2];
        
        if (!_proviceStr) {
            _proviceStr = _proviceStr =self.provinceArray[0][@"state"];
        }
        
        _cityStr = self.cityArray[row][@"city"];
        if (self.areaArray.count<1) {
            _areaStr = @"";
        }else
        {
            _areaStr = self.areaArray[0];
        }
    }
    
    if (component == 2) {
        if (self.areaArray.count>0) {
            _areaStr = self.areaArray[row];
        }
        
    }
    
    self.areaString = [NSString stringWithFormat:@"%@%@%@",_proviceStr,_cityStr,_areaStr];
    self.provinceStr.text = _proviceStr;
    self.cityLabel.text = [NSString stringWithFormat:@"%@  %@",_cityStr,_areaStr];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect rect = self.view.frame;
    rect.origin.y = -100;
    self.view.frame = rect;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([textField isEqual:self.addressDetailTextView]) {
        [self.view endEditing:YES];
    }else
    {
        [textField nextResponder];
    }
    return YES;
}


#pragma mark - 限制输入框的字数
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneNumberText) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.consigneeTextField) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.postCodeLabel) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
}


#pragma mark - UItextView
- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length>30) {
        textView.text = [textView.text substringToIndex:30];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.textColor = [UIColor blackColor];
    if ([textView.text isEqualToString:@"详细地址"]) {
        textView.text = @"";
    }
    CGRect rect = self.view.frame;
    rect.origin.y = -100;
    self.view.frame = rect;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"详细地址"]||[textView.text isEqualToString:@""]) {
        textView.text = @"详细地址";
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
