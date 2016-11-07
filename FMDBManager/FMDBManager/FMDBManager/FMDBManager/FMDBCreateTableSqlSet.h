//
//  FMDBSqlSet.h
//  MVVMTest
//
//  Created by Jacky on 16/11/7.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>

//每次变化时 随着表结构
@interface FMDBCreateTableSqlSet : NSObject

//初次使用app时 建立version表
+(NSArray *)getInsertVersionArray;

//创建所有的表结构
+(NSArray *)getFirstCreateTableSqlInTheArray;

//之后每一次建表变化 都通过建立一个新的建表数组返回 到FMDBManager中执行
+(NSArray *)getSecondSqlsInTheArray;


@end
