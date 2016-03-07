//
//  StaffManagerViewController.m
//  Marketing
//
//  Created by wmm on 16/3/4.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "StaffManagerViewController.h"

#define STARTX [UIView getWidth:20]

@interface StaffManagerViewController (){
    NSArray     *_departNameArray;
    NSArray     *_departNumArray;
}

@property (strong, nonatomic) UITableView *departmentTableView;


@end

@implementation StaffManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"人员管理";
    self.navigationItem.leftBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithAction:@selector(popViewController)];
    self.navigationItem.rightBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithString:@"新建" WithAction:@selector(clickToNewDepartment)];
    [self initData];
//        _titleArray = @[@"按拜访时间排序",@"按创建时间排序",@"按名称排序",@"按级别排序"];

    

    // Uncomment the following line to preserve selection between presentations.

    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
//    _departmentTableView.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

- (void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initData{
    _departNameArray = @[@"行政部",@"人事部",@"销售部",@"运营部",@"客户服务部",@"投资发展部部"];
    _departNumArray = @[@"21",@"2",@"3",@"4",@"5",@"16"];
    [self initTableView];
}

- (void)initTableView{
    _departmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH-64)];
//    _departmentTableView.backgroundColor = [UIColor redColor];
    _departmentTableView.dataSource = self;
    _departmentTableView.delegate = self;
    [self.view addSubview:_departmentTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickToNewDepartment{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _departNameArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, 30)];
    view.backgroundColor = graySectionColor;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(STARTX, [UIView getHeight:5], 20, [UIView getHeight:20])];
    [view addSubview:imageView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(STARTX + 30, [UIView getHeight:5], 100, 20)];
    lab.text = @"组织架构";
    lab.textColor = cyanFontColor;
    [view addSubview:lab];
    
    UIView *lineView = [ViewTool getLineViewWith:CGRectMake(STARTX, 30-1, KSCreenW - 2*STARTX, 1) withBackgroudColor:grayLineColor];
    [view addSubview:lineView];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        NSLog(@"mmmmm");
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIView getHeight:60]-1, KSCreenW, 1)];
        lineView.backgroundColor = grayLineColor;
        [cell.contentView addSubview:lineView];
    }
    cell.textLabel.text = _departNameArray[indexPath.row];

    cell.detailTextLabel.textColor = blueFontColor;
    cell.detailTextLabel.text = _departNumArray[indexPath.row];
    return cell;

}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
