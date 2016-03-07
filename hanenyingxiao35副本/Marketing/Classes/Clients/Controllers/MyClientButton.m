//
//  MyClientButton.m
//  Marketing
//
//  Created by HanenDev on 16/3/1.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "MyClientButton.h"

@implementation MyClientButton

#pragma mark - 设置按钮内部图片和文字的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat W = [UIView getWidth:15] ;
    CGFloat H = contentRect.size.height - [UIView getHeight:15]*2;
    
    return CGRectMake(self.titleLabel.maxX , [UIView getHeight:15], W, H);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat W = contentRect.size.width - [UIView getWidth:15];
    CGFloat H = contentRect.size.height;
    return CGRectMake(0, 0, W, H);
    
}


@end
