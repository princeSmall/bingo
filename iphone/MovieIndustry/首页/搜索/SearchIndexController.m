//
//  SearchIndexController.m
//  MovieIndustry
//
//  Created by Pinocchio on 15/11/16.
//  Copyright (c) 2015年 MovieIndustry. All rights reserved.
//

#import "SearchIndexController.h"
#import "SearchResultController.h"
#import "SearchShopController.h"
#import "DiscoverPopView.h"
#import "SearchView.h"
#import "NSUserManager.h"

@interface SearchIndexController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tbView;
@property (nonatomic,strong) NSMutableArray *hotWordArray;
@property (nonatomic,strong) DiscoverPopView *popView;
@property (nonatomic,strong) UIView *popBgView;
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UILabel *navLabel;
///宝贝还是店铺 0 代表宝贝 1 代表店铺
@property (nonatomic,copy) NSString *searchType;

@property (nonatomic,strong) NSArray *searchHistoryArray;
@property (nonatomic,strong) NSArray *shopSearchHistoryArray;
@property (nonatomic,assign) BOOL babYisNixu;
@property (nonatomic,assign) BOOL shopisNixu;
///搜索文本框
@property (nonatomic,strong) UITextField *searchTextField;
@end
@implementation SearchIndexController

- (NSArray *)ShopSearchHistoryArray
{
    if (!_shopSearchHistoryArray) {
        _shopSearchHistoryArray = [NSUserManager readNSUserDefaultsAndKey:@"shopSearchHistory"];
        
    }
    return _shopSearchHistoryArray;
}

- (UIView *)popBgView
{
    if (!_popBgView) {
        //覆盖的大View不让干其他地方点击
        _popBgView = [[UIView alloc] initWithFrame:self.view.bounds];
        _popBgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePopView:)];
        [_popBgView addGestureRecognizer:tapGes1];
    }
    
    return _popBgView;
}

- (DiscoverPopView *)popView
{
    if (!_popView) {
        _popView = [[[NSBundle mainBundle] loadNibNamed:@"DiscoverPopView" owner:nil options:nil]lastObject];
        _popView.frame = CGRectMake((kViewWidth-(isScreen4?235:257))/2, 0, 132, 106);
        [_popView.forumButton setTitle:@"宝贝" forState:UIControlStateNormal];
        [_popView.courseButton setTitle:@"店铺" forState:UIControlStateNormal];
        [_popView.forumButton addTarget:self action:@selector(forumButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_popView.courseButton addTarget:self action:@selector(courseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popView;
}


- (NSMutableArray *)hotWordArray
{
    if (!_hotWordArray) {
        _hotWordArray = [NSMutableArray array];
    }
    
    return _hotWordArray;
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewHeight-184-44) style:UITableViewStylePlain];
        _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 0.01f)];
        _tbView.dataSource = self;
        _tbView.delegate = self;
        _tbView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tbView.backgroundColor = kViewBackColor;
        _tbView.separatorColor = kViewBackColor;
    }
    
    return _tbView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.searchHistoryArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"babySearchHistory"];
    self.shopSearchHistoryArray = [NSUserManager readNSUserDefaultsAndKey:@"shopSearchHistory"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationItem.titleView endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置返回按钮
    [self setNavTabBar:@""];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    ////搜索记录逆序
    _shopisNixu = NO;
    _babYisNixu = NO;
//    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"babySearchHistory"];
    self.searchHistoryArray = [NSUserManager readNSUserDefaultsAndKey:@"babySearchHistory"];
    
    self.shopSearchHistoryArray = [NSUserManager readNSUserDefaultsAndKey:@"shopSearchHistory"];
    
    self.searchType = @"0";
    
    [self setNavTabBar];
    
    [self.view addSubview:self.tbView];
    
    [self loadHotWord];
    
    
    
}

#pragma mark - 加载热搜词
- (void)loadHotWord
{
    [HttpRequestServers requestBaseUrl:Search_word withParams:nil withRequestFinishBlock:^(id result) {
        NSDictionary *dict = result;
        HHNSLog(@"%@",dict);
        if ([dict[@"status"] isEqualToString:@"f99"]) {
            NSArray *listArray = dict[@"list"];
            for (NSDictionary *infoDict in listArray) {
                [self.hotWordArray addObject:infoDict[@"value"]];
            }
            [_tbView reloadData];
        }
    } withFieldBlock:^{
        
    }];
}

- (void)removePopView:(UITapGestureRecognizer *)g
{
    [g.view removeFromSuperview];
    [self.popView removeFromSuperview];
    self.selectedBtn.selected = NO;
}

#pragma mark 选择宝贝
- (void)forumButtonAction:(UIButton *)btn
{
    self.searchType = @"0";
    self.navLabel.text = @"宝贝";
    self.selectedBtn.selected = NO;
    [self.popBgView removeFromSuperview];
    [self.popView removeFromSuperview];
    
    
    //刷新列表
    [_tbView reloadData];
}

