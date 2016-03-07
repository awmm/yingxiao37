//
//  NewClientViewController.m
//  Marketing
//
//  Created by HanenDev on 16/3/2.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "NewClientViewController.h"
#import "DetailClientCell.h"

#define STARTX [UIView getWidth:20]
#define MYCELLHEIGHT 60

@interface NewClientViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray      *_basicArray;
    NSArray      *_contactArray;
    
    UIScrollView * scrollView;
}
@property(nonatomic,strong)UITableView    *tableView;

@property(nonatomic,strong)UITextField    *companyTF;
@property(nonatomic,strong)UITextField    *nameTF;
@property(nonatomic,strong)UITextField    *numberTF;
@property(nonatomic,strong)UITextField    *departmentTF;
@property(nonatomic,strong)UITextField    *businessTF;

@property(nonatomic,strong)UIButton       *levelBtn;
@property(nonatomic,strong)UIButton       *fromBtn;
@property(nonatomic,strong)UIButton       *statusBtn;

@property(nonatomic,strong)UITextField    *phoneTF;
@property(nonatomic,strong)UITextField    *mobileTF;
@property(nonatomic,strong)UITextField    *emailTF;
@property(nonatomic,strong)UITextField    *addressTF;
@property(nonatomic,strong)UITextField    *remarkTF;
@property(nonatomic,strong)UITextField    *postalTF;
@property(nonatomic,strong)UITextField    *faxTF;
@property(nonatomic,strong)UITextField    *webTF;

@end

