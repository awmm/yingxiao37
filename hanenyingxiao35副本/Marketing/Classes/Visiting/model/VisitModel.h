//
//  VisitModel.h
//  Marketing
//
//  Created by wmm on 16/3/6.
//  Copyright © 2016年 Hanen 3G 01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisitModel : NSObject

@property (nonatomic, assign) int visitId;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *cName;
@property (nonatomic, strong) NSString *clevel;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *overtime;
@property (nonatomic, strong) NSString *status;

@end
