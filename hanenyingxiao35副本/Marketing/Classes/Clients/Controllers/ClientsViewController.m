//
//  ClientsViewController.m
//  移动营销
//
//  Created by Hanen 3G 01 on 16/2/23.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "ClientsViewController.h"
#import "MyClientButton.h"
#import "MyClientView.h"
#import "MyClientCell.h"
#import "DetailClientViewController.h"

#define STARTX [UIView getWidth:20]
#define MYCELLHEIGHT [UIView getHeight:60.0f]
#define OTHERCELLHEIGHT [UIView getHeight:80.0f]

@interface ClientsViewController ()<MyClientViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UIView      *view;
    BOOL        isMyClient;
    NSArray     *_titleArray;
    UITextField *searchTF;
}
@property(nonatomic,strong)MyClientView    *topBtnView;
@property(nonatomic,strong)MyClientButton  *taxisBtn;
/**
 *  排序界面
 */
@property(nonatomic,strong)UITableView     *taxisTableView;
@property(nonatomic,strong)UIView          *taxisView;

/**
 *  我的客户
 */
@property(nonatomic,strong)UITableView     *myClientTableView;
@property(nonatomic,strong)UIView          *myClientView;

/**
 *  下属客户
 */
@property(nonatomic,strong)UITableView     *otherClientTableView;
@property(nonatomic,strong)UIView          *otherClientView;

@end

@implementation ClientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton =YES;
    isMyClient =YES;
    
    [self getTestData:1];
    
    _titleArray = @[@"按拜访时间排序",@"按创建时间排序",@"按名称排序",@"按级别排序"];
    self.navigationItem.rightBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithString:@"新建" WithAction:@selector(clickToNewClient:)];
    
    _topBtnView = [[MyClientView alloc] initWithFrame:CGRectMake(0, 0, [UIView getWidth:200], 44) withLeftTitle:nil andRightTitle:nil];
    _topBtnView.delegate = self;
    self.navigationItem.titleView = _topBtnView;
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, KSCreenW, 0.5)];
    lineLabel.backgroundColor = grayLineColor;
    [_topBtnView addSubview:lineLabel];
    
    [self initViews];
}
- (void)initViews{
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KSCreenW, [UIView getHeight:40])];
    view.backgroundColor  = graySectionColor;
    [self.view addSubview:view];
    //排序旋钮
    _taxisBtn = [[MyClientButton alloc]initWithFrame:CGRectMake([UIView getWidth:10], [UIView getHeight:0], KSCreenW*0.4 - [UIView getWidth:10], [UIView getHeight:40])];
    [_taxisBtn setTitle:@"按拜访时间排序" forState:UIControlStateNormal];
    _taxisBtn.titleLabel.font = [UIView getFontWithSize:14.0f];
    [_taxisBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    [_taxisBtn setTitleColor:grayFontColor forState:UIControlStateNormal];
    [_taxisBtn addTarget:self action:@selector(btnClickToGetTaxisList:) forControlEvents:UIControlEventTouchUpInside];
    _taxisBtn.isSelected = NO;
    [view addSubview:_taxisBtn];
    
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(_taxisBtn.maxX + [UIView getWidth:10], [UIView getHeight:8], 1, [UIView getHeight:40] - 2*[UIView getHeight:8])];
    lineView1.backgroundColor = grayLineColor;
    [view addSubview:lineView1];
    
//    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(lineView1.maxX + [UIView getWidth:5], 0, KSCreenW -lineView1.maxX - [UIView getWidth:5] , [UIView getHeight:40])];
//    searchBar.placeholder =@"搜索";
//    [view addSubview:searchBar];
    
    searchTF = [[UITextField alloc]initWithFrame:CGRectMake(lineView1.maxX + [UIView getWidth:10], lineView1.y, KSCreenW -lineView1.maxX - [UIView getWidth:10]*2, [UIView getHeight:40]-lineView1.y*2)];
    searchTF.backgroundColor = [UIColor whiteColor];
    searchTF.placeholder =@"搜索";
    searchTF.textAlignment = NSTextAlignmentCenter;
//    //搜索图标
//    UIImageView *vie = [[UIImageView alloc] init];
//    vie.image = [UIImage imageNamed:@"搜索"];
//    vie.frame = CGRectMake(0, 0, 35, 35);
//    //左边搜索图标的模式
//    vie.contentMode = UIViewContentModeCenter;
//    searchTF.leftView = vie;
//    searchTF.leftViewMode = UITextFieldViewModeAlways;
    searchTF.delegate = self;
    [view addSubview:searchTF];
    
    
    [self initMyClientView];
    [self initOtherClientView];
    
    [self createTaxisView];
}
/**
 *  创建排序界面
 */
