//
//  SelectStaffView.m
//  Marketing
//
//  Created by wmm on 16/3/2.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "SelectStaffView.h"
#import "SelectStaffViewCell.h"

@implementation SelectStaffView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
            NSLog(@"initWithFrame:%f,%f",self.width,self.height);
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setWidth:KSCreenW-50];
        UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64)];
        navBar.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [self addSubview:navBar];
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, [UIView getWidth:20], [UIView getWidth:20])];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(40,25, self.width-80, 30)];
        titleLbl.text = @"人员";
        titleLbl.textColor = lightGrayBackColor;
        titleLbl.font = [UIView getFontWithSize:15.0f];
        titleLbl.textColor = blackFontColor;
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLbl];
        
        UIButton *resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-40, 30, [UIView getWidth:20], [UIView getWidth:20])];
        [resetBtn setBackgroundImage:[UIImage imageNamed:@"reset.png"] forState:UIControlStateNormal];
        [resetBtn addTarget:self action:@selector(resetView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:resetBtn];
        
        [self initTableView];
        [self initData];
        [self addSearchBar];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCreenH-45, self.width, 1)];
        lineLab.layer.borderWidth = 1;
        lineLab.layer.borderColor = [grayFontColor CGColor];
        [self addSubview:lineLab];
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_selectBtn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [_selectBtn setTitleColor:mainOrangeColor forState:UIControlStateNormal];
        [_selectBtn.titleLabel setFont:[UIView getFontWithSize:15.0f]];
        _selectBtn.frame = CGRectMake(0, KSCreenH-44, self.width, 44);
        [_selectBtn addTarget:self action:@selector(selectStaff) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_selectBtn];
        
    }
    return self;
}

- (void)initTableView{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.width, self.height-64-44)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.backgroundColor = UIColorFromRGB(0xf5f5d5);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
//    _tableView.hidden = NO;
    
//    _staffTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, self.width, 210)];
//    _staffTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _staffTableView.backgroundColor = UIColorFromRGB(0xf5f5d5);
//    _staffTableView.delegate = self;
//    _staffTableView.dataSource = self;
//    [self addSubview:_staffTableView];
//    _staffTableView.hidden = YES;
    
}

-(void)selectStaff{
    
    if ([self.delegate respondsToSelector:@selector(getSelectedStaff:)]) {
        [self.delegate getSelectedStaff:_selectedArray];
    }
}


- (void)drawRect:(CGRect)rect {

    NSLog(@"drawRect");
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
}

-(void)closeView{
    
    [_searchBar resignFirstResponder]; //退出键盘
    [self removeFromSuperview];
}

-(void)resetView{
    
}

- (void)showSelectedImg:(SelectStaffViewCell *)cell{
    if(cell.selectedImg.hidden == YES){
        cell.selectedImg.hidden = NO;
        cell.isSelected = YES;
    }
    else{
        cell.selectedImg.hidden = YES;
        cell.isSelected = NO;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_isSearching) {
        return _searchArray.count;
    }

    return _nameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
// UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
     NSString *name;
     if (_isSearching) {
         name=_searchArray[indexPath.row];
     }else{
         name=_nameArray[indexPath.row];
     }
     
     static NSString *identifier =@"cell";
     SelectStaffViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
     if (cell == nil) {
         cell = [[SelectStaffViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
     }
     
     
     cell.nameLbl.text = name;
//     cell.cellId = 
     
     
     
     [cell.headerBtn addTarget:self action:@selector(showSelectedImg:) forControlEvents:UIControlEventTouchUpInside];

     return cell;
 }


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [_searchBar resignFirstResponder];
//    if(_departmentTableView.hidden){
//        [_departmentTableView reloadData];
//        _departmentTableView.hidden = NO;
//        _staffTableView.hidden = YES;
//        NSLog(@"选择人员");
//    }else if(_staffTableView.hidden){
//            NSLog(@"选择人员");
//        _departmentTableView.hidden = YES;
//        _staffTableView.hidden = NO;
//        [_departmentTableView reloadData];
//        [_staffTableView reloadData];
//    }
}

//#pragma mark - 搜索框代理
#pragma mark  取消搜索
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    _isSearching=NO;
    _searchBar.text=@"";
    [self.tableView reloadData];
    
//    [self resetSearch]; //重新 加载分类数据
    [_searchBar resignFirstResponder]; //退出键盘
}

#pragma mark 输入搜索关键字
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([_searchBar.text isEqual:@""]){
        _isSearching=NO;
        [self.tableView reloadData];
        return;
    }
    [self searchDataWithKeyWord:_searchBar.text];
}

#pragma mark 点击虚拟键盘上的搜索时
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self searchDataWithKeyWord:_searchBar.text];
    
    [_searchBar resignFirstResponder];//放弃第一响应者对象，关闭虚拟键盘
}


#pragma mark 重写状态样式方法
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark 加载数据
-(void)initData{
//    _nameArray = [NSMutableArray arrayWithObjects:@"小明",@"红日",@"飞红",@"杰克逊",@"高山红",@"李钟硕", nil];
    
        _nameArray = [NSMutableArray arrayWithObjects:@"aaa",@"abc",@"飞红",@"杰克逊",@"高山红",@"李钟硕", nil];
    
//    _nameArray = @[@"小明",@"红日",@"飞红",@"杰克逊",@"高山红",@"李钟硕"];

//    _titleArray = @[@"头像",@"姓名",@"电话",@"二维码名片",@"所属部门",@"职位"];

}

#pragma mark 搜索形成新数据
-(void)searchDataWithKeyWord:(NSString *)keyWord{
    _isSearching=YES;
    _searchArray=[NSMutableArray array];
    

    for (NSString *name in _nameArray) {
        NSLog(@"%@",name);
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {//ios8出来的方法
            
            if ([name.uppercaseString containsString:keyWord.uppercaseString]) {
                [_searchArray addObject:name];
            }

        }else{
        
            NSRange range = [name.uppercaseString rangeOfString:keyWord.uppercaseString];
            NSLog(@"111");
            if(range.length > 0)
            {
                [_searchArray addObject:name];
                
            }
        }
        
    }
    
    
    //刷新表格
    [self.tableView reloadData];
}

#pragma mark 添加搜索栏
-(void)addSearchBar{
    CGRect searchBarRect=CGRectMake(0, 0, self.frame.size.width, 44);
    _searchBar=[[UISearchBar alloc]initWithFrame:searchBarRect];
    _searchBar.placeholder=@"搜索";
    //_searchBar.keyboardType=UIKeyboardTypeAlphabet;//键盘类型
    //_searchBar.autocorrectionType=UITextAutocorrectionTypeNo;//自动纠错类型
    //_searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;//哪一次shitf被自动按下
    _searchBar.showsCancelButton=YES;//显示取消按钮
    //添加搜索框到页眉位置
    _searchBar.delegate=self;
    self.tableView.tableHeaderView=_searchBar;
}


- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    
    // 确定子控件的frame（这里得到的self的frame/bounds才是准确的）
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    //    self.imageView.frame = CGRectMake(0, 0, width, width);
    //    self.label.frame = CGRectMake(0, width, width, height - width);
}


@end

