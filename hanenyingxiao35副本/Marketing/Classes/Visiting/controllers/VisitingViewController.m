//
//  VisitingViewController.m
//  移动营销
//
//  Created by Hanen 3G 01 on 16/2/23.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "VisitingViewController.h"
#import "CKCalendarView.h"
#import "CRM_PrefixHeader.pch"
#import "VisitTableViewCell.h"
#import "MyClientView.h"
#import "Toast+UIView.h"
#import "SelectViewController.h"
#import "SelectStaffView.h"
#import "MyTabBarController.h"
#import "NewVisitViewController.h"
#import "VisitDetailViewController.h"
#import "DateTool.h"

#define NAVHEI 44


@interface VisitingViewController ()<MyClientViewDelegate>{
    
    int calendarHei;
}



@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UILabel *monthLabel;


//@property (nonatomic, strong) WQDraggableCalendarView *calendarView;
//@property (nonatomic, strong) WQCalendarLogic *calendarLogic;

@property(nonatomic) BOOL isManager;
@property(nonatomic) BOOL isMyVisit;
@property(nonatomic, strong) MyClientView *topBtnView;
@property (strong, nonatomic) UITableView *visitTableView;
//@property (strong, nonatomic) CKCalendarView *calendar;
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) SelectStaffView *selectStaffView;

/**
 *  我的拜访
 */
@property(nonatomic,strong)UITableView     *myVisitTableView;
@property(nonatomic,strong)UIView          *myVisitView;

@property(nonatomic,strong)NSArray *myVisitArray;

/**
 *  下属拜访
 */
@property(nonatomic,strong)UITableView     *otherVisitTableView;
@property(nonatomic,strong)UIView          *otherVisitView;

@property(nonatomic,strong)NSArray *otherVisitArray;

@property(nonatomic,strong) UILabel *splitLine;

@property(nonatomic,strong) UIView *planNumView;

@property (nonatomic, strong) UISwipeGestureRecognizer *upSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *downSwipeGestureRecognizer;


//data
@property (nonatomic, strong) NSArray *timelist;
@property (nonatomic, assign) int allcount;
@property (nonatomic, assign) int daicount;
@property (nonatomic, assign) int yicount;
@property (nonatomic, strong) NSArray *daylist;
@property (nonatomic, assign) int i;

@property (nonatomic, strong) UILabel *planbLab;
@property (nonatomic, strong) UILabel *completedLab;
@property (nonatomic, strong) UILabel *notCompletedLab;


@end

@implementation VisitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton =YES;
//    CGFloat statusBarHeight = 0;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
//    {
//        statusBarHeight = 20;
//    }

    self.navigationItem.rightBarButtonItem = [ViewTool getBarButtonItemWithTarget:self WithString:@"新建" WithAction:@selector(clickToNewVisit)];
    NSString *type = [[[NSUserDefaults standardUserDefaults] objectForKey:@"type"] stringValue];

    if ([type isEqualToString:@"2"]) {
        _isManager = YES;
        self.navigationItem.title = @"";
        
        _topBtnView = [[MyClientView alloc] initWithFrame:CGRectMake(0, 0, [UIView getWidth:200], 44) withLeftTitle:@"下属拜访" andRightTitle:@"我的拜访"];
        _topBtnView.delegate = self;
        self.navigationItem.titleView = _topBtnView;
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 43, KSCreenW, 0.5)];
        lineLabel.backgroundColor = grayLineColor;
        [_topBtnView addSubview:lineLabel];
        
    }else{
        _isManager = NO;
        self.navigationItem.title = @"我的拜访";
    }
    [self addCalendarView];
    _i = 0;
    NSLog(@"44444444");
    [self reloadData];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

//- (void)viewDidDisappear:(BOOL)animated;

- (void)addCalendarView{
    //日历
    self.calendar = [JTCalendar new];
    self.calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 64, KSCreenW, 50)];
    
    UILabel *Line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.calendarMenuView.maxY-1, KSCreenW, 1)];
    Line.layer.borderColor = [grayLineColor CGColor];
    [self.view addSubview:Line];
    
    self.calendarMenuView.backgroundColor = [UIColor whiteColor];
    //    self.calendarContentViewHeight.constant = 200;
    self.calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(0, self.calendarMenuView.maxY, KSCreenW, 300)];
    
    self.calendarContentView.backgroundColor = graySectionColor;
    self.calendarContentView.layer.borderWidth = 1.0;
    //    self.calendarContentView.layer.borderColor = [grayListColor CGColor];
    self.calendarContentView.layer.borderColor = grayLineColor.CGColor;
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 1; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    [self.view addSubview:self.calendarMenuView];
    [self.view addSubview:self.calendarContentView];
    
    self.upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.upSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    self.downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self.calendarContentView addGestureRecognizer:self.upSwipeGestureRecognizer];
    [self.calendarContentView addGestureRecognizer:self.downSwipeGestureRecognizer];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
