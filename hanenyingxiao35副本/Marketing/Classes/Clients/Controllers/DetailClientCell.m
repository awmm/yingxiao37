//
//  DetailClientCell.m
//  Marketing
//
//  Created by HanenDev on 16/3/2.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "DetailClientCell.h"

#define STARTX [UIView getWidth:20]
#define CELLHEIGHT [UIView getHeight:60.0f]

@implementation DetailClientCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat cellY = [UIView getHeight:5];
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(STARTX, cellY, KSCreenW - 2*STARTX, [UIView getHeight:20])];
        _nameLabel.textColor = grayFontColor;
        [self.contentView addSubview:_nameLabel];
        
        _nameTF = [[UITextField alloc]initWithFrame:CGRectMake(STARTX, _nameLabel.maxY, KSCreenW - 2*STARTX, [UIView getHeight:30])];
        [self.contentView addSubview:_nameTF];
        
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
