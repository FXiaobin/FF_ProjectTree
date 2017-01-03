//
//  FMDBManager.h
//  数据持久化
//
//  Created by lovepinyao on 16/9/21.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DBDataModel;

@interface FMDBManager : NSObject

///初始化
+ (FMDBManager *)shareManager;

///创建数据库
- (BOOL)createDataBaseWithPathName:(NSString *)pathName;

///创建表
- (BOOL)createTableWithTable:(NSString *)tableName;

///插入数据
- (BOOL)insertTableWithTable:(NSString *)tableName dataModel:(DBDataModel *)model;

///删除数据
- (BOOL)deleteDataWithTable:(NSString *)tableName model:(DBDataModel *)model;

///更新数据
- (BOOL)updateDataWithTable:(NSString *)tableName uid:(NSInteger)uid column:(NSString *)column value:(id)value;

///读取数据
- (NSArray *)queryDataWithTable:(NSString *)tableName type:(NSString *)type;

///按某个条件升序或降序读取数据（当column不存在的时候，默认是按表顺序从上往下读取的）
- (NSArray *)queryDataWithTable:(NSString *)tableName column:(NSString *)column orderByDESC:(BOOL)isDESC;

@end