#pragma mark - 选择店铺
- (void)courseButtonAction:(UIButton *)btn
{
    self.searchType = @"1";
    self.navLabel.text = @"店铺";
    self.selectedBtn.selected = NO;
    [self.popBgView removeFromSuperview];
    [self.popView removeFromSuperview];
    
    //刷新列表
    [_tbView reloadData];
}

- (void)createUI
{
    [self.view addSubview:self.tbView];
    UIImageView *imageView = [WNController createImageViewWithFrame:CGRectMake(0, kViewHeight-44-184, kViewWidth, 184) ImageName:@"advertize"];
    [self.view addSubview:imageView];
}

- (void)setNavTabBar
{
    UIView *view = [WNController createViewFrame:CGRectMake(0, 0, 257, 30)];
    if (isScreen4) {
        view.frame = CGRectMake(0, 0, 235, 30);
    }
    view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    view.layer.cornerRadius = 15;
    view.layer.masksToBounds = YES;
    
    UILabel *navLabel = [WNController createLabelWithFrame:CGRectMake(14, 1, 40, 30) Font:16 Text:@"宝贝" textAligment:NSTextAlignmentCenter];
    self.navLabel = navLabel;
    UIImageView *navImage = [WNController createImageViewWithFrame:CGRectMake(53, 8, 14, 14) ImageName:@"15-07"];
    UITextField *textField = [WNController createTextFieldWithFrame:CGRectMake(74, 2, (isScreen4?146:168), 28) boreStyle:UITextBorderStyleNone font:15];
    textField.placeholder = @"你想找什么？";
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    self.searchTextField = textField;
    
    UIButton *navBtn  = [WNController createButtonWithFrame:CGRectMake(0, 0, 70, 30) ImageName:@"" Target:self Action:@selector(searchTypeAction:) Title:@""];
    
    UIButton *searchArticleBtn = [DeliveryUtility createBtnFrame:CGRectMake((isScreen4?196:218), 5, 20, 20)  image:@"search_index" selectedImage:nil target:self action:@selector(searchGoodsAction)];
    
    
    [view addSubview:navLabel];
    [view addSubview:navImage];
    [view addSubview:textField];
    [view addSubview:navBtn];
    [view addSubview:searchArticleBtn];
    //设置头部的View
    self.navigationItem.titleView = view;

}

#pragma mark - searchGoodsAction
- (void)searchGoodsAction
{
    [self.searchTextField resignFirstResponder];
    if ([self.searchType isEqualToString:@"0"]) {
        
        ///存储到本地
        if (![self.searchTextField.text isEqualToString:@""]) {
            [NSUserManager SetSearchText:self.searchTextField.text andKey:@"babySearchHistory"];
        }

        SearchResultController *searchResultVc = [[SearchResultController alloc] init];
        searchResultVc.searchWords = self.searchTextField.text;
        [self.navigationController pushViewController:searchResultVc animated:YES];
    }
    
    if ([self.searchType isEqualToString:@"1"]) {
        if (![self.searchTextField.text isEqualToString:@""]) {
            [NSUserManager SetSearchText:self.searchTextField.text andKey:@"shopSearchHistory"];
        }
        
        SearchShopController *searchResultVc = [[SearchShopController alloc] init];
        searchResultVc.searchWords = self.searchTextField.text;
        [self.navigationController pushViewController:searchResultVc animated:YES];
    }

}

#pragma mark - searchTypeAction 搜索栏标签
- (void)searchTypeAction:(UIButton *)btn
{
    self.selectedBtn = btn;
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.view addSubview:self.popBgView];
        [self.view addSubview:self.popView];
    }else
    {
        [self.popBgView removeFromSuperview];
        [self.popView removeFromSuperview];
    }
}

#pragma mark - TableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
//        CGFloat hotWord = self.hotWordArray.count/3.0;
//        if (hotWord>(int)self.hotWordArray.count/3) {
//            hotWord = hotWord+1;
//        }
//        return hotWord;
    }
    if ([self.searchType isEqualToString:@"0"]) {
        return self.searchHistoryArray.count;
    }else
    return self.shopSearchHistoryArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.01F;
//}

//头部的View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *hView = [WNController createViewFrame:CGRectMake(0, 0, kViewWidth, 50)];
    UILabel *hLabel = [WNController createLabelWithFrame:CGRectMake(8, 0, 80, 50) Font:13 Text:@"热词搜索" textAligment:NSTextAlignmentLeft];
    hLabel.textColor = [UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1];
    if (section == 1) {
        hLabel.text = @"历史搜索";
        
        UIButton *hbtn = [WNController createButtonWithFrame:CGRectMake(kViewWidth-88, 0, 80, 50) ImageName:@"" Target:self Action:@selector(clearSearchHistory) Title:@"清空" fontSize:13];
//        [hbtn setBackgroundImage:[WNController createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        hbtn.contentHorizontalAlignment = NSTextAlignmentRight;
        [hbtn setTitleColor:[UIColor colorWithRed:0.64 green:0.64 blue:0.64 alpha:1] forState:UIControlStateNormal];
        [hView addSubview:hbtn];
    }
    [hView addSubview:hLabel];
    
    UIView *line = [WNController createViewFrame:CGRectMake(0, 49, kViewWidth, 1)];
    line.backgroundColor = kViewBackColor;
    [hView addSubview:line];
    return hView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CGFloat hotWord = 0.0f;
        for (int i = 0; i<self.hotWordArray.count; i++)
        {
            hotWord = 10+(30*(i/3))+((i/3)*10);
        }
