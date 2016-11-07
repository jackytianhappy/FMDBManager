//
//  FMDBManager.h
//  MVVMTest
//
//  Created by Jacky on 16/11/7.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB/FMDB.h"



#ifdef DEBUG
#define SHLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define SHLog(format, ...)
#endif


@interface FMDBManager : NSObject

//返回fmdb实例
+(FMDatabase *)sharedDatabase;

//返回数据库路径
+(NSString *)getDBPath;

//放置在appdelegate中 用于一开始初始化
+(void)initDBWithTheVersion;

@end
