//
//  PostSignInViewController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/2/25.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//提交签到页面

#import "PostSignInViewController.h"
#import "FinishSignController.h"
//#define TopSpace  [UIView getWidth:10.0f]

@interface PostSignInViewController ()<UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    //第一部分
    UIView     *_timePlaceView;
    UILabel    *_timeTitleLabel;
    UILabel    *_currentTimeLabel;
    UILabel    *_signPlaceLabel;
    UIButton   *_currentPlaceBtn;
    
    //中间部分
    UIView     *_recordView;
    UILabel    *_recordTitle;
    UITextView *_textView;
    UIButton   *_takePictureBtn;
    UIImageView *_showPicView;
    
    //下面部分
    UILabel    *_companyTitle;
//    UILabel    *_companyNameLabel;
    UITextField  *_companyField;
    CGFloat       diff;//键盘弹出时 高度差
    
    UIButton   *_postBtn;//提交按钮
    
    CGFloat   TopSpace;
    
    
}
@end

@implementation PostSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"签到签退";
    self.view.backgroundColor = [UIColor whiteColor];
    if (IPhone4S) {
        TopSpace = 5.0f;
    }else{
        TopSpace =  [UIView getWidth:10.0f];
    }
    [self creatSignInfoView];// 签到 时间和地点
    [self creatRecordView];//备注视图
    [self creatCompnyView];
    [self creatPostBtn];//提交按钮
    
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(popLastView)];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   
}

- (void)creatSignInfoView
{
    _timePlaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KSCreenW, [UIView getHeight:100])];
    _timePlaceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_timePlaceView];
    
    _timeTitleLabel = [ViewTool getLabelWith:CGRectMake(2 * TopSpace, TopSpace, 80, 15) WithTitle:@"签到时间" WithFontSize:10.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_timePlaceView addSubview:_timeTitleLabel];
    
    _currentTimeLabel = [ViewTool getLabelWith:CGRectMake(_timeTitleLabel.x, _timeTitleLabel.maxY + TopSpace, 80, 20) WithTitle:self.currentTime WithFontSize:15.0f WithTitleColor:[UIColor colorWithWhite:0.3 alpha:0.8] WithTextAlignment:NSTextAlignmentLeft];
     [_timePlaceView addSubview:_currentTimeLabel];
    
    
    UIView *line = [ViewTool getLineViewWith:CGRectMake(_currentTimeLabel.x, _currentTimeLabel.maxY + TopSpace, KSCreenW - 4 * TopSpace, 0.8) withBackgroudColor:[UIColor colorWithWhite:0.85 alpha:0.8]];
    [_timePlaceView addSubview:line];
    
    
    _signPlaceLabel = [ViewTool getLabelWith:CGRectMake(_currentTimeLabel.x, line.maxY + TopSpace, 80, 15) WithTitle:@"签到地点" WithFontSize:10.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_timePlaceView addSubview:_signPlaceLabel];
    
    
    CGFloat w = [self.currentPlace boundingRectWithSize:CGSizeMake(MAXFLOAT , 20) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIView getFontWithSize:15.0f]} context:nil].size.width;
    _currentPlaceBtn = [[UIButton alloc] initWithFrame:CGRectMake(_signPlaceLabel.x, _signPlaceLabel.maxY + TopSpace, w, 20)];
    [_currentPlaceBtn setTitleColor:[UIColor colorWithWhite:0.3 alpha:0.8] forState:UIControlStateNormal];
//    _currentPlaceBtn.backgroundColor = [UIColor whiteColor];
//    _currentPlaceBtn setImage:[UIImage ] forState:<#(UIControlState)#>
    _currentPlaceBtn.titleLabel.font = [UIView getFontWithSize:15.0f];
    [_timePlaceView addSubview:_currentPlaceBtn];
    
    UIView * lighGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, _currentPlaceBtn.maxY + TopSpace, KSCreenW, [UIView getHeight:20])];
    lighGrayView.backgroundColor = graySectionColor;
    [_timePlaceView addSubview:lighGrayView];
    _timePlaceView.frame = CGRectMake(0, 64, KSCreenW, lighGrayView.maxY);

}

- (void)creatRecordView
{
    _recordView = [[UIView alloc] initWithFrame:CGRectMake(0, _timePlaceView.maxY, KSCreenW, [UIView getHeight:130])];
    _recordView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_recordView];
    