//        CGPoint labelPosition = CGPointMake(self.swipeLabel.frame.origin.x - 100.0, self.swipeLabel.frame.origin.y);
        self.calendar.calendarAppearance.isWeekMode = YES;
        [self transitionExample];
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
//        CGPoint labelPosition = CGPointMake(self.swipeLabel.frame.origin.x + 100.0, self.swipeLabel.frame.origin.y);
        self.calendar.calendarAppearance.isWeekMode = NO;
        [self transitionExample];
    }
}

- (void)addTableView{
    
    _planNumView = [[UIView alloc] initWithFrame:CGRectMake(0, 114+self.calendar.contentView.height+10, KSCreenW, 30)];

    _planbLab = [[UILabel alloc] initWithFrame:CGRectMake(0,0, KSCreenW/3, 20)];
    _planbLab.text = [NSString stringWithFormat:@"今日计划:%d",_allcount];
    _planbLab.textColor = grayFontColor;
    _planbLab.font = [UIFont systemFontOfSize:16];
    _planbLab.textAlignment = NSTextAlignmentCenter;
    [_planNumView addSubview:_planbLab];
    _completedLab = [[UILabel alloc] initWithFrame:CGRectMake(KSCreenW/3,0, KSCreenW/3, 20)];
    _completedLab.text = [NSString stringWithFormat:@"已完成:%d",_yicount];
    _completedLab.textColor = grayFontColor;
    _completedLab.font = [UIFont systemFontOfSize:16];
    _completedLab.textAlignment = NSTextAlignmentCenter;
    [_planNumView addSubview:_completedLab];
    _notCompletedLab = [[UILabel alloc] initWithFrame:CGRectMake(KSCreenW/3*2,0, KSCreenW/3, 20)];
    _notCompletedLab.text = [NSString stringWithFormat:@"未完成:%d",_daicount];
    _notCompletedLab.textColor = darkOrangeColor;
    _notCompletedLab.font = [UIFont systemFontOfSize:16];
    _notCompletedLab.textAlignment = NSTextAlignmentCenter;
    [_planNumView addSubview:_notCompletedLab];
    
    [self.view addSubview:_planNumView];
    
    _splitLine = [[UILabel alloc] initWithFrame:CGRectMake(20, _planNumView.maxY-1, KSCreenW-40, 1)];
    _splitLine.layer.borderWidth = 10;
    _splitLine.layer.borderColor = [grayLineColor CGColor];
    [self.view addSubview:_splitLine];
    
    
    _visitTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, _splitLine.maxY, KSCreenW, KSCreenH-20-44-340-TabbarH) style:UITableViewStylePlain];
    _visitTableView.delegate=self;
    _visitTableView.dataSource=self;
    _visitTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_visitTableView];
    
    NSLog(@"%f",self.navigationItem.titleView.height);
    
    CGRect rectStaus = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"staus width:%f",rectStaus.size.width);
    NSLog(@"staus height:%f",rectStaus.size.height);
    
    CGRect rectNav = self.navigationController.navigationBar.frame;
    NSLog(@"nav width:%f",rectNav.size.width);
    NSLog(@"nav height:%f",rectNav.size.height);

}

- (void)refreshData{
    _planbLab.text = [NSString stringWithFormat:@"今日计划:%d",_allcount];
    _completedLab.text = [NSString stringWithFormat:@"已完成:%d",_yicount];
    _notCompletedLab.text = [NSString stringWithFormat:@"未完成:%d",_daicount];
}

