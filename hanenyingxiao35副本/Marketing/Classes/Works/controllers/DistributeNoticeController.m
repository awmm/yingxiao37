//
//  DistributeNoticeController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/2/29.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//发布公告

#import "DistributeNoticeController.h"

@interface DistributeNoticeController ()<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView  * _mainScrollView;
    CGFloat    space;
    UIView      *_topView;
    UILabel     *_noticeTitle;//公告名称
    UITextField *_noticeName;
    UILabel     *_distributeManTitle;
    UITextField *_distributePerson;
    UILabel     *_noticeContentTitle;
    UITextView  *_noticeConten;
    
    UIButton    *_noticePicBtn;
    UIImageView *_showPicImage;
    
    
    UIView      *_coverView;
    UILabel     *_coverImageLabel;
    UIImageView *_showCoverImage;
    UIButton    *_takePicBtn;
    
    
    UIView      *_bottomView;
    UILabel     *_titleLabel;
    UIButton    *_addPersonsBtn;
    
    UIButton    *_postBtn;
    
    CGFloat    diff;
    BOOL       isCoverImage;
    

    
    
}
@end

@implementation DistributeNoticeController


- (void)viewDidLoad
{
    [super viewDidLoad];
    diff = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"新建发布";
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(distributeNotice)];
    if (IPhone4S) {
        space = 5.0;
    }else{
        space = [UIView getWidth:8.0f];
    }
    [self initScrollView];
    [self drawTopView];
    [self drawMidView];
    [self drawBottomView];
    [self drawPostButton];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initScrollView
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KSCreenW, KSCreenH - 64 - 49)];
    _mainScrollView.delegate = self;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [_mainScrollView addGestureRecognizer:tap];
    [self.view addSubview:_mainScrollView];
    
}
- (void)drawTopView
{
    _topView = [[UIView alloc] initWithFrame:[UIView getRectWithX:0 Y:0 width:KSCreenW andHeight:250]];
//    _topView.backgroundColor = [UIColor cyanColor];
    [_mainScrollView addSubview:_topView];
    
    _noticeTitle = [ViewTool getLabelWith:[UIView getRectWithX:2 * space Y:1.5 * space width:100 andHeight:15] WithTitle:@"公告名称" WithFontSize:12.0f WithTitleColor:lightGrayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_topView addSubview:_noticeTitle];
    
    _noticeName = [[UITextField alloc] initWithFrame:CGRectMake(_noticeTitle.x, _noticeTitle.maxY + space, KSCreenW - 4 * space, [UIView getHeight:15.0f])];
    _noticeName.delegate = self;
    [_topView addSubview:_noticeName];
    _noticeName.font = [UIView getFontWithSize:15.0];
//    _noticeName.backgroundColor = [UIColor orangeColor];
    
    UIView *line1 = [ViewTool getLineViewWith:CGRectMake(_noticeTitle.x, _noticeName.maxY + space, KSCreenW - 4 * space, 1) withBackgroudColor:grayLineColor];
    [_topView addSubview:line1];
    
    _distributeManTitle = [ViewTool getLabelWith:CGRectMake(_noticeTitle.x, line1.maxY + 2 * space, 100, [UIView getHeight:15.0f]) WithTitle:@"发布人" WithFontSize:12.0 WithTitleColor:lightGrayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_topView addSubview:_distributeManTitle];
    
    
    _distributePerson = [[UITextField alloc] initWithFrame:CGRectMake(_noticeTitle.x, _distributeManTitle.maxY + space, line1.width, [UIView getHeight:20.0f])];
    _distributePerson.font = [UIView getFontWithSize:15.0f];
    _distributePerson.delegate = self;
    [_topView addSubview:_distributePerson];
    
    UIView *line2 = [ViewTool getLineViewWith:CGRectMake(_noticeTitle.x, _distributePerson.maxY + space, KSCreenW - 4 * space, 0.8) withBackgroudColor:grayLineColor];
    [_topView addSubview:line2];
    
    _noticeContentTitle = [ViewTool getLabelWith:CGRectMake(_noticeName.x, line2.maxY + space, 100, [UIView getHeight:15.0f]) WithTitle:@"发布内容" WithFontSize:12.0 WithTitleColor:lightGrayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_topView addSubview:_noticeContentTitle];
    
    _noticeConten = [[UITextView alloc] initWithFrame:CGRectMake(_noticeTitle.x, _noticeContentTitle.maxY + space, line2.width, [UIView getHeight:80.0f])];
//    _noticeConten.backgroundColor = [UIColor redColor];
    _noticeConten.delegate = self;
    [_topView addSubview:_noticeConten];
    
    
    _noticePicBtn = [[UIButton alloc] initWithFrame:CGRectMake(_noticeTitle.x, _noticeConten.maxY + space, [UIView getWidth:40], [UIView getHeight:40])];
    [_topView addSubview:_noticePicBtn];
    [_noticePicBtn addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    _noticePicBtn.tag = 130;
    [_noticePicBtn setImage:[UIImage imageNamed:@"相机star"] forState:UIControlStateNormal];
    
    _showPicImage = [[UIImageView alloc] init];
    _showPicImage.frame = CGRectMake(_noticePicBtn.maxX + space, _noticePicBtn.y, _noticePicBtn.width, _noticePicBtn.width);
    [_topView addSubview:_showPicImage];
//    _showPicImage.backgroundColor = [UIColor redColor];
    
    
    UIView * lightgrayView = [[UIView alloc] initWithFrame:CGRectMake(0, _noticePicBtn.maxY + 2 * space, KSCreenW, [UIView getHeight:15.0f])];
    lightgrayView.backgroundColor = graySectionColor;
    [_topView addSubview:lightgrayView];
    
    
//    CGRect rect = [lightgrayView convertRect:lightgrayView.frame toView:self.view];
    _topView.frame = CGRectMake(0, 0, KSCreenW, lightgrayView.maxY);
    
    
}

- (void)drawMidView
{
    
    _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, _topView.maxY, KSCreenW, [UIView getWidth:50])];
    _coverView.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:_coverView];
    
    
    _coverImageLabel = [ViewTool getLabelWith:CGRectMake(2 * space, space, [UIView getWidth:60], 15.0f) WithTitle:@"封面图片" WithFontSize:12.0f WithTitleColor:lightGrayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_coverView addSubview:_coverImageLabel];
    
    _showCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(_coverImageLabel.maxX + space, _coverImageLabel.y, [UIView getWidth:30], [UIView getWidth:30])];
    [_coverView addSubview:_showCoverImage];
