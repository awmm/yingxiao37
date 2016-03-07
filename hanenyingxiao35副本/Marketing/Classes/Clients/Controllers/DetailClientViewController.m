//
//  DetailClientViewController.m
//  Marketing
//
//  Created by HanenDev on 16/3/1.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "DetailClientViewController.h"
#import "DetailClientView.h"
#import "MyClientCell.h"
#import "DetailClientCell.h"
#import "NewClientViewController.h"

#define STARTX [UIView getWidth:20]
#define MYCELLHEIGHT [UIView getHeight:60.0f]
#define OTHERCELLHEIGHT [UIView getHeight:80.0f]

@interface DetailClientViewController ()<DetailClientViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray    *_detailArray;
}
@property(nonatomic,strong)DetailClientView  *bottomView;

@property(nonatomic,strong)UIView            *detailView;
@property(nonatomic,strong)UITableView       *detailTableView;

@property(nonatomic,strong)UIView            *visitView;
@property(nonatomic,strong)UITableView       *visitTableView;

@property(nonatomic,strong)UILabel           *levelLabel;

@end

@implementation DetailClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    
    self.title = @"客户详情";
    _bottomView = [[DetailClientView alloc]initWithFrame:CGRectMake(0, KSCreenH - [UIView getHeight:50], KSCreenW, [UIView getHeight:50])];
    _bottomView.delegate = self;
    [self.view addSubview:_bottomView];
    
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    [self getRightNavigationBar];
    
    [self createDetailView];
    [self createVisitView];
    //[self initData];
}
- (void)createDetailView{
    _detailArray = @[@"姓名",@"公司名称",@"编号",@"级别",@"公司部门",@"职位",@"来源",@"状态"];
    _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KSCreenW, KSCreenH - 64 - [UIView getHeight:50])];
    _detailView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_detailView];
    
    _detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH - 64 - [UIView getHeight:50]) style:UITableViewStylePlain];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_detailView addSubview:_detailTableView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW - 2*STARTX, [UIView getHeight:30])];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:5], 20, [UIView getHeight:20])];
    imageView.image = [UIImage imageNamed:@""];
    [headerView addSubview:imageView];
    
    UILabel *basicLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.maxX + 5, [UIView getHeight:5], 200, [UIView getHeight:20])];
    basicLabel.text = @"基本信息";
    basicLabel.textColor = [UIColor cyanColor];
    [headerView addSubview:basicLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:30] - 1, KSCreenW - 2*STARTX, 1)];
    lineView.backgroundColor = grayLineColor;
    [headerView addSubview:lineView];
    
    _detailTableView.tableHeaderView = headerView;
    
}
- (void)createVisitView{
    _visitView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KSCreenW, KSCreenH - 64 - [UIView getHeight:50])];
    _visitView.hidden = YES;
    _visitView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_visitView];
    
    _visitTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH - 64 - [UIView getHeight:50]) style:UITableViewStylePlain];
    _visitTableView.delegate = self;
    _visitTableView.dataSource = self;
    _visitTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_visitView addSubview:_visitTableView];
    
}
- (void)changeDetailClientView:(NSInteger)tag{
    if (tag == 1111) {//客户详情
        
        self.title = @"客户详情";
        [_bottomView.detailBtn setImage:[UIImage imageNamed:@"客户详情 enter"] forState:UIControlStateNormal];
        [_bottomView.detailBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
        
        [_bottomView.visitBtn setImage:[UIImage imageNamed:@"拜访历史"] forState:UIControlStateNormal];
        [_bottomView.visitBtn setTitleColor:lightGrayFontColor forState:UIControlStateNormal];
        
        self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
        [self getRightNavigationBar];
        
        _detailView.hidden = NO;
        _visitView.hidden = YES;
        
    }else if (tag == 2222){//拜访历史
        
        self.title = @"拜访历史";
        [_bottomView.detailBtn setImage:[UIImage imageNamed:@"客户详情"] forState:UIControlStateNormal];
        [_bottomView.detailBtn setTitleColor:lightGrayFontColor forState:UIControlStateNormal];
        
        [_bottomView.visitBtn setImage:[UIImage imageNamed:@"拜访历史 enter"] forState:UIControlStateNormal];
        [_bottomView.visitBtn setTitleColor:blackFontColor forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithString:@"新建" WithAction:@selector(clickToNewClient:)];
        
        _detailView.hidden = YES;
        _visitView.hidden = NO;
    }
}

#pragma mark
#pragma mark-----tableView的协议方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_detailTableView) {
        
        return [UIView getHeight:60];
    }else if (tableView == _visitTableView){
        return [UIView getHeight:80];
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _detailTableView) {
        return _detailArray.count;
    }else if (tableView == _visitTableView){
        return 10;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     if (tableView == _detailTableView){
        
        static NSString *identifier =@"cell";
        DetailClientCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell1 == nil) {
            cell1 = [[DetailClientCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(STARTX, MYCELLHEIGHT - 1, KSCreenW -2*STARTX, 1)];
            lineView.backgroundColor = grayLineColor;
            [cell1.contentView addSubview:lineView];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.nameLabel.text = _detailArray[indexPath.row];
         cell1.nameTF.delegate = self;
         
         if (indexPath.row == 0) {
             cell1.nameTF.text  = @"11111";
             cell1.nameTF.enabled = NO;
         }else if (indexPath.row == 1){
             cell1.nameTF.text  = @"22222";
             cell1.nameTF.enabled = NO;
         }else if (indexPath.row == 2){
             cell1.nameTF.text  = @"33333";
             cell1.nameTF.enabled = NO;
         }else if (indexPath.row == 3){
             cell1.nameTF.text  = @"44444";
             cell1.nameTF.enabled = YES;
             _levelLabel.text = cell1.nameTF.text;
         }else if (indexPath.row == 4){
             cell1.nameTF.text  = @"55555";
             cell1.nameTF.enabled = YES;
         }else if (indexPath.row == 5){
             cell1.nameTF.text  = @"66666";
             cell1.nameTF.enabled = YES;
         }else if (indexPath.row == 6){
             cell1.nameTF.text  = @"7777";
             cell1.nameTF.enabled = YES;
         }else if (indexPath.row == 7){
             cell1.nameTF.text  = @"88888";
             cell1.nameTF.enabled = YES;
         }
        return cell1;
    }else if (tableView == _visitTableView){
        static NSString *identifier =@"cell";
        MyClientCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[MyClientCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(STARTX, OTHERCELLHEIGHT - 1, KSCreenW -2*STARTX, 1)];
            lineView.backgroundColor = grayLineColor;
            [cell.contentView addSubview:lineView];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.companyLabel.text = @"南京汉恩数字互联文化有限公司";
        cell.statusLabel.text  = @"2016年3月2号";
        cell.addressLabel.text = @"高新技术开发区流芳路8号通驰产业园";
        cell.principalLabel.text = @"负责人>某某某";
        cell.timeLabel.text = @"已拜访";
        return cell;
    }
    return nil;

}

/**
 *  保存按钮
 *
 *  @param btn 修改客户详情
 */
- (void)saveClick:(UIButton *)btn{
    
}
//新建客户
- (void)clickToNewClient:(UIButton *)btn{
    NewClientViewController *vc = [[NewClientViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)goToBack{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}

- (void)getRightNavigationBar{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIView getWidth:40], [UIView getWidth:20])];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIView getFontWithSize:15.0f];
    [btn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)initData{
    NSNumber *cidNum =[NSNumber numberWithInt:1];
    NSDictionary * dic =@{@"token":TOKEN,@"uid":@(UID),@"cid":cidNum };
    [DataTool sendGetWithUrl:DETAIL_CLIENT_URL parameters:dic success:^(id data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@++++++",jsonDic);
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
@end
