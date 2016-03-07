//
//  NoticeViewController.m
//  移动营销
//
//  Created by Hanen 3G 01 on 16/2/24.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//公告页

#import "NoticeViewController.h"
#import "NoticeModel.h"
#import "NoticeCell.h"
#import "ManagerNoticeBtnView.h"
#import "NoticeDetailController.h"


@interface NoticeViewController ()<UITableViewDataSource,UITableViewDelegate,ManagerNoticeBtnViewDelegate>
{
    UITableView      * _noticeTableView;
    NSMutableArray   *_dataArray;
    BOOL  isManager;
    BOOL  isOtherNotice;
    int        _pageCount;
}
@property (nonatomic, strong)ManagerNoticeBtnView * topBtnView;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _pageCount = 1;
    isManager = YES;
    isOtherNotice = YES;
  
//    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.topBtnView = [[ManagerNoticeBtnView alloc] initWithFrame:CGRectMake(0, 0, [UIView getWidth:200], 44)];
    self.topBtnView.rightTitle = @"我的公告";
    self.topBtnView.leftTitle = @"其他公告";
    self.topBtnView.delegate = self;
    if (isManager) {
        self.navigationItem.titleView = self.topBtnView;
        
    }else{
          self.navigationItem.title = @"公告";
    }
  
      [self initData];
    [self initTableView];
  
    
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(popLastView)];
}
#pragma mark --获取数据
- (void)initData //普通用户和管理员我的公告列表是 一样的根据uid type 是什么类型
{
    NSDictionary * paramesdictionary = @{@"token": TOKEN,@"uid" : @(UID)};
    NSLog(@"%@,-----%d",TOKEN,UID);
     [DataTool sendGetWithUrl:COMMEN_USER_NOTICE_URL parameters:paramesdictionary success:^(id data) {
             id backData = CRMJsonParserWithData(data);
         NSLog(@"%@",backData);
         NSMutableArray *dataArr = backData[@"list"];
         for (int i = 0; i < dataArr.count; i ++) {
             NoticeModel * model = [[NoticeModel alloc] init];
             [model setValuesForKeysWithDictionary:dataArr[i]];
             [_dataArray addObject:model];
         }
         [_noticeTableView reloadData];
     } fail:^(NSError *error) {
         NSLog(@"%@",error.localizedDescription);
     }];

}

- (void)initTableView
{
    _noticeTableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 64, KSCreenW, KSCreenH - 64) style:UITableViewStylePlain];
    _noticeTableView.delegate = self;
    _noticeTableView.dataSource = self;
    _noticeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _noticeTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_noticeTableView];
//    self.view.selectedBackgroundView = selcectBackView;
//    selcectBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.1];
    
}

#pragma mark --tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _dataArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeCell * cell = [NoticeCell cellWithTableView:tableView];
//    cell.highlighted = YES;红烧豆腐大会上的好好的舒服rggr
//     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NoticeCell cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NoticeDetailController * noticeDetailVC = [[NoticeDetailController alloc] init];
    NoticeModel *model = _dataArray[indexPath.row];
    noticeDetailVC.BigTitle = model.title;
    noticeDetailVC.noticeID = [NSString stringWithFormat:@"%d",model.noticeId];//说是传入id是int类型
    [self.navigationController pushViewController:noticeDetailVC animated:YES];
    
}
#pragma mark --managerBtnchange delagte
- (void)changeNoticeView:(NSInteger)tag
{
    
    if (tag == 122) {
        isOtherNotice = YES;
        [self.topBtnView.otherNotice setTitleColor:darkOrangeColor forState:UIControlStateNormal];
        [self.topBtnView.myNotice setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        self.topBtnView.redLine1.backgroundColor = darkOrangeColor;
        self.topBtnView.redLine2.backgroundColor = [UIColor whiteColor];
        
     
        
    }else if (tag == 123){
        isOtherNotice = NO;
        [self.topBtnView.otherNotice setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        [self.topBtnView.myNotice setTitleColor:darkOrangeColor forState:UIControlStateNormal];
        self.topBtnView.redLine1.backgroundColor = [UIColor whiteColor];
        self.topBtnView.redLine2.backgroundColor = darkOrangeColor;
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)popLastView
{
    [self.navigationController popViewControllerAnimated:YES];
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