//    [UIColor colorWithRed:162 / 255 green:162 / 255 blue:162 / 255 alpha:1];
    _recordTitle = [ViewTool getLabelWith:CGRectMake(2 * TopSpace,2 * TopSpace, 200, 15) WithTitle:@"请填写签到备注" WithFontSize:12.0 WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_recordView addSubview:_recordTitle];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(2 * TopSpace, _recordTitle.maxY + 2, KSCreenW - 4 * TopSpace, [UIView getHeight:50])];
    _textView.delegate = self;
//    _textView.layer.borderWidth = 0.5;
//    _textView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    _textView.font = [UIView getFontWithSize:13.0f];
    [_recordView addSubview:_textView];
    
    
    _takePictureBtn = [[UIButton alloc] initWithFrame:CGRectMake(_textView.x, _textView.maxY + TopSpace, [UIView getWidth:50], [UIView getWidth:50])];
    [_takePictureBtn addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    [_takePictureBtn setImage:[UIImage imageNamed:@"相机star"] forState:UIControlStateNormal];
//    _takePictureBtn.backgroundColor = [UIColor orangeColor];
    [_recordView addSubview:_takePictureBtn];
    
    _showPicView = [[UIImageView alloc] initWithFrame:CGRectMake(_takePictureBtn.maxX + TopSpace, _takePictureBtn.y, _takePictureBtn.height, _takePictureBtn.height)];
    [_recordView addSubview:_showPicView];
    
    
    UIView * lighGrayView2 = [[UIView alloc] initWithFrame:CGRectMake(0, _takePictureBtn.maxY + 2 * TopSpace, KSCreenW, [UIView getHeight:20])];
    lighGrayView2.backgroundColor = graySectionColor;
    [_recordView addSubview:lighGrayView2];
    _recordView.frame = CGRectMake(0, _timePlaceView.maxY, KSCreenW, lighGrayView2.maxY );
    
}

- (void)creatCompnyView
{
    _companyTitle = [ViewTool getLabelWith:CGRectMake(2 * TopSpace, _recordView.maxY + 2 * TopSpace, 100, 15) WithTitle:@"当前企业" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_companyTitle];
    
    _companyField = [[UITextField alloc] initWithFrame:CGRectMake(_companyTitle.x, _companyTitle.maxY + 5, KSCreenW - 4 * TopSpace, 20)];
    _companyField.delegate = self;
    _companyField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_companyField];
    
    UIView *line2 = [ViewTool getLineViewWith:CGRectMake(_companyTitle.x, _companyField.maxY + TopSpace, KSCreenW - 4 * TopSpace, 0.8) withBackgroudColor:[UIColor colorWithWhite:0.85 alpha:0.8]];
    [self.view addSubview:line2];
}

- (void)creatPostBtn
{
    _postBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCreenH - 64, KSCreenW, 64)];
    [_postBtn addTarget:self action:@selector(postSignInfo:) forControlEvents:UIControlEventTouchUpInside];
    [_postBtn setTitleColor:darkOrangeColor forState:UIControlStateNormal];
    _postBtn.backgroundColor = TabbarColor;
    [_postBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _postBtn.width, 1)];
    lineLabel.backgroundColor = grayLineColor;
    [_postBtn addSubview:lineLabel];
    
    [self.view addSubview:_postBtn];
}
//获取照片
- (void)takePicture:(UIButton *)sender
{
    //uialertsheet
    if(IOS7){
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开手机相册",@"手机相机拍摄", nil];
        [actionSheet showInView:self.view];
    }else{
        UIAlertController * alertionControll = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"打开手机相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self takePictureInPhone];
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"手机相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self takePictureWithCamera];
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertionControll addAction:action1];
        [alertionControll addAction:action2];
        [alertionControll addAction:action3];
        if(alertionControll != nil){
            [self presentViewController:alertionControll animated:YES completion:nil];
        }
    }
   
   
                              
}
#pragma mark -- 相册
- (void)takePictureInPhone
{
    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    imagePick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePick.delegate = self;//遵循两个代理方法
    imagePick.allowsEditing = YES;
    [self presentViewController:imagePick animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择类型是图片的时候
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [picker dismissViewControllerAnimated:YES completion:nil];
        NSData *data;//将图片转成data类型
        data = UIImageJPEGRepresentation(image, 1.0);//后参数压缩系数
        
        NSString * docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSFileManager * fielManege = [NSFileManager defaultManager];
        [fielManege createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fielManege createFileAtPath:[NSString stringWithFormat:@"%@%@",docPath,@"/image.png"] contents:data attributes:nil];
        
        _showPicView.image = image;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 相机
- (void)takePictureWithCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后可编辑图片
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"无法打开摄像机" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:nil];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:action];
    }
    
}