- (void)changeHeight{
    _planNumView.frame = CGRectMake(0, 114+self.calendar.contentView.height+10, KSCreenW, 30);
    _splitLine.frame = CGRectMake(20, _planNumView.maxY-1, KSCreenW-40, 1);
    _visitTableView.frame = CGRectMake(0, _splitLine.maxY, KSCreenW, KSCreenH-_splitLine.maxY-10-TabbarH);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadData{
        NSLog(@"44444444");
//    if (!_isManager) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [[userDefaults objectForKey:@"uid"] stringValue];
        NSString *token = [userDefaults objectForKey:@"token"];
        
        NSDictionary * params1 = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", token, @"token",nil, @"year", nil, @"month", nil];
        AFHTTPRequestOperationManager * manager1 = [AFHTTPRequestOperationManager manager];
        manager1.requestSerializer.timeoutInterval = 20;
        [manager1 POST:GET_MONTH_VISIT_URL parameters:params1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self.view hideToastActivity];
//            [self addCalendarView];
            [self.calendar reloadData];//标记点
            NSLog(@"GET_MONTH_VISIT_URL:%@",responseObject);
            int code = [[(NSDictionary *)responseObject objectForKey:@"code"] intValue];
            if(code != 100)
            {
                NSString * message = [(NSDictionary *)responseObject objectForKey:@"message"];
                [self.view makeToast:message];
                NSLog(@"%@",message);
                
            }else{
                _timelist = [(NSDictionary *)responseObject objectForKey:@"timelist"];
                NSLog(@"%@",_timelist[0]);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [self.view hideToastActivity];
//            [self.view makeToast:@"失败"];
        }];
        NSDate *now = [NSDate date];
        [self getDaylist:now];
//
//    }
    
}

- (void)getDaylist:(NSDate *)date{
    
    NSLog(@"===========");
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:@(UID), @"uid", TOKEN, @"token", [DateTool getYear:date], @"year", [DateTool getMonth:date], @"month",[DateTool getDay:date], @"day", nil];
    
    NSLog(@"%@",params);
    
//        NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:@(UID), @"uid", TOKEN, @"token", @([DateTool getYear:date]), @"year", @([DateTool getMonth:date]), @"month",@([DateTool getDay:date]), @"day", nil];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    [manager POST:GET_VISIT_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.view hideToastActivity];
        NSLog(@"GET_VISIT_URL:%@",responseObject);
        int code = [[(NSDictionary *)responseObject objectForKey:@"code"] intValue];
        
        if(code != 100)
        {
            NSString * message = [(NSDictionary *)responseObject objectForKey:@"message"];
            [self.view makeToast:message];
            NSLog(@"%@",message);
        }else{
            _allcount = [[(NSDictionary *)responseObject objectForKey:@"allcount"] intValue];
            _yicount = [[(NSDictionary *)responseObject objectForKey:@"yicount"] intValue];
            _daicount = [[(NSDictionary *)responseObject objectForKey:@"daicount"] intValue];
            _daylist = [(NSDictionary *)responseObject objectForKey:@"daylist"];
        
            if (_i == 0) {
                [self addTableView];
                _i ++;
            }else{
                [self refreshData];
                [_visitTableView reloadData];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self.view hideToastActivity];
        //            [self.view makeToast:@"登录失败"];
    }];
}

#pragma mark - Buttons callback

//- (IBAction)didGoTodayTouch
//{
//    [self.calendar setCurrentDate:[NSDate date]];
//}
//
//- (IBAction)didChangeModeTouch
//{
//    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
//    
//    [self transitionExample];
//}

#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    //    return (rand() % 10) == 1;
//    return (rand() % 2) == 0;
    NSLog(@"-------------%@",_timelist);
    for(NSString *dateStr in _timelist){
        NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss +0000"];
        [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"] ];
        NSDate *date1 =[[NSDate alloc]init];
        date1 =[df dateFromString:dateStr];
            NSLog(@"Date-***-*-*-*: %@", date1);
        
        return [DateTool isSameDay:date date2:date1];
    }
    return NO;
    
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"Date: %@", date);
    [self getDaylist:date];
}

#pragma mark - Transition examples

- (void)transitionExample
{    
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                         self.calendarContentView.frame = CGRectMake(0, self.calendarMenuView.maxY, KSCreenW, newHeight);
                         [self changeHeight];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
    
    

    NSLog(@"%f",self.calendar.contentView.layer.position.y);
}

- (void)clickToNewVisit{
    NSLog(@"clickToNewVisit");
    
    NewVisitViewController *newVisitViewController = [[NewVisitViewController alloc] init];
    [self.navigationController pushViewController:newVisitViewController animated:YES];
    
}

