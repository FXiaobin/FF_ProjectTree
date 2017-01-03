//
//  DBDataModel.h
//  数据持久化
//
//  Created by lovepinyao on 16/9/21.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBDataModel : NSObject

@property (nonatomic,assign) NSInteger uid;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *sex;

@property (nonatomic,assign) NSInteger age;

@property (nonatomic,assign) float score;

@property (nonatomic,strong) NSString *type;

@end