#pragma mark --actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self takePictureInPhone];
    }else if (buttonIndex == 1){
        [self takePictureWithCamera];
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    [actionSheet dismissWithClickedButtonIndex:2 animated:YES];
}
#pragma mark --/提交签到
//提交签到
- (void)postSignInfo:(UIButton *)btn
{
//    FinishSignController *finishVC = [[FinishSignController alloc] init];
//    [self.navigationController pushViewController:finishVC animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark --textview代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [_textView resignFirstResponder];
    return YES;
}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
#pragma mark --textfield代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![_textView isExclusiveTouch] || ![_companyField isExclusiveTouch]) {
        [_textView resignFirstResponder];
        [_companyField resignFirstResponder];
    }
}
#pragma mark --键盘通知
- (void)keyboardWillShow:(NSNotification *)noti
{
    if(_companyField.isFirstResponder){
        NSDictionary *usrInfoDict = noti.userInfo;
        NSLog(@"%@",usrInfoDict);
        CGRect keyRect = [usrInfoDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat showtime = [usrInfoDict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        diff = fabs( keyRect.origin.y - _companyField.maxY) + [UIView getHeight:20];
       
        if (keyRect.origin.y < _companyField.maxY) {
            [UIView animateWithDuration:showtime animations:^{
//                self.view.transform = CGAffineTransformMakeTranslation(0, -diff);
                self.view.frame = CGRectMake(0, -diff, KSCreenW, KSCreenH - 64);
            }];
        }
    }else if(_textView.isFirstResponder){
        NSDictionary *usrInfoDict1 = noti.userInfo;
    
        CGRect keyRect1 = [usrInfoDict1[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat showtime1 = [usrInfoDict1[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect rect = [_textView convertRect:_textView.frame toView:self.view ];

        diff = fabs( keyRect1.origin.y - CGRectGetMaxY(rect)) + [UIView getHeight:20];
//        NSLog(@"%f,%f",keyRect1.origin.y, CGRectGetMaxY(rect));
        if (keyRect1.origin.y < CGRectGetMaxY(rect)) {
            [UIView animateWithDuration:showtime1 animations:^{
                //                self.view.transform = CGAffineTransformMakeTranslation(0, -diff);
                self.view.frame = CGRectMake(0, -diff, KSCreenW, KSCreenH - 64);
            }];
        }
    }
    
}
- (void)keyboardWillHide:(NSNotification *)noti
{
    if (self.view.y < 0) {
        NSDictionary *InfoDict = noti.userInfo;
        
        CGFloat Hidetime = [InfoDict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:Hidetime animations:^{
            self.view.frame = CGRectMake(0, 0, KSCreenW, KSCreenH);
        }];
    }
//    NSDictionary *InfoDict = noti.userInfo;
//
//    CGFloat Hidetime = [InfoDict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
//  [UIView animateWithDuration:Hidetime animations:^{
//      self.view.transform = CGAffineTransformMakeTranslation(0,- diff);
//  }];

}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
- (void)popLastView
{
    NSString * docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString * imagePath = [NSString stringWithFormat:@"%@/image.png",docPath];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    
    //注意字典的里面的元素 要判断 不能是空的才可以
    NSDictionary *dict = @{@"token":TOKEN,@"uid": @(UID),@"address":_currentPlaceBtn.currentTitle,@"remark":_textView.text,@"company" : _companyField.text,@"type" : @(self.signType),@"img": data};
    [DataTool sendGetWithUrl:POST_SIGN_URL parameters:dict success:^(id data) {
        id backData = CRMJsonParserWithData(data);
        NSLog(@"%@",backData);
    } fail:^(NSError *error) {
        NSLog(@"error :%@",error.localizedDescription);
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didReceiveMemoryWarning
{
        [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。注意跟ios6.0之前的区分
        // Add code to clean up any of your own resources that are no longer necessary.
        // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidUnLoad
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
            //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载，在WWDC视频也忽视这一点。
            if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
            {
                // Add code to preserve data stored in the views that might be
                // needed later.
                // Add code to clean up other strong references to the view in
                // the view hierarchy.
                self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
            }
        }
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
