//
//  MineViewController.m
//  移动营销
//
//  Created by Hanen 3G 01 on 16/2/23.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "BusinessAdressBookVC.h"
#import "InviteViewController.h"
#import "SettingViewController.h"
#import "InformationViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray     *_imageArray;

}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self createUI];
    //[self initData];
}

- (void)createUI{
    
    _imageArray = [[NSArray alloc]initWithObjects:@"企业通讯录",@"邀请",@"设置", nil];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled =NO;
    
    _tableView.rowHeight = [UIView getHeight:50.0f];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    CGFloat bgImageH     = [UIView getHeight:260];//背景图片的高度
    CGFloat headerImageW  = [UIView getWidth:100];//头像尺寸
    CGFloat qrSpace      = 15;
    CGFloat qrW          = [UIView getWidth:40];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, bgImageH)];
    headerView.backgroundColor = [UIColor grayColor];
    
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, bgImageH)];
    bgImage.image = [UIImage imageNamed:@""];
    [headerView addSubview:bgImage];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIView getHeight:30], KSCreenW, [UIView getHeight:40])];
    _nameLabel.text = @"小花花";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_nameLabel];
    
    _headerBtn = [[UIButton alloc]initWithFrame:CGRectMake((KSCreenW-headerImageW)/2, _nameLabel.maxY + 10, headerImageW, [UIView getHeight:100])];
    _headerBtn.backgroundColor = [UIColor cyanColor];
    _headerBtn.layer.cornerRadius = headerImageW/2;
    _headerBtn.layer.masksToBounds = YES;
    //[_headerBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_headerBtn addTarget:self action:@selector(clickToMyInformation:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_headerBtn];
    
    UIImageView *photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_headerBtn.maxX - [UIView getWidth:20], _headerBtn.maxY -[UIView getHeight:20] , [UIView getWidth:20], [UIView getHeight:20])];
    photoImageView.image =[UIImage imageNamed:@"相机"];
    [headerView addSubview:photoImageView];
    
    
    _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _headerBtn.maxY + 10, KSCreenW, [UIView getHeight:40])];
    _phoneLabel.text = @"手机号：13911119999";
    _phoneLabel.textColor=[UIColor whiteColor];
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:_phoneLabel];
    
    _qrBtn = [[UIButton alloc]initWithFrame:CGRectMake(KSCreenW - qrW - qrSpace, qrSpace, qrW, qrW)];
    [_qrBtn setImage:[UIImage imageNamed:@"二维码"] forState:UIControlStateNormal];
    [_qrBtn addTarget:self action:@selector(getQRcode:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_qrBtn];
    
    _tableView.tableHeaderView = headerView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
//二维码扫描
- (void)getQRcode:(UIButton *)btn{
    
}
//进入我的资料
- (void)clickToMyInformation:(UIButton *)btn{
    InformationViewController *vc = [[InformationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark
#pragma mark---------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell=[[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.headerImage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.titleLabel.text = _imageArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {BusinessAdressBookVC *vc = [[BusinessAdressBookVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];}
            break;
        case 1:
        { InviteViewController *vc = [[InviteViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];}
            break;
        case 2:
        {SettingViewController *vc = [[SettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];}
            break;
        default:
            break;
    }
}
- (void)initData{
    
    NSDictionary * dic =@{@"token":TOKEN,@"uid":@(UID)};
    [DataTool sendGetWithUrl:MY_HOMEPAGE_URL parameters:dic success:^(id data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@+++++--wodezhuye",jsonDic);
        
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
