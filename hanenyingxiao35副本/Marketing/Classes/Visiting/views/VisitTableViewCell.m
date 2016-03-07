//
//  VisitTableViewCell.m
//  Marketing
//
//  Created by wmm on 16/2/29.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "VisitTableViewCell.h"
#import "CRM_PrefixHeader.pch"

@implementation VisitTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        //选中单元格
        //        UIView *bgView = [[UIView alloc] init];
        //        bgView.backgroundColor = [UIColor colorWithRed:(20.0f/255.0f) green:(30.0f/255.0f) blue:(40.0f/255.0f) alpha:0.5f];
        //        self.selectedBackgroundView = bgView;
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.companyLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, KSCreenW/3*2, 20)];
        self.companyLab.font = [UIFont systemFontOfSize:16];
        self.companyLab.textColor = blackFontColor;
        
        UIImageView *companyLevelImage = [[UIImageView alloc] initWithFrame:CGRectMake(KSCreenW/2+20, 10, 20, 20)];
        companyLevelImage.image = [UIImage imageNamed:@"vip.png"];
        
        self.visitTimeLab = [[UILabel alloc] initWithFrame:CGRectMake(KSCreenW-90, 10, 70, 20)];
        self.visitTimeLab.font = [UIFont systemFontOfSize:13];
        self.visitTimeLab.textColor = blueFontColor;
        self.visitTimeLab.textAlignment = NSTextAlignmentRight;
        
        UIImageView *addressImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 20, 20)];
        addressImage.image = [UIImage imageNamed:@"address.png"];
        
        self.addressLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, KSCreenW/4*3, 20)];
        self.addressLab.font = [UIFont systemFontOfSize:13];
        self.addressLab.textColor = grayFontColor;
        
        self.visitStausLab = [[UILabel alloc] initWithFrame:CGRectMake(KSCreenW-100, 40, 80, 20)];
        self.visitStausLab.font = [UIFont systemFontOfSize:14];
        self.visitStausLab.textColor = blueFontColor;
        self.visitStausLab.textAlignment = NSTextAlignmentRight;
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 69, KSCreenW-40, 1)];
        lineLab.layer.borderWidth = 1;
        lineLab.layer.borderColor = [grayLineColor CGColor];
        
        [self.contentView addSubview:self.companyLab];
        [self.contentView addSubview:companyLevelImage];
        [self.contentView addSubview:self.visitTimeLab];
        [self.contentView addSubview:addressImage];
        [self.contentView addSubview:self.addressLab];
        [self.contentView addSubview:self.visitStausLab];
        [self.contentView addSubview:lineLab];
        
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
