//
//  NoticeCell.m
//  移动营销
//
//  Created by Hanen 3G 01 on 16/2/24.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "NoticeCell.h"
#import "NoticeModel.h"

#define allSpace 10.0f

@interface NoticeCell ()
{
    UIImageView   *_coverImage;
    UILabel       *_titleLabel;
    UILabel       *_subTitleLabel;
    UILabel       *_timeLabel;
    UIView        *_lineView;
}
@end


@implementation NoticeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
     static NSString  *noticeCellId = @"noticeCellId";
    
    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeCellId];
    
    if (!cell) {
        cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noticeCellId];
//        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.1];
        [cell addSubviews];
    }
    
    return cell;
    
}
- (void)addSubviews
{
    _coverImage = [[UIImageView alloc] init];
    _coverImage.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_coverImage];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor orangeColor];
    _titleLabel.font = [UIView getFontWithSize:15.0f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    [self.contentView addSubview:_titleLabel];
    
    
    _subTitleLabel = [[UILabel alloc] init];
    _subTitleLabel.backgroundColor = [UIColor orangeColor];
    _subTitleLabel.font = [UIView getFontWithSize:13.0f];
    _subTitleLabel.textAlignment = NSTextAlignmentLeft;
    _subTitleLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
    [self.contentView addSubview:_subTitleLabel];
    
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.backgroundColor = [UIColor greenColor];
    _timeLabel.font = [UIView getFontWithSize:13.0f];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:_timeLabel];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_lineView];
    
    CGFloat cellH = [NoticeCell cellHeight];
    CGFloat cellW = KSCreenW;
    _coverImage.frame = CGRectMake(allSpace, allSpace, [UIView getWidth:80], cellH - 2 * allSpace);
    _titleLabel.frame = CGRectMake(_coverImage.maxX + allSpace, allSpace, cellW - _coverImage.maxY - allSpace * 2, 30);
    
    _subTitleLabel.frame = CGRectMake(_titleLabel.x, _titleLabel.maxY + 5, 100, 30);
    _timeLabel.frame = CGRectMake(cellW - 90 -   2 * allSpace, _subTitleLabel.y, 90, 30);
    _lineView.frame = CGRectMake(allSpace * 2, cellH - 1, cellW - 4 * allSpace, 1);
}
//- (void)layoutSubviews
//{
//    _coverImage.frame = CGRectMake(allSpace, allSpace, [UIView getWidth:80], self.height - 2 * allSpace);
//    _titleLabel.frame = CGRectMake(_coverImage.maxX + allSpace, allSpace, self.width - _coverImage.maxY - allSpace * 2, 30);
//    
//    _subTitleLabel.frame = CGRectMake(_titleLabel.x, _titleLabel.maxY + 5, 100, 30);
//    _timeLabel.frame = CGRectMake(self.width - 90 -   2 * allSpace, _subTitleLabel.y, 90, 30);
//    _lineView.frame = CGRectMake(allSpace * 2, self.height - 1, self.width - 4 * allSpace, 1);
//    
//}

- (void)setModel:(NoticeModel *)model
{
    _model = model;
    //赋值...
}

+ (CGFloat)cellHeight
{
    return [UIView getHeight:80];
}
- (void)awakeFromNib {
    // Initialization code
}
//- (void)setHighlighted:(BOOL)highlighted
//{
//    [super setHighlighted:highlighted];
//    _coverImage .backgroundColor = [UIColor orangeColor];
//     _titleLabel.backgroundColor = [UIColor orangeColor];
//    _subTitleLabel.backgroundColor = [UIColor orangeColor];
//     _timeLabel.backgroundColor = [UIColor greenColor];
//      _lineView.backgroundColor = [UIColor lightGrayColor];
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
