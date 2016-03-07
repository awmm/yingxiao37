//
//  VisitedCell.m
//  Marketing
//
//  Created by Hanen 3G 01 on 16/2/26.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "VisitedCell.h"

@interface VisitedCell ()
{
    CGFloat topSpace;
    UIImageView  *_imageView;
    UILabel      *_recordLabel;
    UIImageView  *_placeImage;
    UILabel      *_placeLabel;
    UILabel      *_signState;
    UILabel      *_timeLabel;
    
    CGFloat   lastY;
    
    
}
@end

@implementation VisitedCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    
    
    static  NSString *  const visitedCellId = @"visitedCellId";
    VisitedCell * cell = [tableview dequeueReusableCellWithIdentifier:visitedCellId];
    if (!cell) {
        cell = [[VisitedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:visitedCellId];
        [cell addSubviews];
    }
    return cell;
}
- (void)addSubviews
{
    lastY = 0;
    if (IPhone4SInCell) {
        topSpace = 6.0f;
    }else{
        topSpace = [UIView getWidth:8.0f];
    }

    CGFloat cellW = KSCreenW;
    CGFloat cellh = [VisitedCell cellHeight];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * topSpace, 1.6 * topSpace, cellh - 2 * topSpace, cellh - 3.2 * topSpace)];
    _imageView.image = [UIImage imageNamed:@"相机"];
//    _imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imageView];
    
    
    [UIColor colorWithWhite:0.3 alpha:1];
    _recordLabel = [ViewTool getLabelWith:CGRectMake(_imageView.maxX + topSpace,  topSpace, cellW - _imageView.maxX - 2 * topSpace, [UIView getHeight:20]) WithTitle:@"已拜访玩国宾酒店" WithFontSize:14.0f WithTitleColor: [UIColor colorWithWhite:0.3 alpha:1] WithTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_recordLabel];
    
    
    _placeImage = [[UIImageView alloc] initWithFrame:CGRectMake(_recordLabel.x, _recordLabel.maxY + 5, [UIView getWidth:10], [UIView getWidth:10.0f])];
//    _placeImage.backgroundColor = [UIColor redColor];
    _placeImage.image = [UIImage imageNamed:@"定位"];
    [self.contentView addSubview:_placeImage];
    
    _placeLabel = [ViewTool getLabelWith:CGRectMake(_placeImage.maxX , _recordLabel.maxY , cellW - _placeImage.maxX, 20) WithTitle:@"南京市鼓楼区山西路世贸大厦1000座1000层" WithFontSize:11.0 WithTitleColor: [UIColor colorWithWhite:0.6 alpha:1] WithTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_placeLabel];
    
    _signState = [ViewTool getLabelWith:CGRectMake(_recordLabel.x, _placeImage.maxY + 1.5 * topSpace, 80, 15) WithTitle:@"已签到" WithFontSize:10.0 WithTitleColor:blueFontColor WithTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_signState];
    
    _timeLabel = [ViewTool getLabelWith:CGRectMake(_signState.maxX, _signState.y, 100, _signState.height) WithTitle:@"24：24" WithFontSize:10.0 WithTitleColor:blueFontColor WithTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_timeLabel];
    
    UIView *line = [ViewTool getLineViewWith:CGRectMake(2 * topSpace, _imageView.maxY + 1.6 *topSpace -1, cellW - 4 * topSpace, 0.8) withBackgroudColor:[UIColor colorWithWhite:0.8 alpha:0.8]];
    [self.contentView addSubview:line];
    
    lastY = line.maxY;
    
    
}
+ (CGFloat)cellHeight
{
    return [UIView getHeight:70];
}
@end
