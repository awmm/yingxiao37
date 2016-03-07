//
//  SelectStaffViewCell.h
//  Marketing
//
//  Created by wmm on 16/3/3.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectStaffViewCell : UITableViewCell

@property (strong, nonatomic) UIButton *headerBtn;
@property (strong, nonatomic) UIImageView *selectedImg;
@property (strong, nonatomic) UILabel *nameLbl;
@property (nonatomic) BOOL isSelected;
@property (strong, nonatomic) NSString *cellId;

@end