- (void)createTaxisView{
    
    _taxisTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, view.maxY, KSCreenW, _titleArray.count*[UIView getHeight:40]) style:UITableViewStylePlain];
    _taxisTableView.alpha = 0;
    _taxisTableView.delegate = self;
    _taxisTableView.dataSource = self;
    _taxisTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_taxisTableView];
    
    _taxisView = [[UIView alloc]initWithFrame:CGRectMake(0, _taxisTableView.maxY, KSCreenW, KSCreenH)];
    _taxisView.backgroundColor = [UIColor orangeColor];
    _taxisView.alpha = 0;
    [self.view addSubview:_taxisView];
    //加个手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToHideTaxisView:)];
    [_taxisView addGestureRecognizer:tapGesture];
}
- (void)tapToHideTaxisView:(UITapGestureRecognizer *)tapGesture{
    [UIView animateWithDuration:0.25 animations:^{
        _taxisTableView.alpha = 0;
        _taxisView.alpha      = 0;
        [_taxisBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    }];
}
- (void)btnClickToGetTaxisList:(MyClientButton *)btn{
    
    if (btn.isSelected == NO) {
         [UIView animateWithDuration:0.25 animations:^{
             _taxisTableView.alpha = 1;
             _taxisView.alpha      = 0.7;
             [btn setImage:[UIImage imageNamed:@"下拉收回"] forState:UIControlStateNormal];
         }];
        btn.isSelected = YES;
        
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            _taxisTableView.alpha = 0;
            _taxisView.alpha      = 0;
            [btn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        }];
        btn.isSelected = NO;
    }
}
/**
 *  我的客户
 */
- (void)initMyClientView{
    _myClientView = [[UIView alloc]initWithFrame:CGRectMake(0, view.maxY, KSCreenW, KSCreenH-view.maxY )];
    //_myClientView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_myClientView];
    
    _myClientTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH - view.maxY -49) style:UITableViewStylePlain];
    _myClientTableView.delegate   = self;
    _myClientTableView.dataSource =self;
    _myClientTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_myClientView addSubview:_myClientTableView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW - 2*STARTX, [UIView getHeight:30])];
    
    UILabel *basicLabel = [[UILabel alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:5], 200, [UIView getHeight:20])];
    basicLabel.text = @"共有222位客户";
    basicLabel.textColor = grayFontColor;
    [headerView addSubview:basicLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:30] - 1, KSCreenW - 2*STARTX, 1)];
    lineView.backgroundColor = grayLineColor;
    [headerView addSubview:lineView];
    
    _myClientTableView.tableHeaderView = headerView;
}
/**
 *  下属客户
 */
- (void)initOtherClientView{
    _otherClientView = [[UIView alloc]initWithFrame:CGRectMake(0, view.maxY, KSCreenW, KSCreenH-view.maxY)];
    _otherClientView.hidden = YES;
    //_otherClientView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_otherClientView];
    
    _otherClientTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH - view.maxY -49) style:UITableViewStylePlain];
    _otherClientTableView.delegate   = self;
    _otherClientTableView.dataSource =self;
    _otherClientTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_otherClientView addSubview:_otherClientTableView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW - 2*STARTX, [UIView getHeight:30])];
    
    UILabel *basicLabel = [[UILabel alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:5], 200, [UIView getHeight:20])];
    basicLabel.text = @"共有111位客户";
    basicLabel.textColor = grayFontColor;
    [headerView addSubview:basicLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:30] - 1, KSCreenW - 2*STARTX, 1)];
    lineView.backgroundColor = grayLineColor;
    [headerView addSubview:lineView];
    
    _otherClientTableView.tableHeaderView = headerView;
}
#pragma mark --MyClientView delagte

