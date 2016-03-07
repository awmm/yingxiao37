//
//  ForgetPassViewController.m
//  Marketing
//
//  Created by wmm on 16/2/28.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "ForgetPassViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Toast+UIView.h"
#import "JudgeNumber.h"
#import "MyTabBarController.h"
#import "DataTool.h"
#import "ResetPassViewController.h"
#import "DateTool.h"

@interface ForgetPassViewController ()

@property (nonatomic, strong) UITextField *phoneFld;
@property (nonatomic, strong) UITextField *checkFld;
@property (nonatomic, strong) UITextField *checkFld2;

@property (nonatomic, strong) UIImageView *checkPic;
@property (nonatomic, strong) NSString *imgKey;

@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UIButton *getCodeBtn;

@end

@implementation ForgetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat statusBarHeight = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue] <= 7.0)
    {
        statusBarHeight = 20;
    }
    self.navigationItem.title = @"忘记密码";
    
    [self getCodeImg];
    
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake1(20,statusBarHeight+44+20, 22, 24)];
    phoneImg.image = [UIImage imageNamed:@"phone.png"];
    [self.view addSubview:phoneImg];
    
    UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake1(50,statusBarHeight+44+20, 80, 22)];
    phoneLab.text = @"手机号";
    phoneLab.textColor = blackFontColor;
    phoneLab.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:phoneLab];
    _phoneFld = [[UITextField alloc] initWithFrame:CGRectMake1(130,statusBarHeight+44+20, KSCreenW-150, 22)];
    _phoneFld.placeholder = @"请输入手机号";
    _phoneFld.keyboardType = UIKeyboardTypePhonePad;//电话键盘
    [_phoneFld setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_phoneFld];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake1(10,statusBarHeight+44+20+37, KSCreenW-20, 1)];
    line.layer.borderWidth = 18;
    line.layer.borderColor = [grayLineColor CGColor];
    [self.view addSubview:line];
    
    
    UIImageView *checkImg = [[UIImageView alloc] initWithFrame:CGRectMake1(20,statusBarHeight+44+20+57, 22, 24)];
    checkImg.image = [UIImage imageNamed:@"checkpic.png"];
    [self.view addSubview:checkImg];
    UILabel *checkLab = [[UILabel alloc] initWithFrame:CGRectMake1(50,statusBarHeight+44+20+57, 80, 22)];
    checkLab.text = @"图形验证";
    checkLab.textColor = blackFontColor;
    checkLab.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:checkLab];
    _checkFld = [[UITextField alloc] initWithFrame:CGRectMake1(130,statusBarHeight+44+20+57, 100, 22)];
    _checkFld.placeholder = @"请输入图中字符";
    [_checkFld setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_checkFld];
    
    //    UIView *changeView = [[UIView alloc] initWithFrame:CGRectMake1(320,statusBarHeight+44+20+55, 76, 50)];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    changeBtn.frame = CGRectMake1(250,statusBarHeight+44+20+46, 50, 40);
    [changeBtn addTarget:self action:@selector(getCodeImg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    self.checkPic = [[UIImageView alloc] initWithFrame:CGRectMake1(236,statusBarHeight+44+20+44, 62, 34)];
    [self.view addSubview:self.checkPic];
    UILabel *changeLab = [[UILabel alloc] initWithFrame:CGRectMake1(236,statusBarHeight+44+20+48+32, 62, 10)];
    changeLab.text = @"换一张";
    changeLab.textAlignment = NSTextAlignmentCenter;
    changeLab.font = [UIFont systemFontOfSize:11];
    changeLab.textColor = grayFontColor;
    [self.view addSubview:changeLab];
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake1(10,statusBarHeight+44+20+57+37, KSCreenW-20, 1)];
    line2.layer.borderWidth = 1;
    line2.layer.borderColor = [grayLineColor CGColor];
    [self.view addSubview:line2];
    
    UIImageView *checkImg2 = [[UIImageView alloc] initWithFrame:CGRectMake1(20,statusBarHeight+44+20+57+57, 22, 24)];
    checkImg2.image = [UIImage imageNamed:@"checkcode.png"];
    [self.view addSubview:checkImg2];
    UILabel *checkLab2 = [[UILabel alloc] initWithFrame:CGRectMake1(50,statusBarHeight+44+20+57+57, 80, 22)];
    checkLab2.text = @"验证码";
    checkLab2.textColor = blackFontColor;
    checkLab2.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:checkLab2];
    _checkFld2 = [[UITextField alloc] initWithFrame:CGRectMake1(130,statusBarHeight+44+20+57+57, 100, 22)];
    _checkFld2.placeholder = @"请输入验证码";
    _checkFld2.returnKeyType =UIReturnKeyGo;//return键
    [_checkFld2 setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:_checkFld2];
    _getCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_getCodeBtn setTitle:NSLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    _getCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _getCodeBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_getCodeBtn setBackgroundColor:yellowBgColor];
    _getCodeBtn.layer.cornerRadius = 2.0;//圆角
    _getCodeBtn.userInteractionEnabled=NO;//不可点击
    _getCodeBtn.alpha=0.4;//变灰
    _getCodeBtn.frame = CGRectMake1(234, statusBarHeight+44+20+57+50, 64, 34);
    [_getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getCodeBtn];
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake1(10,statusBarHeight+44+20+57+57+37, 320-20, 1)];
    line3.layer.borderWidth = 1;
    line3.layer.borderColor = [grayLineColor CGColor];
    [self.view addSubview:line3];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_submitBtn setTitle:NSLocalizedString(@"确认提交", nil) forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [_submitBtn setBackgroundColor:mainOrangeColor];
    _submitBtn.layer.cornerRadius = 4.0;//圆角
    _submitBtn.frame = CGRectMake(20, self.view.frame.size.height-120, KSCreenW-40, 50);
    _submitBtn.userInteractionEnabled=NO;//不可点击
    _submitBtn.alpha=0.4;//变灰
    [_submitBtn addTarget:self action:@selector(sumitPhoneCheck) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_submitBtn];
    
    _phoneFld.delegate = self;
    _checkFld.delegate = self;
    _checkFld2.delegate = self;
    
    [_phoneFld addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_checkFld addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [_checkFld2 addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)getCodeImg{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:GET_IMGCODE_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _imgKey = [(NSDictionary *)responseObject objectForKey:@"imgKey"];
        NSString *str= [(NSDictionary *)responseObject objectForKey:@"data"];
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *image =[[UIImage alloc] initWithData:imageData];
        [self.checkPic setImage:image];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getCode{
    if (_phoneFld.text == nil | [_phoneFld.text length] == 0 | ![JudgeNumber boolenPhone:_phoneFld.text]){
        [self.view makeToast:@"请输入正确的手机号"];
        return;
    }else if (_checkFld.text == nil | [_checkFld.text length] == 0 ){
        [self.view makeToast:@"请输入图形验证码"];
    }else{
        NSString *fwd = @"fwd";
        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:_phoneFld.text, @"username", _imgKey, @"imgKey",  _checkFld.text, @"code", fwd, @"fwd", nil];
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = 20;
        [manager POST:GET_PHONECODE_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            int code = [[(NSDictionary *)responseObject objectForKey:@"code"] intValue];
            if(code != 100)//连接500和501
            {
                NSString * message = [(NSDictionary *)responseObject objectForKey:@"message"];
                [self.view makeToast:message];
            }else{
                [DateTool startTime:_getCodeBtn];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)sumitPhoneCheck{
    NSLog(@"sumitPhoneCheck");
    if (_phoneFld.text == nil | [_phoneFld.text length] == 0 ){
        [self.view makeToast:@"请输入手机号"];
        return;
    }else if (![JudgeNumber boolenPhone:_phoneFld.text]){
        [self.view makeToast:@"请输入正确的手机号"];
        return;
    }else if (_checkFld.text == nil | [_checkFld.text length] == 0 ){
        [self.view makeToast:@"请输入图形验证码"];
        return;
    }else if (_checkFld2.text == nil | [_checkFld2.text length] == 0 ){
        [self.view makeToast:@"请输入验证码"];
        return;
    }
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:_phoneFld.text, @"username", _checkFld2.text, @"phoneCode", nil];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:FIND_PASS_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        int code = [[(NSDictionary *)responseObject objectForKey:@"code"] intValue];
        if(code != 100)
        {
            NSString * message = [(NSDictionary *)responseObject objectForKey:@"message"];
            [self.view makeToast:message];
            
        }else{
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:_phoneFld.text forKey:@"username"];
            [userDefaults synchronize];
            
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
            [[UINavigationBar appearance] setTintColor:mainOrangeColor];
            [self.navigationItem setBackBarButtonItem:backItem];
            NSString * fwdKey = [(NSDictionary *)responseObject objectForKey:@"fwdKey"];
            NSLog(@"%@",fwdKey);
            ResetPassViewController *resetPassViewController = [[ResetPassViewController alloc] init];
            resetPassViewController.fwdKey = fwdKey;
            NSLog(@"%@",resetPassViewController.fwdKey);
            [self.navigationController pushViewController:resetPassViewController animated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self.view makeToast:@"注册失败"];
    }];
}

- (void)textFieldChanged:(UITextField *)textField{
    if (textField == _phoneFld) {
        if ([_phoneFld.text length] > 20) {
            _phoneFld.text = [_phoneFld.text substringToIndex:20];
        }
    }
    if (textField == _checkFld) {
        if ([_checkFld.text length] > 10) {
            _checkFld.text = [_checkFld.text substringToIndex:10];
        }
    }
    if (textField == _checkFld2) {
        if ([_checkFld2.text length] > 10) {
            _checkFld2.text = [_checkFld2.text substringToIndex:10];
        }
    }
    if(_phoneFld.text != nil & [_phoneFld.text length] !=0 & _checkFld.text != nil & [_checkFld.text length] != 0 ){
        _getCodeBtn.userInteractionEnabled=YES;//可点击
        _getCodeBtn.alpha=1;
    }else{
        _getCodeBtn.userInteractionEnabled=NO;//不可点击
        _getCodeBtn.alpha=0.4;
    }
    if(_phoneFld.text != nil & [_phoneFld.text length] != 0 & _checkFld.text != nil & [_checkFld.text length] != 0 & _checkFld2.text != nil & [_checkFld2.text length] != 0 ){
        _submitBtn.userInteractionEnabled=YES;//可点击
        _submitBtn.alpha=1;
    }else{
        _submitBtn.userInteractionEnabled=NO;//不可点击
        _submitBtn.alpha=0.4;
    }
}

//关闭虚拟键盘。
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField == _checkFld2){
        [_phoneFld resignFirstResponder];
        [_checkFld resignFirstResponder];
        [_checkFld2 resignFirstResponder];
        [self sumitPhoneCheck];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phoneFld resignFirstResponder];
    [_checkFld resignFirstResponder];
    [_checkFld2 resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

CG_INLINE CGRect
CGRectMake1(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    return CGRectMake(x * app.autoSizeScaleX, y * app.autoSizeScaleY, width * app.autoSizeScaleX, height * app.autoSizeScaleX);
}

CG_INLINE CGRect
CGRectMake2(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    return CGRectMake(x, y * app.autoSizeScaleY, width, height * app.autoSizeScaleX);
}

CG_INLINE CGRect
CGRectMake3(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    return CGRectMake(x, y * app.autoSizeScaleY, width, height);
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
