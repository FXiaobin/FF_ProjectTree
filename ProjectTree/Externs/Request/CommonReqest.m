//
//  CommonReqest.m
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#import "CommonReqest.h"
#import "FXBNetManager.h"
#import "SVProgressHUD.h"

@implementation CommonReqest

-(void)productDeleteRequestWithCompleteBlock:(handleCompleteBlock)completeBlock{
    
    //FXBNetManager *manager = [FXBNetManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@", SEVERY_API,ProductDelete];
    [FXBNetManager POST:url parameters:@{} success:^(id responseObject, NSError *error) {
        
        NSNumber *code = responseObject[@"code"];
        if (code.integerValue == 200) {
            NSString *msg = responseObject[@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
        }
        completeBlock(responseObject, error);
        
    } failure:^(id responseObject, NSError *error) {
        completeBlock(responseObject, error);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
    
}

- (void)orderCompleteRequestWithCompleteBlock:(handleCompleteBlock)completeBlock{
    
    
}

@end
