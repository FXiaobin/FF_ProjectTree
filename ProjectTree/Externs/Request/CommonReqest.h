//
//  CommonReqest.h
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^handleCompleteBlock)(id responseObject, NSError *error);

@interface CommonReqest : NSObject

- (void)productDeleteRequestWithCompleteBlock:(handleCompleteBlock)completeBlock;

- (void)orderCompleteRequestWithCompleteBlock:(handleCompleteBlock)completeBlock;

@end
