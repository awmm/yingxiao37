//
//  ApprovalCell.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/3/3.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//审批cell

#import "ApprovalCell.h"

@interface ApprovalCell ()
{
     CGFloat topSpace;
    UIImageView     *_personLogo;
    UIImageView     *_waiteLoga;
    UILabel         *_nameLabel;
    UILabel         *_waiteLabel;
    UILabel         *_dateLabel;
    UILabel         *_timeLabel;
}
@end

@implementation ApprovalCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString  *noticeCellId = @"noticeCellId";
    
    ApprovalCell *cell = [tableView dequeueReusableCellWithIdentifier:noticeCellId];
    
    if (!cell) {
        cell = [[ApprovalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noticeCellId];
        //        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:.1];
        [cell addSubviews];
    }
    
    return cell;
    
}

- (void)addSubviews
{
    if (IPhone4SInCell) {
        topSpace = 6.0f;
    }else{
        topSpace = [UIView getWidth:8.0f];
    }
    CGFloat cellH = [ApprovalCell cellHeight];
    CGFloat logoW = (cellH - 2 * topSpace);
    _personLogo = [[UIImageView alloc] initWithFrame:CGRectMake(2 * topSpace, topSpace, logoW, logoW)];
    _personLogo.backgroundColor = cyanFontColor;
    _personLogo.layer.cornerRadius = logoW / 2.0f;
    _personLogo.layer.masksToBounds = YES;
    [self.contentView addSubview:_personLogo];
    
    CGFloat waiteLogoW = [UIView getWidth:13.0f];
    _waiteLoga = [[UIImageView alloc] initWithFrame:CGRectMake(logoW , _personLogo.maxY - waiteLogoW, waiteLogoW , waiteLogoW)];
//    _waiteLoga.backgroundColor = [UIColor redColor];
    _waiteLoga.image = [UIImage imageNamed:@"等待"];
    
    
    _nameLabel = [ViewTool getLabelWith:CGRectMake(_personLogo.maxX + 2 * topSpace, _personLogo.y, KSCreenW - _personLogo.maxX - 4 * topSpace, [UIView getHeight:20]) WithTitle:@"小花花" WithFontSize:13.0f WithTitleColor:blackFontColor WithTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_nameLabel];
    
    _waiteLabel = [ViewTool getLabelWith:CGRectMake(_nameLabel.x, _nameLabel.maxY + topSpace, [UIView getWidth:60], [UIView getHeight:15]) WithTitle:@"待审批" WithFontSize:12.0f WithTitleColor:grayFontColor WithTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_waiteLabel];
    
    CGFloat  dateTimeW = [UIView getWidth:113];//时间和日期 总共的长度
    CGFloat  dateX = KSCreenW - 2 * topSpace - dateTimeW;
    _dateLabel = [ViewTool getLabelWith:CGRectMake(dateX , _waiteLabel.y, [UIView getWidth:80], [UIView getHeight:15]) WithTitle:@"2016:10:12" WithFontSize:11.0f WithTitleColor:cyanFontColor WithTextAlignment:NSTextAlignmentRight];
//    _dateLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_dateLabel];
    
 
    _timeLabel = [ViewTool getLabelWith:CGRectMake(_dateLabel.maxX + 5, _waiteLabel.y, dateTimeW - _dateLabel.width, [UIView getHeight:15]) WithTitle:@"24:24" WithFontSize:11.0f WithTitleColor:cyanFontColor WithTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_timeLabel];
    
    UIView *line = [ViewTool getLineViewWith:CGRectMake(2 * topSpace, cellH - 1, KSCreenW - 4 * topSpace, 1) withBackgroudColor:grayLineColor];
    [self.contentView addSubview:line];
    
    
}

- (void)setIsWaitingApproval:(BOOL)isWaitingApproval
{
    _isWaitingApproval = isWaitingApproval;
    if (isWaitingApproval) {
         [self.contentView addSubview:_waiteLoga];
        _waiteLabel.text = @"待审批";
    }else{
        _waiteLabel.text = @"已完成审批";
    }
   
}
+ (CGFloat)cellHeight{
    return [UIView getWidth:70];
}
@end
