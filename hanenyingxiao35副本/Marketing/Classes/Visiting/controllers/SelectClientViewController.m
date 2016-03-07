//
//  SelectClientViewController.m
//  Marketing
//
//  Created by wmm on 16/3/6.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "SelectClientViewController.h"
#import "Toast+UIView.h"

@interface SelectClientViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)       int customerCount;
@property(nonatomic,strong)NSMutableArray   *customerList;

@property(nonatomic,strong)NSMutableArray *companyList;
@property(nonatomic,strong)NSMutableArray *idList;
@property(nonatomic,strong)NSMutableArray *cnameList;

@property(nonatomic,strong)UITableView         *clientTableView;

@end

@implementation SelectClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"公司名称";
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    [self reloadData];


}

- (void)viewWillAppear:(BOOL)animated
{
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

- (void)reloadData{
    
//    self.delegate = self.navigationController;
    NSNumber *sortNum = [NSNumber numberWithInt:3];
    NSNumber *sortwayNum = [NSNumber numberWithInt:2];
    NSNumber *pagesNum = [NSNumber numberWithInt:1];
    NSNumber *rowsNum = [NSNumber numberWithInt:20];
    NSDictionary * dic =@{@"token":TOKEN,@"uid":@(UID),@"sort":sortNum,@"sortWay":sortwayNum,@"pages":pagesNum,@"rows":rowsNum,};
    [DataTool sendGetWithUrl:MY_CLIENT_URL parameters:dic success:^(id data) {
        
//        int code = [[(NSDictionary *)data objectForKey:@"code"] intValue];
//        if(code != 100)//连接500和501
//        {
//            NSString * message = [(NSDictionary *)data objectForKey:@"message"];
//            [self.view makeToast:message];
//        }else{
//
//        }
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _customerCount = [[(NSDictionary *)jsonDic objectForKey:@"customerCount"] intValue];
        _customerList = [(NSDictionary *)jsonDic objectForKey:@"customerList"];
        NSLog(@"%@-----",jsonDic);
        [self setCompanyName];
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setCompanyName{
//    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionaryWithCapacity:_customerCount];
    for (NSMutableDictionary *client in _customerList) {
        NSLog(@"client:%@",client);
        NSLog(@"%@",[client objectForKey:@"id"]);
        [_idList addObject:[client objectForKey:@"id"]];
        [_companyList addObject:[client objectForKey:@"company"]];
        [_cnameList addObject:[client objectForKey:@"cname"] ];
    }
            NSLog(@"%@",_idList);
        [self addClientTable];
}

- (void)addClientTable{
    NSLog(@"%f-----%f",self.view.width,self.view.height);
    _clientTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)];
    _clientTableView.delegate = self;
    _clientTableView.dataSource = self;
    [self.view addSubview:_clientTableView];
}

- (void)goToBack{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _customerCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_customerList[indexPath.row] objectForKey:@"company"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(selectClient:)]) {
//        
//
//    }
    [self.delegate selectClient:[[_customerList[indexPath.row] objectForKey:@"id"] intValue] withName:[_customerList[indexPath.row] objectForKey:@"company"] withCname:[_customerList[indexPath.row] objectForKey:@"cname"]];
    [self goToBack];
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
