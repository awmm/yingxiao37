//
//  NewRecordController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/3/1.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//员工新建日志

#import "NewRecordController.h"

@interface NewRecordController ()<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    CGFloat    topSpace ;
    
    UIScrollView  * _scrollView;
    //类型
    UIView        *_typeView;
    UILabel       *_typeLable;
    
    //标题 小结 计划
    UIView        *_workSummaryView;
    UILabel       *_workTitleLabel;
    UITextField   *_workTitleField;
    UILabel       *_workSumlabel;
    UITextField   *_workSummaryField;
    UILabel       *_workPlaneLabel;
    UITextField   *_workPlaneField;
    CGFloat        lastY;//btn
    
    
    UIView       *_workRecordView;
    UILabel      *_recordLabel;
    UITextView   *_textView;
    UIButton     *_recordBtn;
    UIImageView  *_showRecordPic;
    
    
    UIView      *_bottomView;
    UILabel     *_titleLabel;
    UIButton    *_addPersonsBtn;
    
    UIButton    *_postBtn;
    CGFloat      diff ;//记录键盘弹出的高度差
    UIButton    *_lastBtn;//记录三个按钮点击的上一个按钮
}
@end


@implementation NewRecordController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新建日志";
    if (IPhone4S) {
        topSpace = 5.0f;
    }else{
        topSpace = [UIView getWidth:10.0f];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self creatScrollView];
      [self creatTypeView];
    [self creatWorkSummaryView];
    [self creatRecordView];
    [self drawBottomView];
    [self drawPostButton];
    
}

- (void)creatScrollView
{
   
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KSCreenW, KSCreenH - TabbarH )];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScrolltap:)];
    [_scrollView addGestureRecognizer:tap];
    
//    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 50, KSCreenW, 200)];
//    [_scrollView addSubview:vi];
//    vi.backgroundColor = [UIColor orangeColor];
    
    NSLog(@"%@",NSStringFromCGRect(_scrollView.frame));
//    _scrollView.contentSize = CGSizeMake(0, 700);
//    _scrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_scrollView];
   
  
}
- (void)creatTypeView
{
    
    _typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, KSCreenW, [UIView getWidth:70])];
    NSLog(@"%@",NSStringFromCGRect(_typeView.frame));
//    _typeView.backgroundColor = [UIColor cyanColor];
    [_scrollView addSubview:_typeView];
    
    
    _typeLable = [ViewTool getLabelWith:CGRectMake(2 * topSpace, topSpace, 100, 15) WithTitle:@"报表类型" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_typeView addSubview:_typeLable];
    
    NSArray * titleArr = @[@"日报",@"周报",@"月报"];
    CGFloat btnW = [UIView getWidth: 30];
    CGFloat btnH = [UIView getWidth:20];
    for (int i = 0; i < titleArr.count; i ++) {
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(_typeLable.x + (i * (btnW + 2 *topSpace)), _typeLable.maxY + topSpace, btnW, btnH)];
        if (i == 0) {
            btn.selected = YES;
            _lastBtn = btn;
             [btn setBackgroundColor:cyanFontColor];
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            btn.selected = NO;
             [btn setBackgroundColor:TabbarColor];
            [btn setTitleColor:blackFontColor forState:UIControlStateNormal];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
//        CGRect rect = CGRectMake(0, 0, btnW, btnH);
//        [btn setBackgroundImage:[ViewTool getImageFromColor:cyanFontColor WithRect:rect] forState:UIControlStateSelected];
//        [btn setBackgroundImage:[ViewTool getImageFromColor:[UIColor redColor] WithRect:btn.frame] forState:UIControlStateNormal];
//        [btn setBackgroundColor:cyanFontColor];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
//        [btn setTitleColor:blackFontColor forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 10.0f;
        btn.layer.borderWidth = 0.8;
        btn.layer.borderColor = grayLineColor.CGColor;
        [btn addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
        [_typeView addSubview:btn];
        btn.tag = 300 + i;
        if(i == 2){
            lastY = btn.maxY;
        }
        
    }
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, lastY + topSpace, KSCreenW, [UIView getWidth:15.0f])];
    grayView.backgroundColor = graySectionColor;
    [_typeView addSubview:grayView];
    
    _typeView.frame = CGRectMake(0, 0,KSCreenW, grayView.maxY);
    
}

