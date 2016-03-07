//
//  CreatLeavingController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/3/3.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "CreatLeavingController.h"

@interface CreatLeavingController ()<UITextFieldDelegate,UITextViewDelegate>
{
    UIScrollView      *_scrollView;
    CGFloat             topSpace;
    CGFloat         btnW;
    
    //类型
    UIView        *_typeView;
    UILabel       *_typeLable;
    UILabel       *_chooseTypeLabel;
    UIButton      *_chooseBtn;
    
    //选择时间
    UIView        *_timeView;
    UILabel       *_startTime;
    UILabel       *_startTimeContent;
    UILabel       *_endTime;
    UILabel       *_endTimeContent;
    UIButton      *_chooseStartTime;
    UIButton      *_chooseEndTime;
    
    //请假天数
    UIView        *_dayCount;
    UILabel       *_titlabel;
    UITextField   *_dayCountField;
    
    //请假事由
    UIView        *_reasonLeavingView;
    UILabel       *_leavingLabel;
    UITextView    *_textView;
    UILabel       *_placeHolder;
    
    //图片
    UIView        *_picView;
    UILabel       *_picTitle;
    UIImageView   *_showPicImage1;
    UIImageView   *_showPicImage2;
    UIButton      *_takePicBtn;
    
    //
    UIView      *_bottomView;
    UILabel     *_titleLabel;
    UIButton    *_addPersonsBtn;
    
    //
    UIButton    *_postBtn;
    
    CGFloat diff;
    
}
@end

@implementation CreatLeavingController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新建请假";
    if (IPhone4S) {
        topSpace = 5.0f;
    }else{
        topSpace = [UIView getWidth:10.0f];
    }
    btnW = [UIView getWidth:15.0f];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self creatScrollView];
    [self creatTypeView];
    [self creatTimeView];
    [self creatDayView];
    [self creatReaonView];
    [self creatPicView];
    [self drawBottomView];
    [self addBtn];
    [self creatDatePick];
    
}
- (void)creatScrollView
{
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KSCreenW, KSCreenH - TabbarH -64)];
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
    
    _typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCreenW, [UIView getWidth:70])];
    NSLog(@"%@",NSStringFromCGRect(_typeView.frame));
//        _typeView.backgroundColor = [UIColor cyanColor];
    [_scrollView addSubview:_typeView];
    
    
    _typeLable = [ViewTool getLabelWith:CGRectMake(2 * topSpace, topSpace, 100, 15) WithTitle:@"请假类型" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_typeView addSubview:_typeLable];
    
    _chooseTypeLabel = [ViewTool getLabelWith:CGRectMake(_typeLable.x, _typeLable.maxY + topSpace, 100, 15) WithTitle:@"请选择(必填)" WithFontSize:13.0f WithTitleColor:blackFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_typeView addSubview:_chooseTypeLabel];
    
    
    _chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCreenW - 2 * topSpace - btnW, _chooseTypeLabel.y, btnW, btnW)];
    [_chooseBtn setBackgroundImage:[UIImage imageNamed:@"类型"] forState:UIControlStateNormal];
//    _chooseBtn.backgroundColor = cyanFontColor;
    [_typeView addSubview:_chooseBtn];
    
  
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, _chooseTypeLabel.maxY + topSpace, KSCreenW, [UIView getWidth:15.0f])];
    grayView.backgroundColor = graySectionColor;
    [_typeView addSubview:grayView];
    
    _typeView.frame = CGRectMake(0, 0,KSCreenW, grayView.maxY);
    
}

- (void)creatTimeView
{
    NSLog(@"hfghfghfg%f",_typeView.maxY);
    _timeView = [[UIView alloc] initWithFrame:CGRectMake(0, _typeView.maxY, KSCreenW, 100)];
//    _timeView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_timeView];
    
    _startTime = [ViewTool getLabelWith:CGRectMake(2 * topSpace, topSpace, 100, 15) WithTitle:@"开始时间" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_timeView addSubview:_startTime];
    
    _startTimeContent = [ViewTool getLabelWith:CGRectMake(_startTime.x, _startTime.maxY+ topSpace, 150, 15) WithTitle:@"请选择(必填)" WithFontSize:13.0f WithTitleColor:blackFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_timeView addSubview:_startTimeContent];
    _chooseStartTime = [[UIButton alloc] initWithFrame:CGRectMake(KSCreenW - 2 * topSpace - btnW, _startTimeContent.y, btnW, btnW)];
    [_chooseStartTime setBackgroundImage:[UIImage imageNamed:@"时间"] forState:UIControlStateNormal];
//    _chooseStartTime.backgroundColor = cyanFontColor;
    [_timeView addSubview:_chooseStartTime];
    
    UIView *line1 = [ViewTool getLineViewWith:CGRectMake(_startTime.x, _startTimeContent.maxY + topSpace, KSCreenW - 4 * topSpace, 1) withBackgroudColor:grayLineColor];
    [_timeView addSubview:line1];
    
    
    _endTime = [ViewTool getLabelWith:CGRectMake(2 * topSpace, line1.maxY + topSpace, 100, 15) WithTitle:@"结束时间" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_timeView addSubview:_endTime];
    
    _endTimeContent = [ViewTool getLabelWith:CGRectMake(2 * topSpace, _endTime.maxY + topSpace, 150, 15) WithTitle:@"请选择(必填)" WithFontSize:13.0f WithTitleColor:blackFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_timeView addSubview:_endTimeContent];
    
    _chooseEndTime = [[UIButton alloc] initWithFrame:CGRectMake(KSCreenW - 2 * topSpace - btnW, _endTimeContent.y, btnW, btnW)];
//    _chooseEndTime.backgroundColor = cyanFontColor;
      [_chooseEndTime setBackgroundImage:[UIImage imageNamed:@"时间"] forState:UIControlStateNormal];
    [_timeView addSubview:_chooseEndTime];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, _endTimeContent.maxY + topSpace, KSCreenW, [UIView getWidth:15.0f])];
    grayView.backgroundColor = graySectionColor;
    [_timeView addSubview:grayView];
    _timeView.frame = CGRectMake(0, _typeView.maxY,KSCreenW, grayView.maxY);
    
}

