//
//  InviteViewController.m
//  Marketing
//
//  Created by HanenDev on 16/2/25.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "InviteViewController.h"

#define STARTX [UIView getWidth:20]
#define LINEW KSCreenW - 2*STARTX
@interface InviteViewController ()<UITextFieldDelegate>
{
    UITextField *_phoneTF;
    UITextField *_nameTF;
    UISwitch    *swit;
}
@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"邀请";
    
    [self createUI];
}
- (void)createUI{
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    
    CGFloat labelH =[UIView getHeight:30];
    CGFloat tfHeight =[UIView getHeight:40];
    //员工号码
    UILabel *phoneLabel = [ViewTool getLabelWith:CGRectMake(STARTX, 64 +5, LINEW, labelH) WithTitle:@"员工号码" WithFontSize:14.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:phoneLabel];
    
    _phoneTF = [self addTextFieldWithFrame:CGRectMake(STARTX, phoneLabel.maxY, LINEW, tfHeight) AndStr:@"请添加号码(必填)" AndFont:17.0f AndTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:_phoneTF];
    
    UIView *lineView1 = [ViewTool getLineViewWith:CGRectMake(STARTX, _phoneTF.maxY + 4, LINEW, 1) withBackgroudColor:grayLineColor];
    [self.view addSubview:lineView1];
    //员工姓名
    UILabel *nameLabel = [ViewTool getLabelWith:CGRectMake(STARTX, _phoneTF.maxY + 10, LINEW, labelH) WithTitle:@"员工姓名" WithFontSize:14.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:nameLabel];
    
    _nameTF = [self addTextFieldWithFrame:CGRectMake(STARTX, nameLabel.maxY, LINEW, tfHeight) AndStr:@"请选择姓名(必填)" AndFont:17.0f AndTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:_nameTF];
    
    UIView *lineView2 = [ViewTool getLineViewWith:CGRectMake(STARTX, _nameTF.maxY + 4, LINEW, 1) withBackgroudColor:grayLineColor];
    [self.view addSubview:lineView2];
    
    //是否短信通知
    UILabel *inviteLabel = [ViewTool getLabelWith:CGRectMake(STARTX, _nameTF.maxY + 10, LINEW, labelH) WithTitle:@"短信通知ta加入企业应用" WithFontSize:14.0f WithTitleColor:[UIColor cyanColor] WithTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:inviteLabel];
    
//    UIButton *inviteBtn = [[UIButton alloc]initWithFrame:CGRectMake(KSCreenW - 50 -STARTX, inviteLabel.y, 50, 30)];
//    [inviteBtn setImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
//    [inviteBtn setImage:[UIImage imageNamed:@"open"] forState:UIControlStateSelected];
//    [self.view addSubview:inviteBtn];
    
    swit = [[UISwitch alloc]initWithFrame:CGRectMake(KSCreenW - 50 -STARTX, inviteLabel.y, 40, 30)];
    [swit addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:swit];
    
    
    UILabel *explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(STARTX, inviteLabel.maxY + 15, KSCreenW/2 + 50, labelH*2)];
    explainLabel.text = @"如勾选此项,系统将自动发短信,邀请对方加入";
    explainLabel.textColor = grayFontColor;
    explainLabel.font = [UIFont systemFontOfSize:16.0f];
    explainLabel.numberOfLines = 0;
    [self.view addSubview:explainLabel];
    
    UIButton *referBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, KSCreenH - [UIView getHeight:50.0f], KSCreenW, [UIView getHeight:50.0f])];
    referBtn.layer.borderWidth = 0.5;
    referBtn.layer.borderColor = grayLineColor.CGColor;
    referBtn.backgroundColor = graySectionColor;
    [referBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [referBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [referBtn addTarget:self action:@selector(referInvitation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:referBtn];
}


//提交邀请
- (void)referInvitation:(UIButton *)btn{
    
}
//开关
- (void)switchIsChanged:(UISwitch *)swit{
    
}

-(UITextField *)addTextFieldWithFrame:(CGRect)frame AndStr:(NSString *)placeholder AndFont:(CGFloat)font AndTextColor:(UIColor *)color
{
    UITextField *textF=[[UITextField alloc]initWithFrame:frame];
    textF.userInteractionEnabled = YES;
    textF.textColor = color;
    textF.font =[UIFont systemFontOfSize:font];
    textF.placeholder=placeholder;
    textF.delegate = self;
    return textF;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameTF resignFirstResponder];
    [_phoneTF resignFirstResponder];
}
- (void)goToBack{
    [self.navigationController popViewControllerAnimated:YES];
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
