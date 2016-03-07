//
//  InformationViewController.m
//  Marketing
//
//  Created by HanenDev on 16/2/25.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationCell.h"

#define ROWH [UIView getHeight:60.0f]

@interface InformationViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_titleArray;
    NSArray *_dataArray;
}
@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的资料";
    
    _titleArray = @[@"头像",@"姓名",@"电话",@"二维码名片",@"所属部门",@"职位"];
    
    [self createUI];
    //[self initData];
    
}

- (void)createUI{
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.rowHeight = ROWH;
    [self.view addSubview:tableView];
    
}
#pragma mark
#pragma mark ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell=[[InformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = _titleArray[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.subLabel.text = nil;
        cell.qrImage.image =[UIImage imageNamed:@"二维码名片"];
    }else if (indexPath.row == 1) {
        cell.subLabel.text = @"张三小";
    }else if (indexPath.row == 2) {
        cell.subLabel.text = @"13322223333";
    }else if (indexPath.row == 3) {
        cell.subLabel.text = nil;
        cell.qrImage.image =[UIImage imageNamed:@"二维码名片"];
    }else if (indexPath.row == 4) {
        cell.subLabel.text = @"移动设计院";
    }else if (indexPath.row == 5) {
        cell.subLabel.text = @"项目经理";
    }
    
    return cell;
}

- (void)goToBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}

- (void)initData{
    
    NSDictionary * dic =@{@"token":TOKEN,@"uid":@(UID)};
    [DataTool sendGetWithUrl:MY_HOMEPAGE_URL parameters:dic success:^(id data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@+++++--wodexiangqing",jsonDic);
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
