//
//  Students.h
//  NsuserDefaultDemo
//
//  Created by yanxinlong on 15/10/8.
//  Copyright (c) 2015年 yanxinlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Students : NSObject <NSCoding>

@property (nonatomic, copy) NSString *studentName;
@property (nonatomic, copy) NSString *studentNumber;
@property (nonatomic, copy) NSString *studentSex;

@end
