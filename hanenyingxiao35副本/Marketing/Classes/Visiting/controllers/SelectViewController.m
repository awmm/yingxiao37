//
//  SelectViewController.m
//  Marketing
//
//  Created by wmm on 16/3/2.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "SelectViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.hidesBackButton = NO;
    self.navigationItem.title = @"人员";
    self.view.frame = CGRectMake(50, 0, KSCreenW-50, KSCreenH);
    
    self.navigationItem.leftBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithAction:@selector(goToBack)];
    
    self.navigationItem.rightBarButtonItem=[ViewTool getBarButtonItemWithTarget:self WithString:@"新建" WithAction:@selector(refresh)];
    
    //    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, KSCreenW, [UIView getHeight:40])];
    //    searchBar.placeholder = @"搜索";
    //    [self.view addSubview:searchBar];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KSCreenW, [UIView getHeight:40])];
    view.backgroundColor = graySectionColor;
    [self.view addSubview:view];
//
//    UITextField *searchTF = [[UITextField alloc]initWithFrame:CGRectMake(20, [UIView getHeight:8], KSCreenW -2*20 , [UIView getHeight:40]-2*[UIView getHeight:8])];
//    searchTF.backgroundColor = [UIColor whiteColor];
//    searchTF.placeholder =@"搜索";
//    searchTF.textAlignment = NSTextAlignmentCenter;
//    searchTF.layer.cornerRadius = 5.0;
//    [view addSubview:searchTF];
    
    //    CGFloat statusBarHeight = 0;
    //    if ([[UIDevice currentDevice].systemVersion floatValue] <= 7.0)
    //    {
    //        statusBarHeight = 20;
    //    }
    
    
    UISearchBar * bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, KSCreenW, 40)];
    bar.placeholder = @"搜索";
//    bar.showsCancelButton = YES;
    [self.view addSubview:bar];

}


- (void)refresh{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goToBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
