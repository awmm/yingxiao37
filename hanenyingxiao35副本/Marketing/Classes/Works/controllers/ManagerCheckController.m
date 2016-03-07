//
//  ManagerCheckController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/3/2.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//管理员日志查看

#import "ManagerCheckController.h"
#import "DailRecordCell.h"

@interface ManagerCheckController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView  *_tableView;
    NSMutableArray  *_dataArray;
    
    int   pageCount;
}
@end


@implementation ManagerCheckController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(popViewController)];
    self.navigationItem.rightBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithString:@"筛选" WithAction:@selector(choosePerson)];
    self.navigationItem.title = @"日志查看";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addTableView];
    
}
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KSCreenW, KSCreenH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DailRecordCell * cell = [DailRecordCell cellWithTableView:tableView];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //dfdf234324
    return  [UIView getWidth:70];
}

//点击右上角的筛选
- (void)choosePerson
{
    
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
