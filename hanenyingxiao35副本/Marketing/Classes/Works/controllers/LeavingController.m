//
//  LeavingController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/3/3.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "LeavingController.h"
#import "ApprovalCell.h"
#import "CreatLeavingController.h"
#import "LeavingDetailController.h"

@interface LeavingController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat  space;
    UITableView  *_tableView;
    
}
@end


@implementation LeavingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IPhone4S) {
        space = 5.0f;
    }else{
        space = [UIView getWidth:10.0f];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"请假";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(popViewController)];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 20, 20, 20)];
    //    [btn setTitle:@"统计" forState:UIControlStateNormal];
    //    [btn setTitleColor:darkOrangeColor forState:UIControlStateNormal];
    //    btn.titleLabel.font = [UIView getFontWithSize:12.0f];
    [btn setImage:[UIImage imageNamed:@"新建"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(creatLeaving) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self drawtableView];
}


- (void)drawtableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KSCreenW, KSCreenH - TabbarH) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}


#pragma mark --tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApprovalCell * cell = [ApprovalCell cellWithTableView:tableView];
    cell.isWaitingApproval = NO;//看数据 中的已审批和待审批的设定 这个boo值
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LeavingDetailController * lwaving = [[LeavingDetailController alloc] init];
    [self.navigationController pushViewController:lwaving animated:YES];
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ApprovalCell cellHeight];
}


- (void)creatLeaving
{
    CreatLeavingController * creatVC = [[CreatLeavingController alloc] init];
    [self.navigationController pushViewController:creatVC animated:YES];
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