- (void)changeNoticeView:(NSInteger)tag
{
    if (tag == 1111) {//下属客户
        //[self initOtherData:1];
        
        isMyClient = NO;
        _myClientView.hidden = YES;
        _otherClientView.hidden = NO;
        
        [_topBtnView.otherClient setTitleColor:darkOrangeColor forState:UIControlStateNormal];
        [_topBtnView.myClient setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        _topBtnView.redLine1.backgroundColor = darkOrangeColor;
        _topBtnView.redLine2.backgroundColor = grayLineColor;
        
        self.navigationItem.leftBarButtonItem  = [ViewTool getBarButtonItemWithTarget:self WithString:@"筛选" WithAction:@selector(clickToselectClient:)];
        
    }else if (tag == 2222){//我的客户
        isMyClient =YES;
        _myClientView.hidden = NO;
        _otherClientView.hidden = YES;
        
        [_topBtnView.otherClient setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        [_topBtnView.myClient setTitleColor:darkOrangeColor forState:UIControlStateNormal];
        _topBtnView.redLine1.backgroundColor = grayLineColor;
        _topBtnView.redLine2.backgroundColor = darkOrangeColor;
        
        self.navigationItem.leftBarButtonItem  = nil;
        //测试
        //[self getTestData:1];
    }
}
//新建客户
- (void)clickToNewClient:(UIButton *)sender{
    
}
//选择下属客户
- (void)clickToselectClient:(UIButton *)sender{
    
}

#pragma mark
#pragma mark ------tableView的协议方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_taxisTableView) {
        
        return [UIView getHeight:40];
    }else if (tableView == _myClientTableView){
        return [UIView getHeight:60];
    }else if (tableView == _otherClientTableView){
        return [UIView getHeight:80];
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_taxisTableView) {
        
        return _titleArray.count;
    }else if (tableView == _myClientTableView){
        return 10;
    }else if (tableView == _otherClientTableView){
        return 10;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _taxisTableView) {
         static NSString *identifier =@"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIView getHeight:40]-1, KSCreenW, 1)];
            lineView.backgroundColor = grayLineColor;
            [cell.contentView addSubview:lineView];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _titleArray[indexPath.row];
        return cell;
    }else if (tableView == _myClientTableView){
        
        static NSString *identifier =@"cell";
        MyClientCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell1 == nil) {
            cell1 = [[MyClientCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(STARTX, MYCELLHEIGHT - 1, KSCreenW -2*STARTX, 1)];
            lineView.backgroundColor = grayLineColor;
            [cell1.contentView addSubview:lineView];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.companyLabel.text = @"南京汉恩数字互联文化有限公司";
        cell1.statusLabel.text  = @"昨日已拜访";
        cell1.addressLabel.text = @"高新技术开发区流芳路8号通驰产业园";
        return cell1;
    }else if (tableView == _otherClientTableView){
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
        cell.statusLabel.text  = @"昨日已拜访";
        cell.addressLabel.text = @"高新技术开发区流芳路8号通驰产业园";
        cell.principalLabel.text = @"负责人:某某某";
        return cell;
    }
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _taxisTableView) {
        [_taxisBtn setTitle:_titleArray[indexPath.row] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.25 animations:^{
            _taxisTableView.alpha = 0;
            _taxisView.alpha      = 0;
        }];
        _taxisBtn.isSelected = NO;
        [_taxisBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        if (isMyClient ==YES ) {
            //测试数据
            //[self getTestData:indexPath.row];
        }else{
            //[self initOtherData:indexPath.row];
        }
        
        
    }else if (tableView == _myClientTableView){
        DetailClientViewController *vc = [[DetailClientViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [searchTF resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(![searchTF isExclusiveTouch]){
        [searchTF resignFirstResponder];
    }
    
}

- (void)getTestData:(int)count {
    
    NSNumber *sortNum = [NSNumber numberWithInt:count];
    NSNumber *sortwayNum = [NSNumber numberWithInt:2];
    NSNumber *pagesNum = [NSNumber numberWithInt:1];
    NSNumber *rowsNum = [NSNumber numberWithInt:20];
    NSDictionary * dic =@{@"token":TOKEN,@"uid":@(UID),@"sort":sortNum,@"sortWay":sortwayNum,@"pages":pagesNum,@"rows":rowsNum,};
    [DataTool sendGetWithUrl:MY_CLIENT_URL parameters:dic success:^(id data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@-----",jsonDic);
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)initOtherData:(int)count{
    
    NSNumber *sortNum = [NSNumber numberWithInt:count];
    NSNumber *sortwayNum = [NSNumber numberWithInt:2];
    NSNumber *pagesNum = [NSNumber numberWithInt:1];
    NSNumber *rowsNum = [NSNumber numberWithInt:20];
    NSDictionary * dic =@{@"token":TOKEN,@"uid":@(UID),@"sort":sortNum,@"sortWay":sortwayNum,@"pages":pagesNum,@"rows":rowsNum,};
    [DataTool sendGetWithUrl:OTHER_CLIENT_URL parameters:dic success:^(id data) {
//        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@-----",jsonDic);
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
