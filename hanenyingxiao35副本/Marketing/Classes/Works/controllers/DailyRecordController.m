//
//  DailyRecordController.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/2/29.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//工作日志

#import "DailyRecordController.h"
#import "DailRecordCell.h"
#import "NewRecordController.h"
#import "RecordModel.h"

@interface DailyRecordController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView  *_tableView;
    NSMutableArray  *_dataArray;
    
    int   pageCount;
    
}
@end

@implementation DailyRecordController


- (void)viewDidLoad
{
    [super viewDidLoad];
    pageCount = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"工作日志";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(recordWork)];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 20, 20, 20)];
//    [btn setTitle:@"统计" forState:UIControlStateNormal];
//    [btn setTitleColor:darkOrangeColor forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIView getFontWithSize:12.0f];
    [btn setImage:[UIImage imageNamed:@"新建"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(creatRecord) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self addTableView];
    [self initData];
}


- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KSCreenW, KSCreenH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

//初始化数据
- (void)initData
{
    int userID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] intValue];
    NSDictionary *dict = @{@"token" : TOKEN,@"uid": @(userID),@"page":@(pageCount)};
//    NSLog(@"....%d..%@, %d",userID,TOKEN,UID);
    [DataTool sendGetWithUrl:COMMEN_USER_RECORD_URL parameters:dict success:^(id data) {
        id backData = CRMJsonParserWithData(data);
        NSLog(@"data :%@",backData);
        NSArray *listArr = backData[@"list"];
        for (int i = 0; i < listArr.count; i++) {
            RecordModel *model = [[RecordModel alloc] init];
            [model setValuesForKeysWithDictionary:listArr[i]];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        
    } fail:^(NSError *error) {
        NSLog(@"error :%@",error.localizedDescription);
    }];
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



- (void)creatRecord
{
    NSLog(@"新建日志");
    NewRecordController * newRecord = [[NewRecordController alloc] init];
    [self.navigationController pushViewController:newRecord animated:YES];
    
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
- (void)recordWork
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
