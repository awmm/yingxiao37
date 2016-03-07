//
//  SelectStaffView.h
//  Marketing
//
//  Created by wmm on 16/3/2.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectStaffDelegate <NSObject>

- (void)getSelectedStaff:(NSArray *)array;

//- (void)calendar:(SelectStaffView *)selectStaffView didSelectStaff:(NSString *)staffName;

@end

@interface SelectStaffView : UIView<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic) BOOL isSearching;
@property (strong, nonatomic) NSMutableArray *nameArray;
@property (strong, nonatomic) NSMutableArray *searchArray;
@property (strong, nonatomic) NSMutableArray *selectedArray;

@property (strong, nonatomic) UISearchBar * searchBar;
@property (strong, nonatomic) UITableView * tableView;

@property (strong, nonatomic) UIButton * selectBtn;

@property(nonatomic,weak)id<SelectStaffDelegate>delegate;

@end