//    _showCoverImage.backgroundColor = [UIColor redColor];
    
    _takePicBtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCreenW - 2 * space - _showCoverImage.width, _coverImageLabel.y, _showCoverImage.width, _showCoverImage.width)];
    [_coverView addSubview:_takePicBtn];
    [_takePicBtn setImage:[UIImage imageNamed:@"相机star"] forState:UIControlStateNormal];
    [_takePicBtn addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    _takePicBtn.tag = 131;
    
    UIView * grayView = [[UIView alloc] initWithFrame:CGRectMake(0, _showCoverImage.maxY + 2 * space, KSCreenW, [UIView getWidth:15])];
    grayView.backgroundColor = graySectionColor;
    [_coverView addSubview:grayView];
    
    _coverView.frame = CGRectMake(0, _topView.maxY, KSCreenW, grayView.maxY);
    
    
    
}
- (void)drawBottomView
{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _coverView.maxY, KSCreenW, [UIView getHeight:50])];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:_bottomView];
    
    _titleLabel = [ViewTool getLabelWith:CGRectMake(2 * space, space, 100, 15.0f) WithTitle:@"发布人群" WithFontSize:13.0 WithTitleColor:lightGrayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_bottomView addSubview:_titleLabel];
    
    _addPersonsBtn = [[UIButton alloc] initWithFrame:[UIView getRectWithX:_titleLabel.x Y:_titleLabel.maxY + space width:[UIView getWidth:30] andHeight:[UIView getWidth:30]]];
    [_addPersonsBtn setImage:[UIImage imageNamed:@"添加人员"] forState:UIControlStateNormal];
    _addPersonsBtn.layer.cornerRadius = _addPersonsBtn.width / 2.0;
    _addPersonsBtn.layer.masksToBounds = YES;
    _addPersonsBtn.backgroundColor = [UIColor lightGrayColor];
    [_addPersonsBtn addTarget:self action:@selector(addPerson:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_addPersonsBtn];
    _bottomView.frame = CGRectMake(0, _coverView.maxY, KSCreenW, _addPersonsBtn.maxY +  space);
    NSLog(@"%f,%f",_bottomView.maxY + 64,KSCreenH - 49);
    if (_bottomView.maxY + 64 > KSCreenH - 49) {
        _mainScrollView.contentSize = CGSizeMake(0, _bottomView.maxY + 10);
    }else{
 _mainScrollView.contentSize = CGSizeMake(0, 0);
    }

}
- (void)drawPostButton
{
    _postBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCreenH - 49, KSCreenW, 49)];
    [_postBtn addTarget:self action:@selector(postDistribute:) forControlEvents:UIControlEventTouchUpInside];
    [_postBtn setTitle:@"确定提交" forState:UIControlStateNormal];
    [_postBtn setTitleColor:darkOrangeColor forState:UIControlStateNormal];
    [self.view addSubview:_postBtn];
    UIView *line3 = [ViewTool getLineViewWith:CGRectMake(0, 0, KSCreenW, 1) withBackgroudColor:grayLineColor];
    [_postBtn addSubview:line3];
    
    
}
//添加发布人群
- (void)addPerson:(UIButton *)btn
{
    NSLog(@"发部人群");
}

