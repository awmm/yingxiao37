//
//  ViewTool.m
//  移动营销
//
//  Created by Hanen 3G 01 on 16/2/24.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "ViewTool.h"

@implementation ViewTool

+(UIView *)getLineViewWith:(CGRect)frame withBackgroudColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

+ (UILabel *)getLabelWith:(CGRect)frame WithTitle:(NSString *)title WithFontSize:(CGFloat)fontSize WithTitleColor:(UIColor *)color WithTextAlignment:(NSTextAlignment )textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.font = [UIView getFontWithSize:fontSize];
//    label.font = [UIFont systemFontOfSize:fontSize];
    
    return label;
    
}
+ (UILabel *)getLabelWithFrame:(CGRect)frame WithAttrbuteString:(NSMutableAttributedString *)attrbuteTitle
{
    UILabel *attrbuteLabel = [[UILabel alloc] initWithFrame:frame];
    attrbuteLabel.attributedText = attrbuteTitle;
    return attrbuteLabel;
}

+ (UIBarButtonItem *)getBarButtonItemWithTarget:(id)target WithAction:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIView getWidth:20], [UIView getWidth:20])];
    [btn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (UIBarButtonItem *)getBarButtonItemWithTarget:(id)target WithString:(NSString *)string WithAction:(SEL)action{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIView getWidth:20], [UIView getWidth:20])];
    [btn setBackgroundImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (UIImage *)getImageFromColor:(UIColor *)color WithRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
@end