- (void)creatWorkSummaryView
{
    _workSummaryView = [[UIView alloc] initWithFrame:CGRectMake(0, _typeView.maxY, KSCreenW, 200)];
//    _workSummaryView.backgroundColor = [UIColor greenColor];
    [_scrollView addSubview:_workSummaryView];
    
    _workTitleLabel = [ViewTool getLabelWith:CGRectMake(2 * topSpace, topSpace, 100, 15) WithTitle:@"工作标题" WithFontSize:11.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_workSummaryView addSubview:_workTitleLabel];
    
    _workTitleField = [[UITextField alloc] initWithFrame:CGRectMake(_workTitleLabel.x, _workTitleLabel.maxY + topSpace, KSCreenW - 4 * topSpace, 20)];
    [_workSummaryView addSubview:_workTitleField];
    _workTitleField.font = [UIView getFontWithSize:13.0f];
    _workTitleField.placeholder = @"请填写文字(必填)";
    
    UIView *line1 = [ViewTool getLineViewWith:CGRectMake(_workTitleLabel.x, _workTitleField.maxY + topSpace, KSCreenW - 4 * topSpace, 1) withBackgroudColor:grayLineColor];
    [_workSummaryView addSubview:line1];
    
    
    _workSumlabel = [ViewTool getLabelWith:CGRectMake(2 * topSpace, line1.maxY + topSpace, 100, 15) WithTitle:@"工作小结" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_workSummaryView addSubview:_workSumlabel];
    
    _workSummaryField = [[UITextField alloc] initWithFrame:CGRectMake(_workTitleLabel.x, _workSumlabel.maxY + topSpace, KSCreenW - 4 * topSpace, 20)];
    [_workSummaryView addSubview:_workSummaryField];
    _workSummaryField.font = [UIView getFontWithSize:13.0f];
    _workSummaryField.placeholder = @"请填写文字";
    
    UIView *line2 = [ViewTool getLineViewWith:CGRectMake(_workTitleLabel.x, _workSummaryField.maxY + topSpace, KSCreenW - 4 * topSpace, 1) withBackgroudColor:grayLineColor];
    [_workSummaryView addSubview:line2];
    
    
    _workPlaneLabel = [ViewTool getLabelWith:CGRectMake(2 * topSpace, line2.maxY + topSpace, 100, 15) WithTitle:@"工作计划" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_workSummaryView addSubview:_workPlaneLabel];
    
    _workPlaneField = [[UITextField alloc] initWithFrame:CGRectMake(_workTitleLabel.x, _workPlaneLabel.maxY + topSpace, KSCreenW - 4 * topSpace, 20)];
   
    [_workSummaryView addSubview:_workPlaneField];
    _workPlaneField.font = [UIView getFontWithSize:13.0f];
    _workPlaneField.placeholder = @"请填写文字";
    
    
    UIView *grayView1 = [[UIView alloc] initWithFrame:CGRectMake(0, _workPlaneField.maxY + topSpace, KSCreenW, [UIView getWidth:15.0f])];
    grayView1.backgroundColor = graySectionColor;
    [_workSummaryView addSubview:grayView1];
    
//    CGRect rect = [grayView1 convertRect:grayView1.frame toView:_scrollView];
    
    _workSummaryView.frame = CGRectMake(0, _typeView.maxY,KSCreenW, grayView1.maxY );
     _workTitleField.delegate = self;
    _workSummaryField.delegate = self;
    _workPlaneField.delegate = self;
    
}


- (void)creatRecordView
{
    _workRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, _workSummaryView.maxY, KSCreenW, [UIView getHeight:130])];
