//
//  NoticeDetailController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/2/26.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//公告详情


#import "NoticeDetailController.h"

@interface NoticeDetailController ()
{
    CGFloat  TopSpace;
    
    UILabel      *_MainTitle;
    UILabel      *_groupLabel;
    UILabel      *_timeLabel;
    
    UIImageView  *_imageView;
    UILabel      *_detailNoticeLabel;
    
    
    

    
}
@end

@implementation NoticeDetailController
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IPhone4S) {
        TopSpace = 5.0f;
    }else{
        TopSpace =  [UIView getWidth:10.0f];
    }
    self.view.backgroundColor = [UIColor whiteColor];
     self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(popLastView)];
    self.navigationItem.title = @"CRM客户营销团队";
    
    [self initData];
    [self drawView];
    
}
//请求数据
- (void)initData
{
    NSDictionary * dict = @{@"token": TOKEN,@"uid" : @(UID), @"id": self.noticeID};
    [DataTool sendGetWithUrl:NOTICE_DETAIL_URL parameters:dict success:^(id data) {
        //jsdfhjdhfjd
    } fail:^(NSError *error) {
        
    }];
}

- (void)drawView
{
    
    _MainTitle = [ViewTool getLabelWith:CGRectMake(2 * TopSpace, 64 + 2 * TopSpace, KSCreenW - 4 * TopSpace, 20) WithTitle:@"运营商你在做什么" WithFontSize:15.0f WithTitleColor:[UIColor colorWithWhite:0.4 alpha:1] WithTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_MainTitle];
    
    _groupLabel = [ViewTool getLabelWith:CGRectMake(_MainTitle.x, _MainTitle.maxY + TopSpace, [UIView getWidth:200], 15) WithTitle:@"无敌的营销客户的牛B不行的团队" WithFontSize:13.0 WithTitleColor:[UIColor colorWithWhite:0.6 alpha:1] WithTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_groupLabel];
    
    _timeLabel = [ViewTool getLabelWith:CGRectMake(_groupLabel.maxX + TopSpace, _groupLabel.y, [UIView getWidth:100], 15) WithTitle:@"1026-23-23" WithFontSize:13.0 WithTitleColor:[UIColor colorWithWhite:0.6 alpha:1]  WithTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_timeLabel];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_MainTitle.x, _groupLabel.maxY + TopSpace, KSCreenW - 4 * TopSpace, [UIView getWidth:180])];
    _imageView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_imageView];
    
    
    //计算文字的高度 再去填写
    _detailNoticeLabel = [ViewTool getLabelWith:CGRectMake(_MainTitle.x, _imageView.maxY + 2 * TopSpace, _imageView.width, 100) WithTitle:@"_imageView = [[UIImageView alloc] initWithFrame:CGRectMake_imageView = [[UIImageView alloc] initWithFrame:CGRectMake_imageView = [[UIImageView alloc] initWithFrame:CGRectMake_imageView = [[UIImageView alloc] initWithFrame:CGRectMake_imageView = [[UIImageView alloc] initWithFrame:CGRectMake" WithFontSize:13.0 WithTitleColor:[UIColor colorWithWhite:0.4 alpha:1] WithTextAlignment:NSTextAlignmentLeft];
    _detailNoticeLabel.numberOfLines = 0;
    [self.view addSubview:_detailNoticeLabel];
    
    
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end
