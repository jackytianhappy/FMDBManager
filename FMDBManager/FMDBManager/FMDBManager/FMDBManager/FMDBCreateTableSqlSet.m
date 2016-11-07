//
//  FMDBSqlSet.m
//  MVVMTest
//
//  Created by Jacky on 16/11/7.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "FMDBCreateTableSqlSet.h"

@implementation FMDBCreateTableSqlSet

+(NSArray *)getAllCreateTableSqlInTheArray{
    return  @[
             @"create table if not exists t_versionInfo (version text)",//创建版本表 重要
             @"insert into t_versionInfo(version) values(1)",//更新版本库的时候插入对应的版本号 请修改
             @"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY, name text NOT NULL, age integer NOT NULL,sex vachar(100),email varchar(100));"//创建demo 表
             
             ];
}

@end
