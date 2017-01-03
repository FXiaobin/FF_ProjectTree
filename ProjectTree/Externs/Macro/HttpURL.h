//
//  HttpURL.h
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#ifndef HttpURL_h
#define HttpURL_h


//系统会根据当前工程的版本类型（debug、release）来自动判断选择哪个SEVERY_API
#ifdef DEBUG
//Debug状态下的测试API
#define SEVERY_API     @"http://boys.test.companydomain.com/api/"

#else
//Release状态下的线上API
#define SEVERY_API     @"http://www.companydomain.com/api/"

#endif



#define ProductDelete   @"productDeleteRequest"       // 删除某个商品



#endif /* HttpURL_h */
