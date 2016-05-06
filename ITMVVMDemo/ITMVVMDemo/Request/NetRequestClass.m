//
//  NetRequestClass.m
//  ITMVVMDemo
//
//  Created by Box on 16/4/5.
//  Copyright © 2016年 Box. All rights reserved.
//

#import "NetRequestClass.h"
#import "RequestClient.h"


@implementation NetRequestClass

#pragma mark GET请求
+ (void) netRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ITFinishedBlock) block {
    [[RequestClient sharedRequestInstance] GET:requestURLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        block(responseObject,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(nil,error);
        
        
        
    }];
    
    
}

#pragma mark POST请求
+ (void) netRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                 WithReturnValeuBlock: (ITFinishedBlock) block {
    
    [[RequestClient sharedRequestInstance] POST:requestURLString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        
        
    }];
    
}


#pragma mark 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *)strUrl {
    
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
#if 0
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                break;
        }
    }];
    
    [manager startMonitoring];
    
    
    
    
#else

//    RequestClient *manager = [RequestClient sharedRequestInstance];//[[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
#endif
    
    return netState;
    
}

#pragma mark 监测网络的可链接性2

+ (void) netWorkReachabilityWithURLString:(NSString *) strUrl completion:(NetWorkBlock)netWorkBlock {
    __block BOOL netState = NO;
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
//    RequestClient *manager = [RequestClient sharedRequestInstance];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
        netWorkBlock(netState);
    }];
    
    [manager.reachabilityManager startMonitoring];
}



@end