//    _workRecordView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_workRecordView];
    
    //    [UIColor colorWithRed:162 / 255 green:162 / 255 blue:162 / 255 alpha:1];
    _recordLabel = [ViewTool getLabelWith:CGRectMake(2 * topSpace,2 * topSpace, 200, 15) WithTitle:@"请填写签到备注" WithFontSize:12.0 WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_workRecordView addSubview:_recordLabel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(2 * topSpace, _recordLabel.maxY + 2, KSCreenW - 4 * topSpace, [UIView getHeight:50])];
    _textView.delegate = self;
    //    _textView.layer.borderWidth = 0.5;
    //    _textView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    _textView.font = [UIView getFontWithSize:13.0f];
    [_workRecordView addSubview:_textView];
    
    
    _recordBtn = [[UIButton alloc] initWithFrame:CGRectMake(_textView.x, _textView.maxY + topSpace, [UIView getWidth:50], [UIView getWidth:50])];
    [_recordBtn addTarget:self action:@selector(takePic:) forControlEvents:UIControlEventTouchUpInside];
    [_recordBtn setImage:[UIImage imageNamed:@"相机star"] forState:UIControlStateNormal];
    //    _takePictureBtn.backgroundColor = [UIColor orangeColor];
    [_workRecordView addSubview:_recordBtn];
    
    _showRecordPic = [[UIImageView alloc] initWithFrame:CGRectMake(_recordBtn.maxX + topSpace, _recordBtn.y, _recordBtn.height, _recordBtn.height)];
    _showRecordPic.backgroundColor = [UIColor redColor];
    [_workRecordView addSubview:_recordBtn];
    
    
    UIView * lighGrayView2 = [[UIView alloc] initWithFrame:CGRectMake(0, _showRecordPic.maxY + 2 * topSpace, KSCreenW, [UIView getHeight:20])];
    lighGrayView2.backgroundColor = graySectionColor;
    [_workRecordView addSubview:lighGrayView2];
    
    _workRecordView.frame = CGRectMake(0, _workSummaryView.maxY, KSCreenW, lighGrayView2.maxY);
    
}

- (void)takePicture:(UIButton *)btn
{
    
}
- (void)drawBottomView
{
    //sdf 
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _workRecordView.maxY, KSCreenW, [UIView getHeight:50])];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_bottomView];
    
    _titleLabel = [ViewTool getLabelWith:CGRectMake(2 * topSpace, topSpace, 100, 15.0f) WithTitle:@"发布人群" WithFontSize:13.0 WithTitleColor:lightGrayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_bottomView addSubview:_titleLabel];
    
    _addPersonsBtn = [[UIButton alloc] initWithFrame:[UIView getRectWithX:_titleLabel.x Y:_titleLabel.maxY + topSpace width:[UIView getWidth:30] andHeight:[UIView getWidth:30]]];
    [_addPersonsBtn setImage:[UIImage imageNamed:@"添加人员"] forState:UIControlStateNormal];
    _addPersonsBtn.layer.cornerRadius = _addPersonsBtn.width / 2.0;
    _addPersonsBtn.layer.masksToBounds = YES;
    _addPersonsBtn.backgroundColor = [UIColor lightGrayColor];
    [_addPersonsBtn addTarget:self action:@selector(addPerson:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_addPersonsBtn];
    _bottomView.frame = CGRectMake(0, _workRecordView.maxY, KSCreenW, _addPersonsBtn.maxY +  topSpace);
    NSLog(@"%f,%f",_bottomView.maxY + 64,KSCreenH - TabbarH);
    if (_bottomView.maxY + 64 > KSCreenH - TabbarH) {
        _scrollView.contentSize = CGSizeMake(0, _bottomView.maxY + TabbarH);
    }else{
        _scrollView.contentSize = CGSizeMake(0, 0);
    }
    
}
- (void)drawPostButton
{
    _postBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCreenH - TabbarH, KSCreenW, TabbarH)];
    [_postBtn addTarget:self action:@selector(postDistribute:) forControlEvents:UIControlEventTouchUpInside];
    _postBtn.backgroundColor = TabbarColor;
    [_postBtn setTitle:@"确定提交" forState:UIControlStateNormal];
    [_postBtn setTitleColor:darkOrangeColor forState:UIControlStateNormal];
    [self.view addSubview:_postBtn];
    UIView *line3 = [ViewTool getLineViewWith:CGRectMake(0, 0, KSCreenW, 1) withBackgroudColor:grayLineColor];
    [_postBtn addSubview:line3];
    
    
}

