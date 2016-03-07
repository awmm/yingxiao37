//
//  InformationCell.m
//  Marketing
//
//  Created by HanenDev on 16/2/25.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "InformationCell.h"
#define STARTX [UIView getWidth:20]
#define CELLHEIGHT [UIView getHeight:60.0f]

@implementation InformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat cellY = [UIView getHeight:5];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(STARTX, cellY, KSCreenW -2*STARTX, [UIView getHeight:20.0f])];
        _titleLabel.textColor = lightGrayFontColor;
        _titleLabel.font = [UIView getFontWithSize:13.0f];
        [self.contentView addSubview:_titleLabel];
        
        _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(STARTX, _titleLabel.maxY, KSCreenW -2*STARTX, [UIView getHeight:30.0f])];
        _subLabel.textColor = blackFontColor;
        _subLabel.font = [UIView getFontWithSize:15.0f];
        [self.contentView addSubview:_subLabel];
        
        _qrImage = [[UIImageView alloc]initWithFrame:CGRectMake(KSCreenW - STARTX -[UIView getWidth:30]-[UIView getWidth:10], [UIView getHeight:15], [UIView getWidth:30], [UIView getHeight:30])];
        //_qrImage.layer.cornerRadius = 20;
        //_qrImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_qrImage];
        
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(STARTX, CELLHEIGHT - 1, KSCreenW -2*STARTX, 1)];
        lineView.backgroundColor = grayLineColor;
        [self.contentView addSubview:lineView];
               
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
