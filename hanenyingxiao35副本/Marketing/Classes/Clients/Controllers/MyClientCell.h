//
//  MyClientCell.h
//  Marketing
//
//  Created by HanenDev on 16/3/1.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClientCell : UITableViewCell

@property(nonatomic,strong)UILabel     *companyLabel;
@property(nonatomic,strong)UIImageView *levelImageView;
@property(nonatomic,strong)UILabel     *statusLabel;
@property(nonatomic,strong)UIButton    *locationBtn;
@property(nonatomic,strong)UILabel     *addressLabel;
@property(nonatomic,strong)UILabel     *principalLabel;

@property(nonatomic,strong)UILabel     *timeLabel;
@end
