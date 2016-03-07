//
//  MyClientCell.m
//  Marketing
//
//  Created by HanenDev on 16/3/1.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "MyClientCell.h"

#define STARTX [UIView getWidth:20]
#define CELLHEIGHT [UIView getHeight:60.0f]

@implementation MyClientCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellY = [UIView getHeight:5];
        //公司名称
        //CGSize size = [_companyLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, [UIView getHeight:30]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIView getFontWithSize:16.0f]} context:nil].size;
        _companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(STARTX, cellY, [UIView getWidth:200], [UIView getHeight:30])];
        _companyLabel.textColor = blackFontColor;
        _companyLabel.font = [UIFont systemFontOfSize:17.0f];
        [self.contentView addSubview:_companyLabel];
        //等级图片
        _levelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_companyLabel.maxX, cellY +8 , [UIView getWidth:20], [UIView getHeight:15])];
        _levelImageView.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:_levelImageView];
        //状态
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(KSCreenW -STARTX - 70, cellY, [UIView getWidth:100], [UIView getHeight:30])];
        _statusLabel.textColor = [UIColor cyanColor];
        _statusLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_statusLabel];
        //定位
        _locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(STARTX, _companyLabel.maxY, 20, 20)];
        [_locationBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
        [self.contentView addSubview:_locationBtn];
        //地址
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_locationBtn.maxX, _companyLabel.maxY, KSCreenW - [UIView getWidth:70]- STARTX, [UIView getHeight:20])];
        _addressLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_addressLabel];
        
        
        //负责人
        _principalLabel = [[UILabel alloc]initWithFrame:CGRectMake(_addressLabel.x, _addressLabel.maxY, KSCreenW, [UIView getHeight:20])];
        _principalLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_principalLabel];
        
        //
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(KSCreenW -STARTX - 50, _companyLabel.maxY, [UIView getWidth:100], [UIView getHeight:20])];
        _timeLabel.textColor = [UIColor cyanColor];
        _timeLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_timeLabel];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
