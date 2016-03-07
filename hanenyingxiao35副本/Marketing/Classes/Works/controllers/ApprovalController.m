//
//  ApprovalController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/3/2.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//审批

#import "ApprovalController.h"
#import "ManagerNoticeBtnView.h"
#import "ApprovalCell.h"
#import "ApprovalDetailController.h"

@interface ApprovalController ()<ManagerNoticeBtnViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView        *_topView;
    UITextField   *_searchfield;
    
    UITableView   *_tableView;
    NSMutableArray *_dataArray;
    
    UITableView   *_tableView2;
    
    
    CGFloat   space;
}

@end

@implementation ApprovalController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IPhone4S) {
        space = 5.0f;
    }else{
        space = [UIView getWidth:10.0f];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.title = @"审批";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(popViewController)];
    self.approvleBtnView = [[ManagerNoticeBtnView alloc] initWithFrame:CGRectMake(0, 0, [UIView getWidth:200], 44)];

    self.navigationItem.titleView = self.approvleBtnView;
    self.approvleBtnView.rightTitle = @"已审批";
    
    
    //获取待审批的 数字
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"待审批(%d)",2]];
    [attributeStr setAttributes:@{NSForegroundColorAttributeName : darkOrangeColor,NSFontAttributeName : [UIView getFontWithSize:11.0f]} range:NSMakeRange(0, attributeStr.length)];
    [attributeStr setAttributes:@{NSForegroundColorAttributeName : darkOrangeColor,NSFontAttributeName : [UIView getFontWithSize:13.0f]} range:NSMakeRange(0, 3)];
    self.approvleBtnView.leftAttributeStr = attributeStr;
    [self setTopBtnAttributeStrWithClick:YES];
    
//    self.approvleBtnView.leftTitle = @"待审批";
    self.approvleBtnView.delegate = self;
    
    [self drawSearchField];
    [self drawtableView];
    
}
- (void)setTopBtnAttributeStrWithClick:(BOOL)isClick//是否被点击
{
    //获取待审批的 数字
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"待审批(%d)",2]];
    [attributeStr setAttributes:@{NSForegroundColorAttributeName : darkOrangeColor,NSFontAttributeName : [UIView getFontWithSize:11.0f]} range:NSMakeRange(0, attributeStr.length)];
    [attributeStr setAttributes:@{NSForegroundColorAttributeName : darkOrangeColor,NSFontAttributeName : [UIView getFontWithSize:13.0f]} range:NSMakeRange(0, 3)];
    if(!isClick){
        [attributeStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:1]} range:NSMakeRange(0, attributeStr.length)];
    }
    self.approvleBtnView.leftAttributeStr = attributeStr;
}
- (void)drawSearchField
{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KSCreenW, [UIView getWidth:40])];
    _topView.backgroundColor = graySectionColor;
    [self.view addSubview:_topView];
    
    
    _searchfield = [[UITextField alloc] initWithFrame:CGRectMake( 2 * space,  space , _topView.width - 4 * space , _topView.height - 2 * space)];
    _searchfield.delegate = self;
    _searchfield.backgroundColor = [UIColor whiteColor];
    [_topView addSubview:_searchfield];
    
    CGFloat btnW = [UIView getWidth:15];
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_searchfield.width / 2.0 - btnW/2.0, 5, btnW, _searchfield.height - 10)];
////    btn.backgroundColor = [UIColor redColor];
//    [btn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
//    btn.imageView.frame = CGRectMake(0, 0, btn.width * 0.5, btn.width);
//    [btn setTitle:@"搜索" forState:UIControlStateNormal];
//    [btn setTitleColor:blackFontColor forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIView getFontWithSize:12.0f];
//    [_searchfield addSubview:btn];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(_searchfield.width / 2.0 - btnW, 5, btnW, _searchfield.height - 10)];
    imageV.image= [UIImage imageNamed:@"搜索"];
    UILabel *la = [ViewTool getLabelWith:CGRectMake(_searchfield.width / 2.0f, 5, 30, _searchfield.height - 10) WithTitle:@"搜索" WithFontSize:11.0 WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentRight];
    [_searchfield addSubview:la];
    [_searchfield addSubview:imageV];
    
    
}

- (void)drawtableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _topView.maxY, KSCreenW, KSCreenH - _topView.maxY) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, _topView.maxY, KSCreenW, KSCreenH - _topView.maxY) style:UITableViewStylePlain];
    [self.view addSubview:_tableView2];
    _tableView2.backgroundColor = cyanFontColor;
    _tableView2.hidden = YES;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    
}
#pragma mark --tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        ApprovalCell * cell = [ApprovalCell cellWithTableView:tableView];
        cell.isWaitingApproval = YES;
        return cell;
    }else if(tableView == _tableView2){
        ApprovalCell * cell = [ApprovalCell cellWithTableView:tableView];
        cell.isWaitingApproval = NO;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ApprovalDetailController * approvaVC = [[ApprovalDetailController alloc] init];
    [self.navigationController pushViewController:approvaVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ApprovalCell cellHeight];
}
#pragma mark --textfiled 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
#pragma mark --顶上按钮点击切换
- (void)changeNoticeView:(NSInteger)tag
{
    
    if (tag == 122) {//左边按钮
        [self setTopBtnAttributeStrWithClick:YES];
        [self.approvleBtnView.myNotice setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        self.approvleBtnView.redLine1.backgroundColor = darkOrangeColor;
        self.approvleBtnView.redLine2.backgroundColor = graySectionColor;
        _tableView.hidden = NO;
        _tableView2.hidden = YES;
        
    }else if (tag == 123){
        [self setTopBtnAttributeStrWithClick:NO];
        [self.approvleBtnView.myNotice setTitleColor:darkOrangeColor forState:UIControlStateNormal];
        self.approvleBtnView.redLine1.backgroundColor = graySectionColor;
        self.approvleBtnView.redLine2.backgroundColor = darkOrangeColor;
        
        _tableView.hidden = YES;
        _tableView2.hidden = NO;
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

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