- (void)changeVisit{
    NSLog(@"1111");
}

- (void)addVisit{
    NSLog(@"2222");
}

- (void)clickToselectVisit{
    NSLog(@"11111");
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    AppDelegate * appdelagte = [UIApplication sharedApplication].delegate;
    appdelagte.tabbarControl.bottomView.hidden = YES;

    //背影黑罩
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCreenW, KSCreenH)];
    _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view insertSubview:_backView belowSubview:self.view];

    _selectStaffView = [[SelectStaffView alloc]initWithFrame:CGRectMake( 50, 0, KSCreenW-50, KSCreenH)];
    [self.view addSubview:_selectStaffView];
    
}



- (void)closeStaffView{
    
    NSLog(@"33333333");
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    AppDelegate * appdelagte = [UIApplication sharedApplication].delegate;
    appdelagte.tabbarControl.bottomView.hidden = NO;
    
    _backView.hidden = YES;
    _selectStaffView.hidden = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@".....");
//    self.navigationController.navigationBarHidden = YES;
    [self closeStaffView];
}

#pragma mark --MyClientView delagte

- (void)changeNoticeView:(NSInteger)tag
{
    if (tag == 1111) {//下属拜访
        _isMyVisit = NO;
        _myVisitView.hidden = YES;
        _otherVisitView.hidden = NO;
        
        [_topBtnView.otherClient setTitleColor:darkOrangeColor forState:UIControlStateNormal];
        [_topBtnView.myClient setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        _topBtnView.redLine1.backgroundColor = darkOrangeColor;
        _topBtnView.redLine2.backgroundColor = grayLineColor;
        
        self.navigationItem.leftBarButtonItem  = [ViewTool getBarButtonItemWithTarget:self WithString:@"筛选" WithAction:@selector(clickToselectVisit)];
        
    }else if (tag == 2222){//我的拜访
        _isMyVisit =YES;
        _myVisitView.hidden = NO;
        _otherVisitView.hidden = YES;
        
        [_topBtnView.otherClient setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        [_topBtnView.myClient setTitleColor:darkOrangeColor forState:UIControlStateNormal];
        _topBtnView.redLine1.backgroundColor = grayLineColor;
        _topBtnView.redLine2.backgroundColor = darkOrangeColor;
        
        self.navigationItem.leftBarButtonItem  = nil;
        
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allcount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ExchangeTableViewCell";
    VisitTableViewCell *cell = (VisitTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[VisitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    cell.companyLab.text = @"南京盈溪工业自动化有限公司";
//    cell.visitTimeLab.text = @"14:30";
//    cell.addressLab.text = @"江宁区天元中路126号新城发展中心2栋1512";
//    cell.visitStausLab.text = @"待拜访";
    cell.companyLab.text = [_daylist[indexPath.row] objectForKey:@"company"];
    NSString *time = [_daylist[indexPath.row] objectForKey:@"ordertime"];
    NSArray * arr = [time componentsSeparatedByString:@" "];
    NSLog(@"%@",arr);
    cell.visitTimeLab.text = arr[1];
    cell.addressLab.text = [_daylist[indexPath.row] objectForKey:@"address"];
    int visitStaus = [[_daylist[indexPath.row] objectForKey:@"status"] intValue];
    if (visitStaus == 1) {
        cell.visitStausLab.text = @"已拜访";
    }else{
        cell.visitStausLab.text = @"未拜访";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VisitDetailViewController *visitDetailViewController = [[VisitDetailViewController alloc] init];
    visitDetailViewController.visitRecordId = [[_daylist[indexPath.row] objectForKey:@"id"] intValue];
    [self.navigationController pushViewController:visitDetailViewController animated:YES];
}


//CG_INLINE CGRect
//CGRectMake1(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
//{
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    return CGRectMake(x * app.autoSizeScaleX, y * app.autoSizeScaleY, width * app.autoSizeScaleX, height * app.autoSizeScaleX);
//}
//
//CG_INLINE CGRect
//CGRectMake2(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
//{
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    return CGRectMake(x, y * app.autoSizeScaleY, width, height * app.autoSizeScaleX);
//}
//
//CG_INLINE CGRect
//CGRectMake3(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
//{
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    return CGRectMake(x, y * app.autoSizeScaleY, width, height);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
