//
//  MyTabBarController.m
//  CSR
//
//  Created by Hanen 3G 01 on 16/2/15.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "MyTabBarController.h"
#import "TabBarButton.h"
#import "MyNavigationController.h"
#import "ClientsViewController.h"
#import "WorkViewController.h"
#import "VisitingViewController.h"
#import "MineViewController.h"

#define BtnW [UIScreen mainScreen].bounds.size.width / self.tabBarItemTitle.count


@interface MyTabBarController ()
{
    TabBarButton * _lastPressBtn;

  
    
}
@property (nonatomic, strong) NSArray * tabBarItemTitle;
@property (nonatomic, strong) NSArray * taBBarItemImage;
@property (nonatomic, strong) NSArray * taBBarItemSelectedImage;

@property (nonatomic, strong)NSArray  * tabBarControllers;
@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.hidden = YES;
    [self addTabBarView];

//    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       [UIColor lightGrayColor], NSForegroundColorAttributeName,
//                                                       nil] forState:UIControlStateNormal];
//    UIColor *titleHighlightedColor = [UIColor blueColor];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       titleHighlightedColor, NSForegroundColorAttributeName,
//                                                       nil] forState:UIControlStateSelected];
}


//如果要外界就注释掉这些懒加载
- (NSArray *)tabBarControllers
{
    if (_tabBarControllers == nil) {
        VisitingViewController *visitingVC = [[VisitingViewController alloc] init];
        MyNavigationController * visitingNav = [[MyNavigationController alloc] initWithRootViewController:visitingVC];
        
        ClientsViewController *ClientVC = [[ClientsViewController alloc] init];
        MyNavigationController * ClientNav = [[MyNavigationController alloc] initWithRootViewController:ClientVC];
        
        
        WorkViewController *workingVC = [[WorkViewController alloc] init];
        MyNavigationController * workingNav = [[MyNavigationController alloc] initWithRootViewController:workingVC];
        
        MineViewController *mineVC = [[MineViewController alloc] init];
        MyNavigationController * mineNav = [[MyNavigationController alloc] initWithRootViewController:mineVC];
        _tabBarControllers = @[visitingNav,ClientNav,workingNav,mineNav];
    }
    
    return _tabBarControllers;
}

- (NSArray *)tabBarItemTitle
{
    if (_tabBarItemTitle == nil) {
        _tabBarItemTitle = @[@"拜访",@"客户",@"工作",@"我的"];
    }
    
    return _tabBarItemTitle;
}

- (NSArray *)taBBarItemImage
{
    if (_taBBarItemImage == nil) {
        _taBBarItemImage =  @[@"拜访 enter.png",@"客户－enter.png",@"工作 enter.png",@"我的-enter.png"];
    }
    
    return _taBBarItemImage;
}
- (NSArray *)taBBarItemSelectedImage
{
    if (_taBBarItemSelectedImage == nil) {
        _taBBarItemSelectedImage = @[@"拜访.png",@"客户.png",@"工作.png",@"我的.png"];
    }
    
    return _taBBarItemSelectedImage;
}


- (void)addTabBarView
{
    CGFloat height;
    if (KSCreenW == 320) {
        height = 49;
    }else{
        height = [UIView getWidth:46];
    }
    _bottomView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, KSCreenH - height, KSCreenW, height)];
    _bottomView.image = self.tabBarBackImage;
    _bottomView.userInteractionEnabled = YES;
    NSLog(@"bottomFrame:%@",NSStringFromCGRect(_bottomView.frame));
    _bottomView.backgroundColor = TabbarColor;
    [self.view addSubview:_bottomView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCreenW, 1)];
    line.backgroundColor = tabbarLineColor;
    [_bottomView addSubview:line];

    for (int i = 0; i < self.tabBarItemTitle.count; i ++) {
        TabBarButton *btn = [[TabBarButton alloc] initWithFrame:CGRectMake(i * BtnW, 1, BtnW, 49)];

        [btn setTitle:self.tabBarItemTitle[i] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:self.taBBarItemImage[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.taBBarItemSelectedImage[i]] forState:UIControlStateSelected | UIControlStateHighlighted];
        btn.imageView.center =  btn.center;
//        btn.titleLabel.center = btn.center;
//        btn.imageView.backgroundColor = [UIColor redColor];
//        btn.titleLabel.font = [UIView getFontWithFontName:@"Marion-Regular" Size:9.0f];
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        if(i == 0){
//            btn.titleLabel.backgroundColor = [UIColor redColor];
//            btn.imageView.backgroundColor = [UIColor orangeColor];
//        }
        [_bottomView addSubview:btn];

        btn.tag = i + 1;
        [btn addTarget:self action:@selector(changeControllers:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0)//设置第一个选择项。（默认选择项）
        {
            btn.isSelected = YES;
            _lastPressBtn = btn;
      
        }else{
            btn.isSelected = NO;

        }
        
        [btn setTitleColor:btn.isSelected == YES ? [UIColor blueColor] : [UIColor colorWithWhite:0.4 alpha:1] forState:btn.isSelected == YES? UIControlStateSelected : UIControlStateNormal];
    }
   
//    NSLog(@"%d",_bottomView.subviews.count);
    
    self.viewControllers =  [NSArray arrayWithArray:self.tabBarControllers];
}


- (void)changeControllers:(TabBarButton *)btn
{
//
    
    if ((btn.tag - 1) != self.selectedIndex) {
         _lastPressBtn.isSelected = !_lastPressBtn.isSelected;
        _lastPressBtn.titleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        btn.titleLabel.textColor = [UIColor blueColor];
//        btn.selected = !btn.selected;
//         _lastPressBtn.selected = NO;
//        _lastPressBtn.titleLabel.textColor = [UIColor lightGrayColor];
//        btn.titleLabel.textColor = [UIColor redColor];
        btn.isSelected = YES;
        _lastPressBtn = btn;
        self.selectedIndex = btn.tag - 1;
      
    }
    

}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    _bottomView.hidden = hidesBottomBarWhenPushed;
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
