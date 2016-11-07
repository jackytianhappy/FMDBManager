//
//  FMDBManager.m
//  MVVMTest
//
//  Created by Jacky on 16/11/7.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDBCreateTableSqlSet.h"

static NSString *select_versionInfo = @"select version from t_versionInfo";
static NSString *insert_versionInfo = @"insert into t_versionInfo(version) values(?)";
static NSString *update_versionInfo = @"update t_versionInfo set version = ?";

@implementation FMDBManager

+(FMDatabase *)sharedDatabase{
    static FMDatabase *db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [FMDBManager getDBPath];
        db = [[FMDatabase alloc]initWithPath:path];
    });
    return db;
}

//返回数据库的路径
+(NSString *)getDBPath{
    return  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Demo.sqlite"];
}

//以下负责管理所有的表版本结构 置于初始化文件中
+(void)initDBWithTheVersion{
    int dbVersion = 1;
    if (![FMDBManager isExistDB]) {//不存在数据库
        FMDatabase *db = [FMDBManager sharedDatabase];
        if (![db open]) {
            SHLog(@"数据库创建失败了");
        }else{
            SHLog(@"数据库创建成功, 路径是：%@",[FMDBManager getDBPath]);
        }
        
        //建立所有的表
        [FMDBManager createAllTables]; //这个操作会建立version表
    }
    
    dbVersion = [[FMDBManager getDBVersionInfo] intValue];
    
    switch (dbVersion) {
        case 1:{//第一次安装 版本1.0
            //插入版本号码
            [FMDBManager setDBInfoVersionValueWithString:[NSString stringWithFormat:@"%d",dbVersion+1]];
        }
//        case 2:{
//            FMDatabase *db = [FMDBManager sharedDatabase];
//            if (![db open]) {
//                SHLog(@"数据库创建失败了");
//            }else{
//                BOOL  success = [db executeUpdate:@"ALTER TABLE t_student ADD COLUMN papap varchar(100)"];
//                SHLog(@"%d",success);
//            }
//            [FMDBManager setDBInfoVersionValueWithString:[NSString stringWithFormat:@"%d",dbVersion+1]];
//        }
            
        default:
            break;
    }
}


#pragma mark -private function
//是否存在数据库
+(BOOL)isExistDB{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:[FMDBManager getDBPath]];
}

//执行local的update sql
+(BOOL)executeLocalSql:(NSString *)sqlInfo{
   BOOL success = [[FMDBManager sharedDatabase]executeUpdate:sqlInfo];
    if (!success) {
        SHLog(@"sql---%@--执行失败",sqlInfo);
    }
    return success;
}

//查询版本号
+(NSString *)getDBVersionInfo{
    NSString *version = nil;
    if (![[FMDBManager sharedDatabase] open]) {
        SHLog(@"获取版本信息数据库打开失败");
        return nil;
    }else{
        FMResultSet *resultSet = [[FMDBManager sharedDatabase] executeQuery:select_versionInfo];
        while ([resultSet next]) {
            version = [resultSet stringForColumn:@"version"];
        }
    }
    return version;
}


+(BOOL)setDBInfoVersionValueWithString:(NSString *)versionStr{
    if ([FMDBManager getDBVersionInfo]) {
        //更新版本
        [FMDBManager updateVersionInfoWithString:versionStr];
    }else{
        //插入版本
        [FMDBManager insertVersionInfoWithString:versionStr];
    }
    
    return YES;
}

+(BOOL)updateVersionInfoWithString:(NSString *)versionStr{
    return [[FMDBManager sharedDatabase] executeUpdate:update_versionInfo,versionStr];
}

+(BOOL)insertVersionInfoWithString:(NSString *)versionStr{
    return [[FMDBManager sharedDatabase] executeUpdate:insert_versionInfo,versionStr];
}


+(void)createAllTables{
    for (int i = 0; i< [FMDBCreateTableSqlSet getAllCreateTableSqlInTheArray].count; i++) {
        BOOL success = [[FMDBManager sharedDatabase]executeUpdate:[FMDBCreateTableSqlSet getAllCreateTableSqlInTheArray][i]];
        if (!success) {
            SHLog(@"sql---%@--执行失败",[FMDBCreateTableSqlSet getAllCreateTableSqlInTheArray][i]);
        }
    }
}


@end
