//
//  TabBarButton.m
//  CSR
//
//  Created by Hanen 3G 01 on 16/2/15.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import "TabBarButton.h"
#define labelRatdio 0.3//button按钮中文字占得高度

@interface TabBarButton ()
{
    CGFloat  h;
    CGFloat  y;
    
    CGRect   Rect;
}
@end
@implementation TabBarButton


#pragma mark 设置button内部的image的范围

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if(KSCreenW == 320){ //4s 5 5s
        h = 0;
        y = 0;
    }else if (KSCreenH == 736){//6p
        h = [UIView getHeight:4];
        y = [UIView getHeight:7];
    }else{//6 6s
        h = [UIView getHeight:4];
        y = [UIView getHeight:6];
    }
    CGFloat imageW = contentRect.size.width - [UIView getWidth: 46];
    CGRect imageRect = CGRectMake( [UIView getWidth:25] , 0 , imageW, contentRect.size.height * (1 - labelRatdio) + y);
//    NSLog(@"tabbarBtn imageRect ,%f,%f",h,y);
    return imageRect;
    
}

#pragma mark 设置button内部的title的范围

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
   
    CGRect titleRect = CGRectMake(0,contentRect.size.height - contentRect.size.height * labelRatdio +y , contentRect.size.width, contentRect.size.height * labelRatdio);
   
//        NSLog(@"tabbarBtn titleRect %@",NSStringFromCGRect(titleRect)); contentRect.size.height - contentRect.size.height * labelRatdio + y, contentRect.size.width
    return titleRect;
}
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
}
@end