- (void)creatDayView
{
    _dayCount = [[UIView alloc] initWithFrame:CGRectMake(0, _timeView.maxY, KSCreenW, [UIView getWidth:100])];
//    _dayCount.backgroundColor = [UIColor cyanColor];
    [_scrollView addSubview:_dayCount];
    
    
    _titlabel = [ViewTool getLabelWith:CGRectMake(_endTimeContent.x, topSpace, 100, 15) WithTitle:@"请假天数" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_dayCount addSubview:_titlabel];
    
    _dayCountField = [[UITextField alloc] initWithFrame:CGRectMake(_titlabel.x, _titlabel.maxY + topSpace, 200, 15)];
    _dayCountField.delegate = self;
    _dayCountField.placeholder = @"请输入请假天数(必填)";
    [_dayCountField setValue:blackFontColor forKeyPath:@"_placeholderLabel.textColor"];
//    [_dayCountField setValue:[UIFont systemFontOfSize:13.0f] forKeyPath:@"_placeholderLabel.font"];
    
//    [ViewTool getLabelWith:CGRectMake(_titlabel.x, _titlabel.maxY + topSpace, 150, 15) WithTitle:@"请输入请假天数(必填)" WithFontSize:13.0f WithTitleColor:blackFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_dayCount addSubview:_dayCountField];

    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, _dayCountField.maxY + topSpace, KSCreenW, [UIView getWidth:15.0f])];
    grayView.backgroundColor = graySectionColor;
    [_dayCount addSubview:grayView];
    
    _dayCount.frame = CGRectMake(0, _timeView.maxY,KSCreenW, grayView.maxY);
}

- (void)creatReaonView
{
    _reasonLeavingView = [[UIView alloc] initWithFrame:CGRectMake(0, _dayCount.maxY, KSCreenW, 100)];
    _reasonLeavingView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_reasonLeavingView];
    
    _leavingLabel = [ViewTool getLabelWith:CGRectMake(2 * topSpace, topSpace, 100, 15.0f) WithTitle:@"请假事由" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_reasonLeavingView addSubview:_leavingLabel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(_leavingLabel.x, _leavingLabel.maxY + topSpace, KSCreenW - 4 * topSpace, [UIView getWidth:70])];
//    _textView.backgroundColor = cyanFontColor;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.autoresizingMask =  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _placeHolder = [ViewTool getLabelWith:CGRectMake(0, 0, _textView.width, [UIView getWidth:15.0f]) WithTitle:@"请填写请假事由(必填)" WithFontSize:13.0f WithTitleColor:[UIColor blackColor] WithTextAlignment:NSTextAlignmentLeft];
    _placeHolder.enabled = NO;
    _placeHolder.backgroundColor = [UIColor whiteColor];
    [_textView addSubview:_placeHolder];
    _textView.hidden = NO;
    _textView.delegate = self;
    [_reasonLeavingView addSubview:_textView];
    
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, _textView.maxY + topSpace, KSCreenW, [UIView getWidth:15.0f])];
    grayView.backgroundColor = graySectionColor;
    [_reasonLeavingView addSubview:grayView];
    
    _reasonLeavingView.frame = CGRectMake(0, _dayCount.maxY,KSCreenW, grayView.maxY);

}

