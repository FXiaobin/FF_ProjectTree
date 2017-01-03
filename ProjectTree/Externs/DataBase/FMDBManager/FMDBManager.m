//
//  FMDBManager.m
//  数据持久化
//
//  Created by lovepinyao on 16/9/21.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "DBDataModel.h"

@interface FMDBManager ()

@property (nonatomic,strong) FMDatabase *dataBase;

@end

@implementation FMDBManager

+ (FMDBManager *)shareManager{
    static FMDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (BOOL)createDataBaseWithPathName:(NSString *)pathName{
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:pathName];
    self.dataBase = [[FMDatabase alloc] initWithPath:path];
    NSLog(@"-- paht = %@",path);
    BOOL ret = NO;
    if (self.dataBase) {
        //NSLog(@"--- 创建成功 ---");
        ret = YES;
    }
    return ret;
}

- (BOOL)createTableWithTable:(NSString *)tableName{
    
    [self.dataBase open];
    
    if ([self.dataBase tableExists:tableName]) {
        NSLog(@"---- 此表已存在 ---");
        return NO;
    }
    
    NSString *tableStr = [NSString stringWithFormat:@"create table %@(uid int, name text, sex text, age int, score float, type text)",tableName];
    BOOL ret = [self.dataBase executeUpdate:tableStr];
    if (ret) {
        //NSLog(@"--- 建表成功 ----");
    }
    
    [self.dataBase close];
    
    return ret;
}

- (BOOL)insertTableWithTable:(NSString *)tableName dataModel:(DBDataModel *)model{
    BOOL ret = NO;
    [self.dataBase open];
    
    if ([self.dataBase tableExists:tableName]) {
        
        NSString *insertStr = [NSString stringWithFormat:@"insert into %@(uid , name , sex , age , score , type ) values (?, ?, ?, ?, ?, ?)", tableName];
        ret = [self.dataBase executeUpdate:insertStr, @(model.uid), model.name, model.sex, @(model.age), @(model.score), model.type];
        if (ret) {
            NSLog(@"---- 插入数据成功 ---");
        }
    }
    [self.dataBase close];
    
    return ret;
}

- (BOOL)deleteDataWithTable:(NSString *)tableName model:(DBDataModel *)model{
  
    [self.dataBase open];
    
    NSString *queryCondition = [NSString stringWithFormat:@"delete from %@ where uid = ?",tableName];
    BOOL ret = [self.dataBase executeUpdate:queryCondition, @(model.uid)
      ];
    
    [self.dataBase close];
    
    return ret;
}

- (BOOL)updateDataWithTable:(NSString *)tableName uid:(NSInteger)uid column:(NSString *)column value:(id)value{
    [self.dataBase open];
    
    NSString *queryCondition = [NSString stringWithFormat:@"update %@ set %@ = ? where uid = ?",tableName, column];
    BOOL ret = [self.dataBase executeUpdate:queryCondition, value, @(uid)];
    
    [self.dataBase close];
    
    return ret;
}

- (NSArray *)queryDataWithTable:(NSString *)tableName type:(NSString *)type{
    [self.dataBase open];
    
    NSMutableArray *array = [NSMutableArray array];
    NSString *queryCondition = [NSString stringWithFormat:@"select * from %@",tableName];
    FMResultSet *resultSet = [self.dataBase executeQuery:queryCondition];
    
    //多个条件查询语句：@"select * from student1 where type = ? and uid = ?"; 可以一直and下去
    if (type && type.length) {
        queryCondition = [NSString stringWithFormat:@"select * from %@ where type = ?",tableName];
        resultSet = [self.dataBase executeQuery:queryCondition, type];
    }
    
    while (resultSet.next) {
        DBDataModel *model = [[DBDataModel alloc] init];
        model.uid = [resultSet intForColumn:@"uid"];
        model.name = [resultSet stringForColumn:@"name"];
        model.sex = [resultSet stringForColumn:@"sex"];
        model.age = [resultSet intForColumn:@"age"];
        model.score = [resultSet doubleForColumn:@"score"];
        model.type = [resultSet stringForColumn:@"type"];
        
        [array addObject:model];
    }
    
    [self.dataBase close];
    
    return array;
}

- (NSArray *)queryDataWithTable:(NSString *)tableName column:(NSString *)column orderByDESC:(BOOL)isDESC{
    [self.dataBase open];
    
    NSMutableArray *array = [NSMutableArray array];
    NSString *queryCondition = [NSString stringWithFormat:@"select * from %@",tableName];
    FMResultSet *resultSet = [self.dataBase executeQuery:queryCondition];
    
    if (column && column.length) {
        if (isDESC) {
            queryCondition = [NSString stringWithFormat:@"select * from %@ order by %@ desc",tableName, column];
            resultSet = [self.dataBase executeQuery:queryCondition];
        }else{
            queryCondition = [NSString stringWithFormat:@"select * from %@ order by %@ asc",tableName, column];
            resultSet = [self.dataBase executeQuery:queryCondition];
        }
    }
   
    while (resultSet.next) {
        DBDataModel *model = [[DBDataModel alloc] init];
        model.uid = [resultSet intForColumn:@"uid"];
        model.name = [resultSet stringForColumn:@"name"];
        model.sex = [resultSet stringForColumn:@"sex"];
        model.age = [resultSet intForColumn:@"age"];
        model.score = [resultSet doubleForColumn:@"score"];
        model.type = [resultSet stringForColumn:@"type"];
        
        [array addObject:model];
    }
    
    [self.dataBase close];
    
    return array;
}

@end
