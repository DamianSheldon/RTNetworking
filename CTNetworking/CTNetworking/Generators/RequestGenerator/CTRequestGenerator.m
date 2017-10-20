//
//  AXRequestGenerator.m
//  RTNetworking
//
//  Created by casa on 14-5-14.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import "CTRequestGenerator.h"
#import "CTSignatureGenerator.h"
#import "CTCommonParamsGenerator.h"
#import "NSDictionary+CTNetworkingMethods.h"
#import "NSObject+CTNetworkingMethods.h"
#import <AFNetworking/AFNetworking.h>
#import "CTService.h"
#import "CTLogger.h"
#import "NSURLRequest+CTNetworkingMethods.h"
#import "CTNetworkingConfigurationManager.h"
@interface CTRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation CTRequestGenerator
#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static CTRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
       
        sharedInstance = [[CTRequestGenerator alloc] init];
    });
    return sharedInstance;
}

- (NSURLRequest *)generateGETRequestWithServiceClass:(Class)serviceClass requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    CTService *service = [serviceClass new];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:requestParams error:NULL];
    request.requestParams = requestParams;
//    if ([CTAppContext sharedInstance].accessToken) {
//        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
//    }
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceClass:(Class)serviceClass requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    CTService *service = [serviceClass new];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
//    if ([CTAppContext sharedInstance].accessToken) {
//        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
//    }
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generatePutRequestWithServiceClass:(Class)serviceClass requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    CTService *service = [serviceClass new];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
//    if ([CTAppContext sharedInstance].accessToken) {
//        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
//    }
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generateDeleteRequestWithServiceClass:(Class)serviceClass requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    CTService *service = [serviceClass new];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
//    if ([CTAppContext sharedInstance].accessToken) {
//        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
//    }
    request.requestParams = requestParams;
    return request;
}

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = [CTNetworkingConfigurationManager sharedInstance].apiNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}
@end
