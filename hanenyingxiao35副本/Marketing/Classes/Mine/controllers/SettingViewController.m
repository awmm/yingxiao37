//
//  SettingViewController.m
//  Marketing
//
//  Created by HanenDev on 16/2/25.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "SettingViewController.h"
#import "MineCell.h"
#import "FirstViewController.h"

#define STARTX [UIView getWidth:20]
#define LINEW KSCreenW - 2*STARTX
#define ROWH [UIView getHeight:50.0f]

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_titleArray;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"设置";
    
    _titleArray = [NSMutableArray arrayWithArray:@[@[@"账号与安全"],@[@"版本更新",@"意见反馈",@"关于我们"]]];
    
    [self createUI];
}
- (void)createUI{
    
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.rowHeight = ROWH;
    [self.view addSubview:tableView];
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, [UIView getHeight:50])];
    UIButton *outLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(STARTX, 10, KSCreenW - 2*STARTX, [UIView getHeight:40])];
    [outLoginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [outLoginBtn setBackgroundColor:[UIColor redColor]];
    [outLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [outLoginBtn addTarget:self action:@selector(clickToOutLogin:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:outLoginBtn];
    
    tableView.tableFooterView = footerView;
}

#pragma mark ---- tableview的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_titleArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell=[[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.headerImage.image = [UIImage imageNamed:_titleArray[indexPath.section][indexPath.row]];
        cell.titleLabel.text = _titleArray[indexPath.section][indexPath.row];
        [cell.lineView removeFromSuperview];
    }else if (indexPath.section == 1){
        cell.headerImage.image = [UIImage imageNamed:_titleArray[indexPath.section][indexPath.row]];
        cell.titleLabel.text = _titleArray[indexPath.section][indexPath.row];
        if (indexPath.row ==2) {
            [cell.lineView removeFromSuperview];
        }
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
         //账号与安全
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            //版本更新
        }else if (indexPath.row == 1){
            //意见反馈
        }else if (indexPath.row == 2){
            //关于我们
        }
    }
    
}
- (void)goToBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//退出登录
- (void)clickToOutLogin:(UIButton *)btn{
//    [self.navigationController pushViewController:[FirstViewController alloc] init] animated:YES completion:nil];

    [self.navigationController pushViewController:[[FirstViewController alloc] init] animated:YES];
//    [self dismissViewControllerAnimated:self completion:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
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