- (void)creatPicView
{
    _picView = [[UIView alloc] initWithFrame:CGRectMake(0, _reasonLeavingView.maxY, KSCreenW, 100)];
    _picView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_picView];
    
    _picTitle = [ViewTool getLabelWith:CGRectMake(2 * topSpace, topSpace, 100, [UIView getWidth:15.0f]) WithTitle:@"图片" WithFontSize:11.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_picView addSubview:_picTitle];
    
    CGFloat imagew = [UIView getWidth:40];
    _showPicImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(_picTitle.x, _picTitle.maxY + topSpace, imagew, imagew)];
    _showPicImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(_showPicImage1.maxX + topSpace, _showPicImage1.y, imagew, imagew)];
    _showPicImage1.backgroundColor = cyanFontColor;
    _showPicImage2.backgroundColor = cyanFontColor;
    [_picView addSubview:_showPicImage1];
    [_picView addSubview:_showPicImage2];
    
    _takePicBtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCreenW -2 * topSpace - imagew, _showPicImage1.y, imagew, imagew)];
    [_takePicBtn setImage:[UIImage imageNamed:@"相机star"] forState:UIControlStateNormal];
    [_picView addSubview:_takePicBtn];
    [_takePicBtn addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, _showPicImage1.maxY + topSpace, KSCreenW, [UIView getWidth:15.0f])];
    grayView.backgroundColor = graySectionColor;
    [_picView addSubview:grayView];
    
    _picView.frame = CGRectMake(0, _reasonLeavingView.maxY,KSCreenW, grayView.maxY);
    
}

- (void)drawBottomView
{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _picView.maxY, KSCreenW, [UIView getHeight:50])];
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
    _bottomView.frame = CGRectMake(0, _picView.maxY, KSCreenW, _addPersonsBtn.maxY +  topSpace);
//if 
    if (_bottomView.maxY + 64 > KSCreenH - TabbarH) {
        _scrollView.contentSize = CGSizeMake(0, _bottomView.maxY);
    }else{
        _scrollView.contentSize = CGSizeMake(0, 0);
    }
    
}

- (void)addBtn
{
   
        _postBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCreenH - TabbarH, KSCreenW, TabbarH)];
        [_postBtn addTarget:self action:@selector(postLeaving:) forControlEvents:UIControlEventTouchUpInside];
        [_postBtn setTitle:@"确定提交" forState:UIControlStateNormal];
        [_postBtn setTitleColor:darkOrangeColor forState:UIControlStateNormal];
        [self.view addSubview:_postBtn];
        UIView *line3 = [ViewTool getLineViewWith:CGRectMake(0, 0, KSCreenW, 1) withBackgroudColor:grayLineColor];
        [_postBtn addSubview:line3];
  
}


- (void)creatDatePick
{
//    UIDatePicker * datePicker = [UIDatePicker alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
}
- (void)postLeaving:(UIButton *)btn
{
    
}
//拍照
- (void)takePicture
{
    
}
#warning 根据高度差滚动scrollView
- (void)keyboardWillShow:(NSNotification *)noti
{
    
    NSDictionary *usrInfoDict = noti.userInfo;
    //    NSLog(@"%@",usrInfoDict);
    CGRect keyRect = [usrInfoDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat showtime = [usrInfoDict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if(_textView.isFirstResponder){
        //        NSDictionary *usrInfoDict = noti.userInfo;
        //        NSLog(@"%@",usrInfoDict);
        //        CGRect keyRect = [usrInfoDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //        CGFloat showtime = [usrInfoDict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect rect = [_textView convertRect:_textView.frame toView:self.view ];
        diff = fabs( keyRect.origin.y - CGRectGetMaxY(rect)) + [UIView getHeight:20];
        
        if (keyRect.origin.y < CGRectGetMaxY(rect)) {
            [UIView animateWithDuration:showtime animations:^{
                //                self.view.transform = CGAffineTransformMakeTranslation(0, -diff);
                self.view.frame = CGRectMake(0, -diff, KSCreenW, KSCreenH - 64);
            }];
        }
    }else if(_dayCountField.isFirstResponder){
        //        NSDictionary *usrInfoDict1 = noti.userInfo;
        //
        //        CGRect keyRect1 = [usrInfoDict1[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //        CGFloat showtime1 = [usrInfoDict1[UIKeyboardAnimationDurationUserInfoKey] floatValue];
#warning 这里转换坐标系 怎么会不对呢
        CGRect rect = [_dayCountField convertRect:_dayCountField.frame toView:self.view ];
        //              NSLog(@"%f,%f",keyRect.origin.y, CGRectGetMaxY(rect));
        //        NSLog(@"%f,%f,%f,%f",KSCreenH,KSCreenH - 271, CGRectGetMaxY(rect),CGRectGetMaxY(_noticeConten.frame) + 64);
        diff = fabs( keyRect.origin.y - (_dayCountField.maxY + 64)) + [UIView getHeight:20];
        //        NSLog(@"%f,%f",keyRect1.origin.y, CGRectGetMaxY(rect));
        if (keyRect.origin.y < (_dayCountField.maxY + 64)) {
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

- (void)handleScrolltap:(UITapGestureRecognizer *)tap
{
    if (![_dayCountField isExclusiveTouch] || ![_textView isExclusiveTouch]) {
        [_dayCountField resignFirstResponder];
        [_textView resignFirstResponder];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _textView.hidden = NO;
    _placeHolder.hidden = YES;
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length != 0) {
        _placeHolder.hidden = YES;
    }else{
        _placeHolder.hidden = NO;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placeHolder.hidden = NO;
    }
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
@end
