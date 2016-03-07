//
//  VisitDetailViewController.m
//  Marketing
//
//  Created by wmm on 16/3/4.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "VisitDetailViewController.h"

#define STARTX [UIView getWidth:20]
#define MYCELLHEIGHT 80

@interface VisitDetailViewController ()
{
    NSArray    *_basicArray;
    NSArray    *_dataArray;
    UIScrollView * scrollView;
}

@property(nonatomic,strong)UILabel    *visitDateLbl;
@property(nonatomic,strong)UILabel    *companyLbl;
@property(nonatomic,strong)UILabel    *visitObjectLbl;
@property(nonatomic,strong)UILabel    *visitTypeLbl;
@property(nonatomic,strong)UILabel    *visitAddressLbl;
@property(nonatomic,strong)UITextView *visitRecordTV;


@end

@implementation VisitDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"拜访纪要";
    
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    _basicArray = @[@"拜访日期",@"公司名称",@"访问对象",@"拜访类型",@"预约地址",@"访谈纪要"];
//    _dataArray = @[@"",@"请添加公司",@"请添加人员",@"请选择类型",@"请输入拜访地址"];
    
    [self createUI];
    
    [UIView getHeight:60];
    
}

- (void)createUI{
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH - [UIView getHeight:50])];
    scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, KSCreenH - 44, KSCreenW, 44)];
    saveBtn.layer.borderWidth = 0.5;
    saveBtn.layer.borderColor = grayLineColor.CGColor;
    saveBtn.backgroundColor = graySectionColor;
    [saveBtn setTitle:@"确认保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    saveBtn.userInteractionEnabled=NO;//不可点击
    saveBtn.alpha=0.4;//变灰
    [saveBtn addTarget:self action:@selector(saveRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    [self initListView];
    
}
- (void)initListView{
    CGFloat labelH = 20;
    CGFloat tfH    = 30;
    CGFloat tfY    = 30+ labelH;
    CGFloat tfW    = KSCreenW - 2*STARTX;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = grayLineColor;
    [scrollView addSubview:lineView];
    
    for (int i = 0; i<_basicArray.count; i++) {
        UILabel *label = [ViewTool getLabelWith:CGRectMake(STARTX, 10+MYCELLHEIGHT*i, KSCreenW, labelH) WithTitle:_basicArray[i] WithFontSize:14.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
        [scrollView addSubview:label];
        if (i < _basicArray.count-1) {
            UIView *line = [ViewTool getLineViewWith:CGRectMake(STARTX, (MYCELLHEIGHT)*(i+1)-1 , KSCreenW - 2*STARTX, 1) withBackgroudColor:grayLineColor];
            [scrollView addSubview:line];
        }
        
    }
    
    _visitDateLbl = [self addLableWithFrame:CGRectMake(STARTX, 40, tfW, tfH) AndStr:@""  AndTextColor:[UIColor lightGrayColor]];
        _visitDateLbl.backgroundColor = [UIColor redColor];
    
    
    
    _companyLbl = [self addLableWithFrame:CGRectMake(STARTX, _visitDateLbl.maxY + tfY, tfW, tfH) AndStr:@""  AndTextColor:[UIColor lightGrayColor]];
            _companyLbl.backgroundColor = [UIColor redColor];
    _visitObjectLbl = [self addLableWithFrame:CGRectMake(STARTX, _companyLbl.maxY + tfY, tfW, tfH) AndStr:@""  AndTextColor:[UIColor lightGrayColor]];
    
    _visitTypeLbl = [self addLableWithFrame:CGRectMake(STARTX, _visitObjectLbl.maxY + tfY, tfW, tfH) AndStr:@""  AndTextColor:[UIColor lightGrayColor]];
    
    _visitAddressLbl = [self addLableWithFrame:CGRectMake(STARTX, _visitTypeLbl.maxY + tfY, tfW, tfH) AndStr:@""  AndTextColor:[UIColor lightGrayColor]];
    
    
    _visitRecordTV = [[UITextView alloc] initWithFrame:CGRectMake(STARTX, _visitAddressLbl.maxY +tfY, tfW, KSCreenH-_visitAddressLbl.maxY-tfY-44)];
    _visitRecordTV.backgroundColor = [UIColor redColor];
    
    [scrollView addSubview:_visitDateLbl];
    [scrollView addSubview:_companyLbl];
    [scrollView addSubview:_visitObjectLbl];
    [scrollView addSubview:_visitTypeLbl];
    [scrollView addSubview:_visitAddressLbl];
    [scrollView addSubview:_visitRecordTV];

    
}

- (void)clickToSelect:(UIButton *)btn{
    if (btn.tag == 1) {
        NSLog(@"date");
    }else if (btn.tag == 2){
        NSLog(@"company");
    }
    
}
//提交按钮
- (void)saveRecord:(UIButton *)btn{
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(UILabel *)addLableWithFrame:(CGRect)frame AndStr:(NSString *)placeholder AndTextColor:(UIColor *)color
{
    UILabel *textL=[[UILabel alloc]initWithFrame:frame];
    textL.userInteractionEnabled = YES;
    textL.textColor = color;
    return textL;
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

- (UIButton *)createButtonWithFrame:(CGRect)frame WithImage:(NSString *)imgName WithTag:(CGFloat)tag
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setImage:[UIImage imageNamed:imgName ] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(clickToSelect:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

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
    
    [self registerForKeyboardNotifications];
    //注册通知,监听键盘出现
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(handleKeyboardDidShow:)
//                                                name:UIKeyboardDidShowNotification
//                                              object:nil];
//    //注册通知，监听键盘消失事件
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(handleKeyboardDidHidden)
//                                                name:UIKeyboardDidHideNotification
//                                              object:nil];
//    [super viewWillAppear:YES];
}

//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    scrollView.contentInset=UIEdgeInsetsMake(0, 0,keyboardRect.size.height, 0);
}

- (void)handleKeyboardDidHidden
{
    scrollView.contentInset=UIEdgeInsetsZero;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
//    
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your app might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, _visitRecordTV.frame.origin) ) {
//        [scrollView scrollRectToVisible:_visitRecordTV.frame animated:YES];
//    }
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = _visitRecordTV.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [_visitRecordTV.superview setFrame:bkgndRect];
    [scrollView setContentOffset:CGPointMake(0.0, _visitRecordTV.frame.origin.y-kbSize.height) animated:YES];

}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textViewDidChange:(UITextView *)textView{
//    if (textView.text != nil & textView) {
//        <#statements#>
//    }
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