@implementation NewClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"新建客户";
    
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    _basicArray = @[@"公司",@"姓名",@"编号",@"级别",@"部门",@"职务",@"来源",@"状态"];
    _contactArray = @[@"电话",@"手机",@"邮箱",@"地址",@"备注",@"邮编",@"传真",@"公司网址"];
    
    //[self initTableView];
    [self createUI];
    
}
- (void)createUI{
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH - [UIView getHeight:50])];
    scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    UIButton *referBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, KSCreenH - [UIView getHeight:50.0f], KSCreenW, [UIView getHeight:50.0f])];
    referBtn.layer.borderWidth = 0.5;
    referBtn.layer.borderColor = grayLineColor.CGColor;
    referBtn.backgroundColor = graySectionColor;
    [referBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [referBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [referBtn addTarget:self action:@selector(referNewClient:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:referBtn];
    
    
    [self initSectionOne];
    [self initSectionTwo];

}
- (void)initSectionOne{
    CGFloat labelH = 20;
    CGFloat tfH    = 30;
    CGFloat tfY    = 5+ labelH;
    CGFloat tfW    = [UIView getWidth:200];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(STARTX, 5, 20, 20)];
    imageView1.image = [UIImage imageNamed:@"vip"];
    [scrollView addSubview:imageView1];
    
    UILabel *basicLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView1.maxX + 5, 5, 200, 20)];
    basicLabel.text = @"基本信息";
    basicLabel.textColor = cyanFontColor;
    [scrollView addSubview:basicLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STARTX, 30 - 1, KSCreenW - 2*STARTX, 1)];
    lineView.backgroundColor = grayLineColor;
    [scrollView addSubview:lineView];
    
    for (int i = 0; i<_basicArray.count; i++) {
        UILabel *label = [ViewTool getLabelWith:CGRectMake(STARTX, lineView.maxY + 5+ MYCELLHEIGHT*i, KSCreenW, labelH) WithTitle:_basicArray[i] WithFontSize:14.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
        [scrollView addSubview:label];
        
        UIView *line = [ViewTool getLineViewWith:CGRectMake(STARTX, lineView.maxY +(MYCELLHEIGHT -1)*(i+1) , KSCreenW - 2*STARTX, 1) withBackgroudColor:grayLineColor];
        [scrollView addSubview:line];
    }
    
    _companyTF = [self addTextFieldWithFrame:CGRectMake(STARTX, lineView.maxY + tfY, tfW, tfH) AndStr:@"请填写公司名称"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_companyTF];
    
    _nameTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _companyTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写姓名"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_nameTF];
    
    _numberTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _nameTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写编号"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_numberTF];
    
    _levelBtn = [self createButtonWithFrame:CGRectMake(STARTX - [UIView getWidth:8], _numberTF.maxY + tfY+5, 100, tfH) WithTitle:@"请选择等级" WithFont:16.0f WithTag:1000 WithColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_levelBtn];
    
    _departmentTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _levelBtn.maxY + tfY+5, tfW, tfH) AndStr:@"请填写部门"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_departmentTF];
    
    _businessTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _departmentTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写职务"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_businessTF];
    
    _fromBtn = [self createButtonWithFrame:CGRectMake(STARTX-[UIView getWidth:8], _businessTF.maxY + tfY+5, 100, tfH) WithTitle:@"请选择来源" WithFont:16.0f WithTag:2000 WithColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_fromBtn];
    
    _statusBtn = [self createButtonWithFrame:CGRectMake(STARTX-[UIView getWidth:8], _fromBtn.maxY + tfY+5, 100, tfH) WithTitle:@"请选择状态" WithFont:16.0f WithTag:3000 WithColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_statusBtn];
    
}
- (void)initSectionTwo{
    CGFloat labelH = 20;
    CGFloat tfH    = 30;
    CGFloat tfY    = 5+ labelH;
    CGFloat tfW    = [UIView getWidth:200];
    
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(STARTX, _statusBtn.maxY + 5, 20, 20)];
    imageView1.image = [UIImage imageNamed:@"vip"];
    [scrollView addSubview:imageView1];
    
    UILabel *basicLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView1.maxX + 5, _statusBtn.maxY + 5, 200, 20)];
    basicLabel.text = @"联系方式";
    basicLabel.textColor = cyanFontColor;
    [scrollView addSubview:basicLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STARTX, _statusBtn.maxY+30 - 1, KSCreenW - 2*STARTX, 1)];
    lineView.backgroundColor = grayLineColor;
    [scrollView addSubview:lineView];
    
    for (int i = 0; i<_basicArray.count; i++) {
        UILabel *label = [ViewTool getLabelWith:CGRectMake(STARTX, lineView.maxY + 5+ MYCELLHEIGHT*i, KSCreenW, labelH) WithTitle:_contactArray[i] WithFontSize:14.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
        [scrollView addSubview:label];
        
        UIView *line = [ViewTool getLineViewWith:CGRectMake(STARTX, lineView.maxY +(MYCELLHEIGHT -1)*(i+1) , KSCreenW - 2*STARTX, 1) withBackgroudColor:grayLineColor];
        [scrollView addSubview:line];
    }
    
    _phoneTF = [self addTextFieldWithFrame:CGRectMake(STARTX, lineView.maxY + tfY, tfW, tfH) AndStr:@"请填写电话"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_phoneTF];
    
    _mobileTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _phoneTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写手机"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_mobileTF];
    
    _emailTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _mobileTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写邮箱"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_emailTF];
    
    _addressTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _emailTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写地址"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_addressTF];
    
    _remarkTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _addressTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写备注"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_remarkTF];
    
    _postalTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _remarkTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写邮编"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_postalTF];
    
    _faxTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _postalTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写传真"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_faxTF];
    
    _webTF = [self addTextFieldWithFrame:CGRectMake(STARTX, _faxTF.maxY + tfY+5, tfW, tfH) AndStr:@"请填写公司网址"  AndTextColor:[UIColor lightGrayColor]];
    [scrollView addSubview:_webTF];
    
    scrollView.contentSize = CGSizeMake(KSCreenW, _webTF.maxY);
    
}
- (void)clickToSelect:(UIButton *)btn{
    
}
//提交按钮
- (void)referNewClient:(UIButton *)btn{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(UITextField *)addTextFieldWithFrame:(CGRect)frame AndStr:(NSString *)placeholder AndTextColor:(UIColor *)color
{
    UITextField *textF=[[UITextField alloc]initWithFrame:frame];
    textF.userInteractionEnabled = YES;
    textF.textColor = color;
    textF.placeholder=placeholder;
    textF.delegate = self;
    return textF;
}
- (UIButton *)createButtonWithFrame:(CGRect)frame WithTitle:(NSString *)string WithFont:(CGFloat)font WithTag:(CGFloat)tag WithColor:(UIColor *)color
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:string forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(clickToSelect:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
/*
- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark
#pragma mark-----tableView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _basicArray.count;
    }
    return _contactArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [UIView getHeight:30];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIView getHeight:60];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW - 2*STARTX, [UIView getHeight:30])];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:5], 20, [UIView getHeight:20])];
    [headerView addSubview:imageView];
    
    UILabel *basicLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.maxX + 5, [UIView getHeight:5], 200, [UIView getHeight:20])];
    basicLabel.textColor = [UIColor cyanColor];
    [headerView addSubview:basicLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:30] - 1, KSCreenW - 2*STARTX, 1)];
    lineView.backgroundColor = grayLineColor;
    [headerView addSubview:lineView];
    
    if (section == 0) {
        imageView.image = [UIImage imageNamed:@"vip"];
        basicLabel.text = @"基本信息";
    }else if (section == 1){
        imageView.image = [UIImage imageNamed:@"定位"];
        basicLabel.text = @"联系方式";
    }
    
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier =@"cell";
    DetailClientCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DetailClientCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(STARTX, MYCELLHEIGHT - 1, KSCreenW -2*STARTX, 1)];
        lineView.backgroundColor = grayLineColor;
        [cell.contentView addSubview:lineView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0 ) {
        cell.nameLabel.text = _basicArray[indexPath.row];
        
    }
    if (indexPath.section == 1) {
        cell.nameLabel.text = _contactArray[indexPath.row];
        
    }
    
    return cell;
}
*/
- (void)goToBack{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
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
