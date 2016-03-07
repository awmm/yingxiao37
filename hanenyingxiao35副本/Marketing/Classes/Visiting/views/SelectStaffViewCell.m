//
//  SelectStaffViewCell.m
//  Marketing
//
//  Created by wmm on 16/3/3.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "SelectStaffViewCell.h"

@implementation SelectStaffViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"%f---%f",self.height,self.width);
        // Initialization code
        self.clipsToBounds = YES;
        //选中单元格
        //        UIView *bgView = [[UIView alloc] init];
        //        bgView.backgroundColor = [UIColor colorWithRed:(20.0f/255.0f) green:(30.0f/255.0f) blue:(40.0f/255.0f) alpha:0.5f];
        //        self.selectedBackgroundView = bgView;
        
//        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.headerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.headerBtn.frame = CGRectMake(10,10, 40, 40);
        [self.headerBtn setBackgroundImage:[UIImage imageNamed:@"vip.png"] forState:UIControlStateNormal];
//        [self.headerBtn addTarget:self action:@selector(showSelectedImg) forControlEvents:UIControlEventTouchUpInside];
        
        self.selectedImg = [[UIImageView alloc] initWithFrame:CGRectMake(40,40, 10, 10)];
        self.selectedImg.image = [UIImage imageNamed:@"选择.png"];
        self.selectedImg.hidden = YES;
        
        self.nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(60,10, self.width-80, 40)];
        self.nameLbl.font = [UIFont systemFontOfSize:16];
        self.nameLbl.textColor = lightGrayFontColor;
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 59, self.width-40, 1)];
        lineLab.layer.borderWidth = 1;
        lineLab.layer.borderColor = [grayLineColor CGColor];
        
        [self.contentView addSubview:self.headerBtn];
        [self.contentView addSubview:self.selectedImg];
        [self.contentView addSubview:self.nameLbl];
        [self.contentView addSubview:lineLab];
        
    }
    return self;
}
//
//- (void)showSelectedImg{
//    if(self.selectedImg.hidden == YES){
//        self.selectedImg.hidden = NO;
//        self.isSelected = YES;
//    }
//    else{
//        self.selectedImg.hidden = YES;
//        self.isSelected = NO;
//    }
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