//        return 200;
        return hotWord+10+30;
    }
    return 42;
}

#pragma mark - 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellID = @"searchIndexCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        CGFloat btnWidth = (kViewWidth-40)/3;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        for (int i = 0; i<self.hotWordArray.count; i++) {
            UIButton *btn = [WNController createButtonWithFrame:CGRectMake(10+(10*(i%3))+btnWidth*(i%3), 10+(30*(i/3))+((i/3)*10), btnWidth, 30) ImageName:@"" Target:self Action:@selector(hotWordAction:) Title:self.hotWordArray[i] fontSize:NormalFont];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell addSubview:btn];
            
        }

        cell.backgroundColor = kViewBackColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.textLabel.font = [UIFont systemFontOfSize:16];
//        cell.textLabel.text = @"金贝DII-250W摄影灯摄影棚";
        return cell;
    }else
    {
        if ([self.searchType isEqualToString:@"0"])
        {
            UITableViewCell *cell = cell = [[UITableViewCell alloc] init];
            UILabel *label = [WNController createLabelWithFrame:CGRectMake(8, 0, kViewWidth, 42) Font:16 Text:@"金贝DII-250W摄影灯摄影棚" textAligment:NSTextAlignmentLeft];
            [cell.contentView addSubview:label];
            if (!_babYisNixu) {
                self.searchHistoryArray = [[self.searchHistoryArray reverseObjectEnumerator] allObjects];
                _babYisNixu = YES;
            }
            
            label.text = self.searchHistoryArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            UITableViewCell *cell = cell = [[UITableViewCell alloc] init];
            UILabel *label = [WNController createLabelWithFrame:CGRectMake(8, 0, kViewWidth, 42) Font:16 Text:@"金贝DII-250W摄影灯摄影棚" textAligment:NSTextAlignmentLeft];
            [cell.contentView addSubview:label];
            if (!_shopisNixu) {
                self.shopSearchHistoryArray = [[self.shopSearchHistoryArray reverseObjectEnumerator] allObjects];
                _shopisNixu = YES;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            label.text = self.shopSearchHistoryArray[indexPath.row];
            return cell;
        }

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.searchType isEqualToString:@"0"])
    {
        UILabel *labelSear = [[UILabel alloc] init];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        for (UILabel *label in cell.contentView.subviews) {
            HHNSLog(@"%@",label.text);
            labelSear = label;  
        }
        SearchResultController *searchResultVc = [[SearchResultController alloc] init];
        searchResultVc.searchWords = labelSear.text;
        [self.navigationController pushViewController:searchResultVc animated:YES];
    }
}

#pragma mark - 热搜词点击
- (void)hotWordAction:(UIButton *)btn
{
    HHNSLog(@"%@",[btn titleForState:UIControlStateNormal]);
    SearchResultController *searchResultVc = [[SearchResultController alloc] init];
    searchResultVc.searchWords = [btn titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:searchResultVc animated:YES];
}

#pragma mark ///清空搜索历史
- (void)clearSearchHistory
{
    if ([self.searchType isEqualToString:@"0"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"babySearchHistory"];
        self.searchHistoryArray = [NSArray array];
    }else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shopSearchHistory"];
        self.shopSearchHistoryArray = [NSArray array];
    }

    [_tbView reloadData];
}



#pragma mark - 搜索按钮开始搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //收起键盘
    [textField resignFirstResponder];
    
//    if ([textField.text isEqualToString:@""]) {
//        [PromptLabel custemAlertPromAddView:self.view text:@"请输入搜索内容"];
//    }else
//    {
    
        
       
        if ([self.searchType isEqualToString:@"0"]) {
            
            ///存储到本地
            if (![textField.text isEqualToString:@""]) {
                [NSUserManager SetSearchText:textField.text andKey:@"babySearchHistory"];
            }
            
            
            
            SearchResultController *searchResultVc = [[SearchResultController alloc] init];
            searchResultVc.searchWords = textField.text;
            [self.navigationController pushViewController:searchResultVc animated:YES];
        }
        
        if ([self.searchType isEqualToString:@"1"]) {
            if (![textField.text isEqualToString:@""]) {
                [NSUserManager SetSearchText:textField.text andKey:@"shopSearchHistory"];
            }
            
            SearchShopController *searchResultVc = [[SearchShopController alloc] init];
            searchResultVc.searchWords = textField.text;
            [self.navigationController pushViewController:searchResultVc animated:YES];
        }

//    }
    return YES;
}

////TableView的分割线处理
-(void)viewDidLayoutSubviews {
    
    if ([_tbView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tbView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tbView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tbView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
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
