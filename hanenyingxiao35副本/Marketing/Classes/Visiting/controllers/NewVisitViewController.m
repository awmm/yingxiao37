//
//  NewVisitViewController.m
//  Marketing
//
//  Created by wmm on 16/3/3.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "NewVisitViewController.h"
#import "Toast+UIView.h"
#import "SelectClientViewController.h"

#define STARTX [UIView getWidth:20]
#define MYCELLHEIGHT 80

@interface NewVisitViewController ()<UITextFieldDelegate,SelectClientViewDelegate>
{
    NSArray    *_basicArray;
    NSArray    *_placeholderArray;
    UIScrollView * scrollView;
}


@property(nonatomic,strong)UILabel        *visitDateLbl;
@property(nonatomic,strong)UITextField    *companyFld;
@property(nonatomic,strong)UITextField    *visitObjectFld;
@property(nonatomic,strong)UITextField    *visitTypeFld;
@property(nonatomic,strong)UITextField    *visitAddressFld;
@property(nonatomic)BOOL    isRemind;

@property(nonatomic,strong)UISwitch       *switchBtn;

@property(nonatomic,strong)NSString       *ordertime;
@property(nonatomic,strong)UIButton       *submitBtn;

@property(nonatomic)int       cid;
@property(nonatomic,strong)NSMutableArray   *typeListArray;
@property(nonatomic)int       type;
@end

@implementation NewVisitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"新建拜访";
    
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    _basicArray = @[@"拜访日期",@"公司名称",@"访问对象",@"拜访类型",@"预约地址"];
    _placeholderArray = @[@"",@"请添加公司",@"请添加人员",@"请选择类型",@"请输入拜访地址"];
    
    [self reloadData];
    [self createUI];
    
    [UIView getHeight:60];    
}

