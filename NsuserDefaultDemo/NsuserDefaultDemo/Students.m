//
//  Students.m
//  NsuserDefaultDemo
//
//  Created by yanxinlong on 15/10/8.
//  Copyright (c) 2015年 yanxinlong. All rights reserved.
//

#import "Students.h"

@implementation Students

- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.studentName   forKey: @"studentName"];
    [aCoder encodeObject:self.studentNumber forKey: @"studentNumber"];
    [aCoder encodeObject:self.studentSex    forKey: @"studentSex"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super init]) {
        
        self.studentName   = [aDecoder decodeObjectForKey:@"studentName"];
        self.studentNumber = [aDecoder decodeObjectForKey:@"studentNumber"];
        self.studentSex    = [aDecoder decodeObjectForKey:@"studentSex"];
        
    }
    return self;
}
@end
