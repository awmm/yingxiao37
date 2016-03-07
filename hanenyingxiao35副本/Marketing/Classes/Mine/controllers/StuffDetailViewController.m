//
//  StuffDetailViewController.m
//  Marketing
//
//  Created by HanenDev on 16/2/26.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "StuffDetailViewController.h"
#import "InformationCell.h"

@interface StuffDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray      *_titleArray;
    UITableView  *_tableView;
}
@end

@implementation StuffDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    self.title = @"员工详情";
    _titleArray = @[@"所属部门",@"职位"];
    
    [self createUI];
}
- (void)createUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.rowHeight = [UIView getHeight:60.0f];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
    CGFloat bgImageH     = [UIView getHeight:260.0f];//背景图片的高度
    CGFloat headerImageW  = [UIView getWidth:100];//头像尺寸
    CGFloat qrSpace      = 15;
    CGFloat qrW          = [UIView getWidth:40];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, bgImageH)];
    headerView.backgroundColor = [UIColor grayColor];
    
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, bgImageH)];
    bgImage.image = [UIImage imageNamed:@""];
    [headerView addSubview:bgImage];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, KSCreenW, [UIView getHeight:40])];
    _nameLabel.text = @"小花花";
    _nameLabel.font = [UIView getFontWithSize:16.0f];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_nameLabel];
    
    _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake((KSCreenW-headerImageW)/2, _nameLabel.maxY + 10, headerImageW, headerImageW)];
    _headerImageView.backgroundColor = [UIColor cyanColor];
    _headerImageView.layer.cornerRadius = headerImageW/2;
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.image = [UIImage imageNamed:@""];
    [headerView addSubview:_headerImageView];
    
    UIImageView *photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_headerImageView.maxX - [UIView getWidth:20], _headerImageView.maxY -[UIView getHeight:20] , [UIView getWidth:20], [UIView getHeight:20])];
    photoImageView.image =[UIImage imageNamed:@"相机"];
    [headerView addSubview:photoImageView];
    
    //拨打电话按钮
    UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(_headerImageView.x - [UIView getWidth:25], _headerImageView.maxY + [UIView getHeight:20], [UIView getWidth:18], [UIView getHeight:18])];
    [phoneBtn setImage:[UIImage imageNamed:@"电话2"] forState:UIControlStateNormal];
    [phoneBtn addTarget:self action:@selector(directCall:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:phoneBtn];
    
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneBtn.maxX + [UIView getWidth:10], phoneBtn.y - [UIView getHeight:10], KSCreenW, [UIView getHeight:40])];
    _phoneLabel.text = @"13911119999";
    _phoneLabel.font = [UIView getFontWithSize:16.0f];
    _phoneLabel.textColor=[UIColor whiteColor];
    //_phoneLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_phoneLabel];
    
    _qrBtn = [[UIButton alloc]initWithFrame:CGRectMake(KSCreenW - qrW - qrSpace, qrSpace, qrW, qrW)];
    [_qrBtn setImage:[UIImage imageNamed:@"二维码"] forState:UIControlStateNormal];
    [_qrBtn addTarget:self action:@selector(getQRcode:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_qrBtn];
    
    _tableView.tableHeaderView = headerView;
}
//二维码扫描
- (void)getQRcode:(UIButton *)btn{
    NSLog(@"");
}
- (void)directCall:(UIButton *)sender{
    
    UIWebView *webview = [[UIWebView alloc] init];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_phoneLabel.text]]]];
    [self.view addSubview:webview];
}
#pragma mark
#pragma mark---------
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
         cell.subLabel.text =@"移动设计院";
    }else if (indexPath.row == 1){
        cell.subLabel.text =@"项目经理";
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