- (void)reloadData{
    NSDictionary * paramesdictionary = @{@"token": TOKEN,@"uid" : @(UID),@"type":@5};
    NSLog(@"%@,-----%d",TOKEN,UID);
    [DataTool sendGetWithUrl:GET_DICTIONARY_URL parameters:paramesdictionary success:^(id data) {
        NSLog(@"%@",data);
        NSDictionary * backData = CRMJsonParserWithData(data);
        int code = [[(NSDictionary *)backData objectForKey:@"code"] intValue];
        if(code != 100)//连接500和501
        {
            NSString * message = [(NSDictionary *)backData objectForKey:@"message"];
            [self.view makeToast:message];
        }else{
            _typeListArray = [(NSDictionary *)backData objectForKey:@"list"];
            NSLog(@"%@-----",_typeListArray);
        }
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}
- (void)createUI{
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH - [UIView getHeight:50])];
    scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    _submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, KSCreenH - 44, KSCreenW, 44)];
    _submitBtn.layer.borderWidth = 0.5;
    _submitBtn.layer.borderColor = grayLineColor.CGColor;
    _submitBtn.backgroundColor = graySectionColor;
    [_submitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitNewVisit) forControlEvents:UIControlEventTouchUpInside];
    _submitBtn.userInteractionEnabled=NO;//不可点击
    _submitBtn.alpha=0.4;
    [self.view addSubview:_submitBtn];
    
    
    [self initListView];
    
}
- (void)initListView{
    CGFloat labelH = 20;
    CGFloat tfH    = 30;
    CGFloat tfY    = 30+ labelH;
    CGFloat tfW    = [UIView getWidth:200];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = grayLineColor;
    [scrollView addSubview:lineView];
    
    for (int i = 0; i<_basicArray.count; i++) {
        UILabel *label = [ViewTool getLabelWith:CGRectMake(STARTX, 10+MYCELLHEIGHT*i, KSCreenW, labelH) WithTitle:_basicArray[i] WithFontSize:14.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
        [scrollView addSubview:label];
        
        UIView *line = [ViewTool getLineViewWith:CGRectMake(STARTX, (MYCELLHEIGHT)*(i+1)-1 , KSCreenW - 2*STARTX, 1) withBackgroudColor:grayLineColor];
        [scrollView addSubview:line];
    }    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"MM月dd日   HH:mm"];//HH 大写就是24小时制 小写就是12小时制
    NSString * dateStr = [formate stringFromDate:date];
    
    NSDateFormatter *formate2 = [[NSDateFormatter alloc] init];
    [formate2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//HH 大写就是24小时制 小写就是12小时制
    _ordertime = [formate2 stringFromDate:date];
    
    _visitDateLbl = [self addLableWithFrame:CGRectMake(STARTX, 40, tfW, tfH) AndStr:dateStr  AndTextColor:[UIColor lightGrayColor]];
    UIButton *dateBtn = [self createButtonWithFrame:CGRectMake(KSCreenW-STARTX-30, 40, 25, 25) WithImage:@"calendar.png" WithTag:0];
    _companyFld = [self addTextFieldWithFrame:CGRectMake(STARTX, _visitDateLbl.maxY + tfY, tfW, tfH) AndStr:@"请添加公司"  AndTextColor:[UIColor lightGrayColor]];

    UIButton *companyBtn = [self createButtonWithFrame:CGRectMake(KSCreenW-STARTX-30, _visitDateLbl.maxY + tfY, 25, 25) WithImage:@"company.png" WithTag:1];

    _visitObjectFld = [self addTextFieldWithFrame:CGRectMake(STARTX, _companyFld.maxY + tfY, tfW, tfH) AndStr:@"请添加人员"  AndTextColor:[UIColor lightGrayColor]];
    
    _visitTypeFld = [self addTextFieldWithFrame:CGRectMake(STARTX, _visitObjectFld.maxY + tfY, tfW, tfH) AndStr:@"请选择人员"  AndTextColor:[UIColor lightGrayColor]];

    UIButton *typeBtn = [self createButtonWithFrame:CGRectMake(KSCreenW-STARTX-30, _visitObjectFld.maxY + tfY, 25, 25) WithImage:@"type.png" WithTag:2];

    _visitAddressFld = [self addTextFieldWithFrame:CGRectMake(STARTX, _visitTypeFld.maxY + tfY, tfW, tfH) AndStr:@"请输入拜访地址"  AndTextColor:[UIColor lightGrayColor]];
    _visitAddressFld.returnKeyType =UIReturnKeyGo;//return键
    UILabel *remindLabel = [ViewTool getLabelWith:CGRectMake(STARTX, _visitAddressFld.maxY + 30, tfW, labelH) WithTitle:@"预约提醒" WithFontSize:14.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];

    _switchBtn =[[UISwitch alloc]init];
    _switchBtn.frame=CGRectMake(KSCreenW-STARTX-50, _visitAddressFld.maxY + 25, 35, 10);
    _switchBtn.onTintColor=blueFontColor;
    _switchBtn.thumbTintColor=[UIColor whiteColor];
    
    [_switchBtn setOn:YES animated:YES];
    
    [_switchBtn addTarget:self action:@selector(getValue1:) forControlEvents:UIControlEventValueChanged];
    
    if (_switchBtn.isOn) {
        NSLog(@"It is On");
        _isRemind = YES;
    }else{
        _isRemind = NO;
    }
    
    UIView *line = [ViewTool getLineViewWith:CGRectMake(STARTX, _visitAddressFld.maxY + 69 , KSCreenW - 2*STARTX, 1) withBackgroudColor:grayLineColor];
    
    _companyFld.delegate = self;
    _visitAddressFld.delegate = self;
    _visitObjectFld.delegate = self;
    _visitTypeFld.delegate = self;
    
    [scrollView addSubview:_visitDateLbl];
    [scrollView addSubview:dateBtn];
    [scrollView addSubview:_companyFld];
    [scrollView addSubview:companyBtn];
    [scrollView addSubview:_visitObjectFld];
    [scrollView addSubview:_visitTypeFld];
    [scrollView addSubview:typeBtn];
    [scrollView addSubview:_visitAddressFld];
    [scrollView addSubview:remindLabel];
    [scrollView addSubview:line];
    [scrollView addSubview:_switchBtn];
    
}

- (void)getValue1:(UISwitch *)switchBtn{
    if (_isRemind) {
        _isRemind = NO;
        _switchBtn.tintColor=grayLineColor;
        _switchBtn.thumbTintColor=blueFontColor;

    }else{
        _isRemind = YES;
        _switchBtn.onTintColor=blueFontColor;
        _switchBtn.thumbTintColor=[UIColor whiteColor];
    }
    
}

- (void)clickToSelect:(UIButton *)btn{
    if (btn.tag == 0) {
        NSLog(@"date");
        
    }else if (btn.tag == 1){
        NSLog(@"company");
        SelectClientViewController *selectClientViewController = [[SelectClientViewController alloc] init];
        selectClientViewController.delegate = self;//设置代理
        [self.navigationController pushViewController:selectClientViewController animated:YES];
    }else{
//        if(IOS7){
//            UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开手机相册",@"手机相机拍摄", nil];
//            [actionSheet showInView:self.view];
//        }else{
                NSLog(@"type");
            UIAlertController * alertionControll = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

            for (int i = 0; i<_typeListArray.count; i++) {
                NSString *title = [(NSDictionary *)_typeListArray[i] objectForKey:@"level"];
                int value = [[(NSDictionary *)_typeListArray[i] objectForKey:@"value"] intValue];
                UIAlertAction * action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self selectVisitType:title withValue:value];
                }];
                [alertionControll addAction:action];
            }
            
            UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];

            [alertionControll addAction:action3];
            if(alertionControll != nil){
                [self presentViewController:alertionControll animated:YES completion:nil];
            }
        }