//提交发布
- (void)postDistribute:(UIButton *)btn
{
     NSLog(@"提交注册");
}


- (void)keyboardWillShow:(NSNotification *)noti
{
    NSDictionary *usrInfoDict = noti.userInfo;
//    NSLog(@"%@",usrInfoDict);
    CGRect keyRect = [usrInfoDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat showtime = [usrInfoDict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if(_noticeName.isFirstResponder){
//        NSDictionary *usrInfoDict = noti.userInfo;
//        NSLog(@"%@",usrInfoDict);
//        CGRect keyRect = [usrInfoDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        CGFloat showtime = [usrInfoDict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect rect = [_noticeName convertRect:_noticeName.frame toView:self.view ];
        diff = fabs( keyRect.origin.y - CGRectGetMaxY(rect)) + [UIView getHeight:20];
        
        if (keyRect.origin.y < CGRectGetMaxY(rect)) {
            [UIView animateWithDuration:showtime animations:^{
                //                self.view.transform = CGAffineTransformMakeTranslation(0, -diff);
                self.view.frame = CGRectMake(0, -diff, KSCreenW, KSCreenH - 64);
            }];
        }
    }else if(_noticeConten.isFirstResponder){
//        NSDictionary *usrInfoDict1 = noti.userInfo;
//        
//        CGRect keyRect1 = [usrInfoDict1[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        CGFloat showtime1 = [usrInfoDict1[UIKeyboardAnimationDurationUserInfoKey] floatValue];
#warning 这里转换坐标系 怎么会不对呢
        CGRect rect = [_noticeConten convertRect:_noticeConten.frame toView:self.view ];
//              NSLog(@"%f,%f",keyRect.origin.y, CGRectGetMaxY(rect));
//        NSLog(@"%f,%f,%f,%f",KSCreenH,KSCreenH - 271, CGRectGetMaxY(rect),CGRectGetMaxY(_noticeConten.frame) + 64);
        diff = fabs( keyRect.origin.y - (_noticeConten.maxY + 64)) + [UIView getHeight:20];
        //        NSLog(@"%f,%f",keyRect1.origin.y, CGRectGetMaxY(rect));
        if (keyRect.origin.y < (_noticeConten.maxY + 64)) {
            [UIView animateWithDuration:showtime animations:^{
                //                self.view.transform = CGAffineTransformMakeTranslation(0, -diff);
                self.view.frame = CGRectMake(0, -diff, KSCreenW, KSCreenH - 64);
            }];
        }
    }else if([_distributePerson isFirstResponder]){
        CGRect rect = [_distributePerson convertRect:_distributePerson.frame toView:self.view ];
        
        diff = fabs( keyRect.origin.y - CGRectGetMaxY(rect)) + [UIView getHeight:20];
        
        if (keyRect.origin.y < CGRectGetMaxY(rect)) {
            [UIView animateWithDuration:showtime animations:^{
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
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    
// NSLog(@"发部人群");
//    if (![_distributePerson isExclusiveTouch] || ![_noticeName isExclusiveTouch] || ![_noticeConten isExclusiveTouch]) {
//        [_distributePerson resignFirstResponder];
//        [_noticeConten resignFirstResponder];
//        [_noticeName resignFirstResponder];
//    }
//}
//- (void)takePicture:(UIButton *)sender
//{
//    if (sender.tag == 130) {//内容图片
//        
//    }else if (sender.tag ==131){//封面图片
//        
//    }
//}

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
            [self takePictureInPhoneWithTag:sender.tag];
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"手机相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self takePictureWithCameraWithTag:sender.tag];
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
- (void)takePictureInPhoneWithTag:(NSInteger)tag
{
    if (tag == 131) {
        isCoverImage = YES;
    }else if(tag == 130){
        isCoverImage = NO;
    }
    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    imagePick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePick.delegate = self;//遵循两个代理方法
    imagePick.allowsEditing = YES;
    [self presentViewController:imagePick animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSString * docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSFileManager * fielManege = [NSFileManager defaultManager];
    [fielManege createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * contentPicPath = [NSString stringWithFormat:@"%@%@",docPath,@"/ContentImage.png"];//内容图片的存放路径
    NSString * coverPicPath = [NSString stringWithFormat:@"%@%@",docPath,@"/CoverImage.png"];//封面图片的存放路径
    
//    [fielManege createFileAtPath:[NSString stringWithFormat:@"%@%@",docPath,@"/image.png"] contents:data attributes:nil];
//    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择类型是图片的时候
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;//将图片转成data类型
        data = UIImageJPEGRepresentation(image, 1.0);//后参数压缩系数
        if(isCoverImage){
            [fielManege createFileAtPath:coverPicPath contents:data attributes:nil];
            _showCoverImage.image = image;
        }else{
            [fielManege createFileAtPath:contentPicPath contents:data attributes:nil];
            _showPicImage.image = image;
        }
        [fielManege createFileAtPath:[NSString stringWithFormat:@"%@%@",docPath,@"/image.png"] contents:data attributes:nil];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 相机
- (void)takePictureWithCameraWithTag:(NSInteger)tag
{
    if (tag == 131) {
          isCoverImage = YES;
    }else if(tag == 130){
          isCoverImage = NO;
    }
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
        [self takePictureInPhoneWithTag:130];
    }else if (buttonIndex == 1){
        [self takePictureWithCameraWithTag:131];
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    [actionSheet dismissWithClickedButtonIndex:2 animated:YES];
}

- (void)handleTap
{
    if (![_distributePerson isExclusiveTouch] || ![_noticeName isExclusiveTouch] || ![_noticeConten isExclusiveTouch]) {
        [_distributePerson resignFirstResponder];
        [_noticeConten resignFirstResponder];
        [_noticeName resignFirstResponder];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
- (void)distributeNotice
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
