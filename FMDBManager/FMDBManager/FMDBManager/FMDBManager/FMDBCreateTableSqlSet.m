//
//  FMDBSqlSet.m
//  MVVMTest
//
//  Created by Jacky on 16/11/7.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "FMDBCreateTableSqlSet.h"

@implementation FMDBCreateTableSqlSet
+(NSArray *)getInsertVersionArray{
    return @[
             @"create table if not exists t_versionInfo (version text)",//创建版本表 重要
             @"insert into t_versionInfo(version) values(1)",//初始版本号为1
             ];
}

+(NSArray *)getFirstCreateTableSqlInTheArray{ //第一次建表的所有表结构
    return  @[
              @"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY, name text NOT NULL, age integer NOT NULL,sex vachar(100),email varchar(100));"//如
              ];
}

+(NSArray *)getSecondSqlsInTheArray{ //数据库版本二的操作全部放在这里
    return @[
             @"ALTER TABLE t_student ADD COLUMN papap varchar(100)"
             ];
}


@end
