//
//  ApprovalDetailController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/3/3.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//审批详情

#import "ApprovalDetailController.h"
#import "ApproSubVIew.h"
#import "myButton.h"
@interface ApprovalDetailController ()
{
    UIScrollView    *_scrollView;
    
    CGFloat     topSpace;
    UIView    *_leavingView;//请假视图
    UIImageView     *_personLogo;
    UIImageView     *_waiteLoga;
    UILabel         *_nameLabel;
    UILabel         *_waiteLabel;
    UILabel         *_dateLabel;
    UILabel         *_timeLabel;
    
    UIView          *_btnView;
    UIButton        *_agreeBtn;
    UIButton        *_rejectBtn;
    
}
@end

@implementation ApprovalDetailController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = lightGrayBackColor;
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(popViewControll)];
    [self initScrollView];
    [self addLeavingView];
    [self addBtn];
    
}

- (void)initScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KSCreenH, KSCreenH - TabbarH - 64)];
    _scrollView.backgroundColor = lightGrayBackColor;
    [self.view addSubview:_scrollView];
    
}
- (void)addLeavingView
{
    
    if (IPhone4SInCell) {
        topSpace = 6.0f;
    }else{
        topSpace = [UIView getWidth:8.0f];
    }
    _leavingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCreenW, [UIView getWidth:300])];
    _leavingView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_leavingView];
    
    
    CGFloat logoW = [UIView getWidth:50];
    _personLogo = [[UIImageView alloc] initWithFrame:CGRectMake(2 * topSpace, topSpace, logoW, logoW)];
    _personLogo.backgroundColor = cyanFontColor;
    _personLogo.layer.cornerRadius = logoW / 2.0f;
    _personLogo.layer.masksToBounds = YES;
    [_leavingView addSubview:_personLogo];
    
    CGFloat waiteLogoW = [UIView getWidth:13.0f];
    _waiteLoga = [[UIImageView alloc] initWithFrame:CGRectMake(logoW , _personLogo.maxY - waiteLogoW, waiteLogoW , waiteLogoW)];
    //    _waiteLoga.backgroundColor = [UIColor redColor];
    _waiteLoga.image = [UIImage imageNamed:@"等待"];
   [ _leavingView addSubview:_waiteLoga];
    
    _nameLabel = [ViewTool getLabelWith:CGRectMake(_personLogo.maxX + 2 * topSpace, _personLogo.y, KSCreenW - _personLogo.maxX - 4 * topSpace, [UIView getHeight:20]) WithTitle:@"小花花的请假" WithFontSize:13.0f WithTitleColor:blackFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_leavingView addSubview:_nameLabel];
    
    _waiteLabel = [ViewTool getLabelWith:CGRectMake(_nameLabel.x, _nameLabel.maxY + 1.5 * topSpace , [UIView getWidth:100], [UIView getHeight:15]) WithTitle:@"等待我的审批" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [_leavingView addSubview:_waiteLabel];
    
    CGFloat dateW = [UIView getWidth:80];
    CGFloat dateX = KSCreenW - 2 * topSpace - dateW;
    _dateLabel = [ViewTool getLabelWith:CGRectMake(dateX , _nameLabel.maxY, dateW, [UIView getHeight:15]) WithTitle:@"2016:10:12" WithFontSize:11.0f WithTitleColor:cyanFontColor WithTextAlignment:NSTextAlignmentRight];
    //    _dateLabel.backgroundColor = [UIColor orangeColor];
    [_leavingView addSubview:_dateLabel];
    
    CGFloat timeW = [UIView getWidth:60];
    CGFloat timeX = KSCreenW - 2 * topSpace - timeW;
    _timeLabel = [ViewTool getLabelWith:CGRectMake(timeX, _waiteLabel.y,timeW, [UIView getHeight:15]) WithTitle:@"24:24" WithFontSize:11.0f WithTitleColor:cyanFontColor WithTextAlignment:NSTextAlignmentRight];
    [_leavingView addSubview:_timeLabel];
    
    UIView *line = [ViewTool getLineViewWith:CGRectMake(2 * topSpace, _personLogo.maxY + topSpace , KSCreenW - 4 * topSpace, 1) withBackgroudColor:grayLineColor];
    [_leavingView addSubview:line];
    
    NSArray * titleArray = @[@"审批编号",@"所在部门",@"请假类型",@"开始时间",@"结束时间",@"请假天数",@"请假事由"];
     NSArray * titleArray2 = @[@"7823478-1-3249",@"所在部门",@"请假类型",@"开始时间",@"结束时间",@"请假天数",@"请假事由"];
    for (int i = 0; i < titleArray.count ; i ++) {
        CGFloat labelW = [UIView getWidth:60];
        CGFloat labelH = [UIView getWidth:20.0];
        CGFloat contentLabelH = [UIView getWidth:20.0f];
        UILabel *label = [ViewTool getLabelWith:CGRectMake(line.x, line.maxY + topSpace + i * (labelH +  topSpace), labelW, labelH) WithTitle:titleArray[i] WithFontSize:11.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
        [_leavingView addSubview:label];
        
        UILabel *contentLabel = [ViewTool getLabelWith:CGRectMake(label.maxX , label.y, KSCreenW - label.maxX - 2 * topSpace, contentLabelH) WithTitle:titleArray2[i] WithFontSize:13.0f WithTitleColor:blackFontColor WithTextAlignment:NSTextAlignmentLeft];
//        contentLabel.backgroundColor = cyanFontColor;
        [_leavingView addSubview:contentLabel];
        //最后一个请假事由可以根据字数来设定label的高度
        if (i == titleArray.count -1) {
            contentLabel.numberOfLines = 0;
#warning 获得请假事由计算高度
//            CGFloat h = [contentLabel.text boundingRectWithSize:CGSizeMake(contentLabel.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f], NSForegroundColorAttributeName : grayFontColor} context:nil].size.height;
//            contentLabel.frame = CGRectMake(label.maxX + topSpace, topSpace + i * (labelH + 0.5 * topSpace), KSCreenW - label.maxX - 2 * topSpace, h);
            _leavingView.frame = CGRectMake(0, 0, KSCreenW, contentLabel.maxY + topSpace);
        }
    }
//    _leavingView.backgroundColor = [UIColor redColor];
    UIView *line1 = [ViewTool getLineViewWith:CGRectMake(0, _leavingView.maxY - 1, KSCreenW , 1) withBackgroudColor:lightGrayBackColor];
    [_leavingView addSubview:line1];
    
    
   
    
    ApproSubVIew * approView1 = [[ApproSubVIew alloc] initWithFrame:CGRectMake(3 * topSpace,_leavingView.maxY + 2 * topSpace, KSCreenW - 6 * topSpace, [UIView getWidth:60])];
    approView1.isHadApproval = NO;
    approView1.apptype = 0;
    approView1.nameString = @"小花花";
    
    ApproSubVIew * approView2 = [[ApproSubVIew alloc] initWithFrame:CGRectMake(3 * topSpace, approView1.maxY + 2 * topSpace, KSCreenW - 6 * topSpace, [UIView getWidth:60])];
    approView2.isHadApproval = NO;
    approView2.apptype = 1;
    approView2.nameString = @"我";
    
    UIView *linV = [ViewTool getLineViewWith:CGRectMake(approView2.x + approView1.approvalStateImage.width / 2.0f, _leavingView.maxY, 0.5, approView2.y - _leavingView.maxY) withBackgroudColor:grayLineColor];
    [_scrollView addSubview:linV];
    
    [_scrollView addSubview:approView1];
    [_scrollView addSubview:approView2];
    
    
   
    
    if (approView2.maxY + 64 > KSCreenH - TabbarH) {
        _scrollView.contentSize = CGSizeMake(0, approView2.maxY + TabbarH);
    }else{
        _scrollView.contentSize = CGSizeMake(0, 0);
    }
    
}

- (void)addBtn
{
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCreenH - TabbarH, KSCreenW, TabbarH)];
    _btnView.backgroundColor = TabbarColor;
    [self.view addSubview:_btnView];
    
    UIView *linelineline = [ViewTool getLineViewWith:CGRectMake(0, 0, KSCreenW, 1) withBackgroudColor:grayLineColor];
    [_btnView addSubview:linelineline];
    
    
    _agreeBtn = [[myButton alloc] initWithFrame:CGRectMake(0, 0, KSCreenW / 2.0f, TabbarH)];
    [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    [_agreeBtn setTitleColor:darkOrangeColor forState:UIControlStateNormal];
    [_agreeBtn addTarget:self action:@selector(handleLeaving:) forControlEvents:UIControlEventTouchUpInside];
    [_agreeBtn setImage:[UIImage imageNamed:@"同意"] forState:UIControlStateNormal];
    
    _rejectBtn = [[myButton alloc] initWithFrame:CGRectMake(KSCreenW / 2.0f, 0, KSCreenW / 2.0f, TabbarH)];
    [_rejectBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    [_rejectBtn setTitleColor:darkOrangeColor forState:UIControlStateNormal];
    [_rejectBtn addTarget:self action:@selector(handleLeaving:) forControlEvents:UIControlEventTouchUpInside];
    [_rejectBtn setImage:[UIImage imageNamed:@"拒绝"] forState:UIControlStateNormal];
    
    UIView *midLine = [ViewTool getLineViewWith:CGRectMake(_agreeBtn.width , TabbarH / 4.0, 1, TabbarH / 2.0) withBackgroudColor:grayLineColor];
    [_btnView addSubview:midLine];
    
    [_btnView addSubview:_agreeBtn];
    [_btnView addSubview:_rejectBtn];
    
}

- (void)handleLeaving:(UIButton *)btn
{
    if ([btn.currentTitle isEqualToString:@"同意"]) {
        
    }else{
        
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

- (void)popViewControll
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