- (void)chooseType:(UIButton *)btn
{
//    NSLog(@"%@%@",_lastBtn.currentTitle,btn.currentTitle);
    if (_lastBtn.tag != btn.tag) {
        [_lastBtn setBackgroundColor:TabbarColor];
        [_lastBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
        _lastBtn = btn;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:cyanFontColor];
    }
    
}

//获取照片
- (void)takePic:(UIButton *)sender
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
        [fielManege createFileAtPath:[NSString stringWithFormat:@"%@%@",docPath,@"/Recordimage.png"] contents:data attributes:nil];
        
        _showRecordPic.image = image;
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

//添加人群
- (void)addPerson:(UIButton *)btn
{
    NSLog(@"添加人群");
}

//提交发布
- (void)postDistribute:(UIButton *)btn
{
    NSLog(@"确定");
}
#pragma mark --收回键盘方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)handleScrolltap:(UITapGestureRecognizer *)tap
{
    if (![_workPlaneField isExclusiveTouch] ||
        ![_workSummaryField isExclusiveTouch] ||
        ![_workTitleField isExclusiveTouch] ||
        ![_textView isExclusiveTouch]) {
        [_workPlaneField resignFirstResponder];
        [_workSummaryField resignFirstResponder];
        [_textView resignFirstResponder];
        [_workTitleField resignFirstResponder];
    }
}
#pragma mark --键盘通知
- (void)keyboardWillShow:(NSNotification *)noti
{
    if(_workTitleField.isFirstResponder){
        NSDictionary *usrInfoDict = noti.userInfo;
        NSLog(@"%@",usrInfoDict);
        CGRect keyRect = [usrInfoDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat showtime = [usrInfoDict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        
        diff = fabs( keyRect.origin.y - _workTitleField.maxY) + [UIView getHeight:20];
        
        if (keyRect.origin.y < _workTitleField.maxY) {
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
    }else if(_workSummaryField.isFirstResponder){
        NSDictionary *usrInfoDict1 = noti.userInfo;
        
        CGRect keyRect1 = [usrInfoDict1[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat showtime1 = [usrInfoDict1[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect rect = [_workSummaryField convertRect:_workSummaryField.frame toView:self.view ];
        
        diff = fabs( keyRect1.origin.y - CGRectGetMaxY(rect)) + [UIView getHeight:20];
        //        NSLog(@"%f,%f",keyRect1.origin.y, CGRectGetMaxY(rect));
        if (keyRect1.origin.y < CGRectGetMaxY(rect)) {
            [UIView animateWithDuration:showtime1 animations:^{
                //                self.view.transform = CGAffineTransformMakeTranslation(0, -diff);
                self.view.frame = CGRectMake(0, -diff, KSCreenW, KSCreenH - 64);
            }];
        }else if(_workPlaneField.isFirstResponder){
            NSDictionary *usrInfoDict1 = noti.userInfo;
            
            CGRect keyRect1 = [usrInfoDict1[UIKeyboardFrameEndUserInfoKey] CGRectValue];
            CGFloat showtime1 = [usrInfoDict1[UIKeyboardAnimationDurationUserInfoKey] floatValue];
            CGRect rect = [_workPlaneField convertRect:_workPlaneField.frame toView:self.view ];
            
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
- (void)popViewcontroll
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
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
@end