//    }
}

- (void)selectVisitType:(NSString *)typeName withValue:(int)value{
    
    NSLog(@"%@======%d",typeName,value);
    
    _visitTypeFld.text = typeName;
    self.type = value;
}


//提交按钮
- (void)submitNewVisit{
    NSLog(@"submitNewVisit");
    
    if (_companyFld.text == nil | [_companyFld.text length] == 0 ){
        [self.view makeToast:@"请添加公司"];
        return;
    }else if (_visitObjectFld.text == nil | [_visitObjectFld.text length] == 0 ){
        [self.view makeToast:@"请添加人员"];
        return;
    }else if (_visitTypeFld.text == nil | [_visitTypeFld.text length] == 0 ){
        [self.view makeToast:@"请选择拜访类型"];
        return;
    }else if (_visitAddressFld.text == nil | [_visitAddressFld.text length] == 0 ){
        [self.view makeToast:@"请输入拜访地址"];
        return;
    }
        NSLog(@"------");
    [self.view makeToastActivity];

    int isclock;
    if (_isRemind) {
        isclock = 1;
    }else{
        isclock = 0;
    }
    
//    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:@(_cid), @"cid", _ordertime, @"ordertime", @(_type), @"type",isclock, @"isclock",_visitAddressFld.text,@"address", nil];
    
    NSDictionary * paramesdictionary = @{@"token": TOKEN,@"uid" : @(UID),@"cid":@(_cid),@"ordertime":_ordertime,@"type":@(_type),@"isclock":@(isclock),@"address":_visitAddressFld.text};
    
    NSLog(@"%@",paramesdictionary);
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:GET_VISIT_URL parameters:paramesdictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.view hideToastActivity];
        NSLog(@"%@",responseObject);
        int code = [[(NSDictionary *)responseObject objectForKey:@"code"] intValue];
        if(code != 100)
        {
            NSString * message = [(NSDictionary *)responseObject objectForKey:@"message"];
            [self.view makeToast:message];
        }else{
            [self.view makeToast:@"新建成功"];
            [self goToBack];
//            self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self.view hideToastActivity];
        [self.view makeToast:@"新建失败"];
    }];
}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}
-(UITextField *)addTextFieldWithFrame:(CGRect)frame AndStr:(NSString *)placeholder AndTextColor:(UIColor *)color
{
    UITextField *textF=[[UITextField alloc]initWithFrame:frame];
    textF.userInteractionEnabled = YES;
    textF.textColor = color;
    textF.placeholder=placeholder;
    textF.delegate = self;
    return textF;
}

-(UILabel *)addLableWithFrame:(CGRect)frame AndStr:(NSString *)text AndTextColor:(UIColor *)color
{
    UILabel *textL=[[UILabel alloc]initWithFrame:frame];
    textL.userInteractionEnabled = YES;
    textL.textColor = color;
    textL.text = text;
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
}

//SelectClientViewDelegate
- (void)selectClient:(int)tag withName:(NSString *)companyName withCname:(NSString *)cName{
    
    NSLog(@"%d4444%@44444%@",tag,companyName,cName);
    _cid = tag;
    _companyFld.text = companyName;
    _visitObjectFld.text = cName;
}

//键盘
- (void)textFieldChanged:(UITextField *)textField{
    NSLog(@"00000");
    if(_companyFld.text != nil & [_companyFld.text length] !=0 & _visitObjectFld.text != nil & [_visitObjectFld.text length] != 0 & _visitTypeFld.text != nil & [_visitTypeFld.text length] != 0 & _visitAddressFld.text != nil & [_visitAddressFld.text length] != 0 ){
        _submitBtn.userInteractionEnabled=YES;//可点击
        _submitBtn.alpha=1;
    }else{
        _submitBtn.userInteractionEnabled=NO;//不可点击
        _submitBtn.alpha=0.4;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}



//关闭虚拟键盘。
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _visitAddressFld){
        [self submitNewVisit];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_companyFld resignFirstResponder];
    [_visitObjectFld resignFirstResponder];
    [_visitTypeFld resignFirstResponder];
    [_visitAddressFld resignFirstResponder];

    
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