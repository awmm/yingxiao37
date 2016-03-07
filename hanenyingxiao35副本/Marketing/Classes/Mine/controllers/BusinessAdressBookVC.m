//
//  BusinessAdressBookVC.m
//  Marketing
//
//  Created by HanenDev on 16/2/25.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "BusinessAdressBookVC.h"
#import "ChineseString.h"
#import "AddressBookCell.h"
#import "StuffDetailViewController.h"

#define STARTX [UIView getWidth:20]

@interface BusinessAdressBookVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray    *_nameArray;
}
@property(nonatomic,strong)NSMutableArray   *indexArray;
@property(nonatomic,strong)NSMutableArray   *resultArray;

@end

@implementation BusinessAdressBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"企业通讯录";
    
    [self createUI];
    //[self initData];
    
}
- (void)createUI{
    
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    
    self.navigationItem.rightBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithString:@"新建" WithAction:@selector(addNewPeople)];
    
//    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, KSCreenW, [UIView getHeight:40])];
//    searchBar.placeholder = @"搜索";
//    [self.view addSubview:searchBar];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KSCreenW, [UIView getHeight:40])];
    view.backgroundColor = graySectionColor;
    [self.view addSubview:view];
    
    UITextField *searchTF = [[UITextField alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:8], KSCreenW -2*STARTX , [UIView getHeight:40]-2*[UIView getHeight:8])];
    searchTF.backgroundColor = [UIColor whiteColor];
    searchTF.placeholder =@"搜索";
    searchTF.textAlignment = NSTextAlignmentCenter;
    searchTF.delegate = self;
    [view addSubview:searchTF];
    
    _nameArray = @[@"张三",@"张三1",@"小王",@"李四",@"王二",@"蛮子",@"瞎子",@"刘流",@"提莫",@"光辉",@"烬",@"金克斯",@"贾克斯",@"流浪",@"劫",@"男刀",@"李四1",@"德玛",@"希维尔",@"蒙多",@"潘森",@"波比",@"瑞文",@"EZ",@"索拉卡",@"娑娜",@"鳄鱼",@"酒桶",@"厄运小姐",@"薇恩",@"老牛",@"大嘴",@"飞机"];
    
    self.indexArray = [ChineseString IndexArray:_nameArray];
    self.resultArray = [ChineseString LetterSortArray:_nameArray];
    
    [self initTableView];
    
    
}
- (void)initTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+40, KSCreenW, KSCreenH - 64 -40)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

#pragma mark
#pragma mark ------tableView的协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _indexArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.resultArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[AddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.headerImage.backgroundColor = cyanFontColor;
    cell.nameLabel.text = [[self.resultArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [cell.phoneBtn addTarget:self action:@selector(clickToDirectCall:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, 30)];
    view.backgroundColor = graySectionColor;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(STARTX + 10, 5, 100, 20)];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = cyanFontColor;
    [view addSubview:lab];
    
    UIView *lineView = [ViewTool getLineViewWith:CGRectMake(STARTX, 30-1, KSCreenW - 2*STARTX, 1) withBackgroudColor:grayLineColor];
    [view addSubview:lineView];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StuffDetailViewController *vc = [[StuffDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addNewPeople{
    
}
//拨打电话
- (void)clickToDirectCall:(UIButton *)btn{
    NSLog(@"1111111111");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
    [DataTool sendGetWithUrl:BUSINESS_ADDRESS_BOOK_URL parameters:dic success:^(id data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@+++++--qiyetongxunlu",jsonDic);
        
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
