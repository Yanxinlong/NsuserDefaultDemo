//
//  ViewController.m
//  NsuserDefaultDemo
//
//  Created by yanxinlong on 15/10/8.
//  Copyright (c) 2015年 yanxinlong. All rights reserved.
//

#import "ViewController.h"

#import "Students.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self savePasswordToNSUserDefaults];
    [self saveArryToNSUserDefaults];
    [self saveObjectToNSUserDefaults];
}

#pragma mark-------------------------存取String---------------------------

- (void)savePasswordToNSUserDefaults {

    NSString *passWord = @"123456";

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:passWord forKey:@"passWord"];
    
    [self readPasswordFromNSUserDefaults];

}

- (void)readPasswordFromNSUserDefaults {

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *passWord = [user objectForKey:@"passWord"];

    NSLog(@"密码是:%@",passWord);
}


#pragma mark-------------------------存取数组---------------------------

- (void)saveArryToNSUserDefaults {
/** < 存放可变数组到NSUserDefaults一定要先变为不可变数组 > **/
    NSMutableArray *mutableArry = [NSMutableArray arrayWithObjects:@"123",@"456",@"789", nil];
    NSArray *arry = [NSArray arrayWithArray:mutableArry];


    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:arry forKey:@"numberArry"];
    
    [self readArryFromNSUserDefaults];
}

- (void)readArryFromNSUserDefaults {

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *mutableArry = [NSMutableArray arrayWithArray:[user objectForKey:@"numberArry"]];
    
    NSLog(@"数组是:%@",mutableArry);
}

#pragma mark-------------------------存取对象--将自定义类型转变为NSData类型存入 NSUserDefaults 中-------------------------
/** < 以存取学生对象为例 > **/
//将Student类型变成NSData类型 ，那么就必须实现归档：

//这里要实现 在.h 文件中申明 NSCoding 协议，再 在 .m 中实现 encodeWithCoder 方法 和 initWithCoder 方法就可以了

- (void)saveObjectToNSUserDefaults {
//创建对象
    Students *student = [[Students alloc]init];
    
    student.studentName = @"yanxinlong";
    student.studentNumber = @"1001";
    student.studentSex = @"nan";
    
//要建立一个可变数组来存储 NSDate对象
    
    //创建存放对象的可变数组
    NSMutableArray * dataArry = [NSMutableArray array];
    
    //建一个循环模拟存放多个对象
    for (int i = 0; i < 5; ++i) {
        
        //将student类型转化为NSData类型
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:student];
        //讲data存到可变数组中
        [dataArry addObject:data];
        
    }
    
    //记住要转换成不可变数组类型
    NSArray * array = [NSArray arrayWithArray:dataArry];
    NSLog(@"可变数组中存放对象个数:%lu",(unsigned long)[array count]);
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:array forKey:@"allStudent"];
    
    
    //只想存一个人的信息，你可以直接将NSData存入NSUserDefaults中
    NSData *studentData = [NSKeyedArchiver archivedDataWithRootObject:student];
    
    [user setObject:studentData forKey:@"oneStudent"];
    
    [self readObjectFromNSUserDefaults];
}

- (void)readObjectFromNSUserDefaults {
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [user objectForKey:@"oneStudent"];
    
    Students *student = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSLog(@"姓名:%@,学号:%@,性别:%@",student.studentName,student.studentNumber,student.studentSex);
    
    NSArray *studentArry = [NSArray arrayWithArray:[user objectForKey:@"allStudent"]];
    NSLog(@"%@",studentArry);
    
    for (int i = 0; i < 5; ++i) {
        NSData *studentData = [studentArry objectAtIndex:i];
        Students *student = [NSKeyedUnarchiver unarchiveObjectWithData:studentData];
        
        NSLog(@"姓名:%d%@,学号:%@,性别:%@",i,student.studentName,student.studentNumber,student.studentSex);
    }
}

@end
