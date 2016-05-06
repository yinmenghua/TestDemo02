//
//  NetRequestClass.h
//  ITMVVMDemo
//
//  Created by Box on 16/4/5.
//  Copyright © 2016年 Box. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestClass : NSObject

#pragma mark 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl;
+ (void) netWorkReachabilityWithURLString:(NSString *) strUrl
                               completion:(NetWorkBlock) netWorkBlock;


#pragma mark GET请求
+ (void) netRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ITFinishedBlock) block;

#pragma mark POST请求
+ (void) netRequestPOSTWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ITFinishedBlock) block;

@end
