//
//  ResettingAddressController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/12/10.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "ResettingAddressController.h"
#import "ManagerShippingAddressController.h"
#import "ProvinceModel.h"
#import "JGButtonAreaView.h"

@interface ResettingAddressController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>
{
    UIView *_pickBgView;
    
    NSString *_proviceStr;
    NSString *_cityStr;
    NSString *_areaStr;
}

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
//省市区view
@property (weak, nonatomic) IBOutlet UIView *proCitAreView;
@property (nonatomic,strong)JGButtonAreaView * jgBtnView;


///选择了地址
@property (nonatomic,assign) BOOL isChooseCity;
@end

@implementation ResettingAddressController

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

/*
 //收货人
 @property (weak, nonatomic) IBOutlet UITextField *consigneeTextField;
 
 
 @property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;
 
 
 ///详细地址
 @property (weak, nonatomic) IBOutlet UITextField *addressDetailTextView;
 
 ///邮政编码
 @property (weak, nonatomic) IBOutlet UITextField *postCodeLabel;
 ///选择省市区
 @property (weak, nonatomic) IBOutlet UIButton *proviceAreaButton;
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTabBar:@"修改收货地址"];
    [self setNavRightItem:@"保存" rightAction:@selector(saveButtonAction)];
    self.addressDetailTextView.delegate = self;
    self.addressDetailTextView.returnKeyType = UIReturnKeyDone;
    
    self.consigneeTextField.text = self.model.consignee;
    self.phoneNumberText.text = self.model.tel;
    self.addressDetailTextView.text = self.model.address;
    self.postCodeLabel.text = self.model.youbian;
    [self.proviceAreaButton setTitle:self.model.regionArea forState:UIControlStateNormal];
    
    self.areaString = self.model.regionArea;
    
    JGButtonAreaView * jgBtnView = [[JGButtonAreaView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)WithController:self];
    self.jgBtnView = jgBtnView;
    jgBtnView.provinceBtn.buttonTitle = self.model.province_name;
    jgBtnView.cityBtn.buttonTitle = self.model.city_name;
    jgBtnView.areaBtn.buttonTitle = self.model.district_name;
    jgBtnView.proID = self.model.province_id;
    jgBtnView.citID = self.model.city_id;
    jgBtnView.areID = self.model.district_id;
    [self.proCitAreView addSubview:jgBtnView];
    
    
    
    //从本地读取plist文件
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    self.provinceArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    self.cityArray = self.provinceArray[0][@"cities"];
    self.areaArray = self.cityArray[0][@"areas"];
    _proviceStr = @"";
    _cityStr = @"";
    _areaStr = @"";
    
    
    [self.consigneeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.phoneNumberText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.postCodeLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:self.cityPickTextField];
    [self.proviceAreaButton addTarget:self action:@selector(chooseCityAreaAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
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
    
//    self.areaString = @"北京通州";
//    [self.proviceAreaButton setTitle:@"北京通州" forState:UIControlStateNormal];
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
//        [PromptLabel custemAlertPromAddView:self.view text:@"请输入收货人姓名"];
         [DeliveryUtility showMessage:@"请输入收货人姓名" target:nil];
    }else
    {
        if ([self.phoneNumberText.text isEqualToString:@""]) {
//            [PromptLabel custemAlertPromAddView:self.view text:@"请输入手机号码"];
             [DeliveryUtility showMessage:@"请输入手机号码" target:nil];
        }else
        {
            if ([self.postCodeLabel.text isEqualToString:@""]) {
//                [PromptLabel custemAlertPromAddView:self.view text:@"请输入邮编"];
                 [DeliveryUtility showMessage:@"请输入邮编" target:nil];
            }else{
                    
                    if ([self.addressDetailTextView.text isEqualToString:@""]||[self.addressDetailTextView.text isEqualToString:@"详细地址"]) {
//                        [PromptLabel custemAlertPromAddView:self.view text:@"请输入详细地址"];
                         [DeliveryUtility showMessage:@"请输入详细地址" target:nil];
                    }else
                    {
                        if(![self.jgBtnView isAllAddress]){
//                             [PromptLabel custemAlertPromAddView:self.view text:@"请检查地址信息"];
                             [DeliveryUtility showMessage:@"请检查地址信息" target:nil];
                        }else{
                        MBProgressHUD *hud = [MBHudManager showHudAddToView:self.view andAddSubView:self.view];
                        NSMutableDictionary * userDict = [NSMutableDictionary dictionary];
                        userDict[@"user_id"] = APP_DELEGATE.user_id;
                        userDict[@"consignee_name"] = self.consigneeTextField.text;
                            self.model.consignee = self.consigneeTextField.text;
                            
                        userDict[@"mobile"] = self.phoneNumberText.text;
                            self.model.tel = self.phoneNumberText.text;
                            
                        userDict[@"post_code"] = self.postCodeLabel.text;
                            self.model.youbian = self.postCodeLabel.text;
                        userDict[@"addr_detail"] = self.addressDetailTextView.text;
                            self.model.address = self.addressDetailTextView.text;
                        userDict[@"province_id"] = self.jgBtnView.proID;
                            self.model.province_id = self.jgBtnView.proID;
                        userDict[@"city_id"] = self.jgBtnView.citID;
                            self.model.city_id = self.jgBtnView.citID;
                        userDict[@"province_name"] = self.jgBtnView.provinceBtn.titleLabel.text;
                            self.model.province_name =self.jgBtnView.provinceBtn.titleLabel.text;
                        userDict[@"city_name"] = self.jgBtnView.cityBtn.titleLabel.text;
                            self.model.city_name = self.jgBtnView.cityBtn.titleLabel.text;
                        userDict[@"district_id"] = self.jgBtnView.areID;
                            self.model.district_id = self.jgBtnView.areID;
                        userDict[@"district_name"] = self.jgBtnView.areaBtn.titleLabel.text;
                            self.model.district_name = self.jgBtnView.areaBtn.titleLabel.text;
                        userDict[@"spare_address"] = [NSString stringWithFormat:@"%@,%@",_proviceStr,_cityStr];
                        userDict[@"tel"] = @"";
                        userDict[@"shipping_address_id"] = self.model.address_id;
                        
                        [HttpRequestServers requestBaseUrl:TIShipping_AddSAddr withParams:userDict withRequestFinishBlock:^(id result) {
                            
                            NSDictionary *dict = result;
                            HHNSLog(@"%@",dict);
                            if ([dict[@"code"] intValue] == 0) {
                                
                                [self.navigationController popViewControllerAnimated:YES];
                                if (self.delegate) {
                                    [self.delegate sendModel:self.model];
                                }
                                hud.labelText = @"保存成功";
                                
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
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - UIPickerView代理方法
//返回多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
//每组返回的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
    }else
    {
        return self.cityArray.count;
    }
}

//返回每一列的字符串
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [NSString stringWithFormat:@"%@",self.provinceArray[row][@"state"]];
    }else
    {
    return [NSString stringWithFormat:@"%@",self.cityArray[row][@"city"]];
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
//        [self.cityPickView selectRow:0 inComponent:2 animated:YES];
        
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
    
    
    NSArray * strArray = @[_proviceStr,_cityStr];
    
    self.areaString = [ProvinceModel GetStrFormArray:strArray];
    HHNSLog(@"%@",self.areaString);
    
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([textField isEqual:self.addressDetailTextView]) {
        [self.view endEditing:YES];
    }else
    {
        [self.view endEditing:YES];
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
//    textView.text = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"详细地址"]||[textView.text isEqualToString:@""]) {
        textView.text = @"";
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
