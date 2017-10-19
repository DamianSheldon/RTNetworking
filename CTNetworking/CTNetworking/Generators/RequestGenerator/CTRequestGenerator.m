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

    self = [super init];
    [self initialRequestGenerator];
    return self;
}

//
- (void)initialRequestGenerator {
    
    _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
    _httpRequestSerializer.timeoutInterval = [CTNetworkingConfigurationManager sharedInstance].apiNetworkingTimeoutSeconds;
    _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;

}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    return [self generateRequestWithServiceIdentifier:serviceIdentifier requestParams:requestParams methodName:methodName requestWithMethod:@"GET"];
}

- (NSURLRequest *)generatePOSTRequestWithServiceClass:(Class)serviceClass requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    CTService *service = [serviceClass new];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"xxxxxxxx"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([CTAppContext sharedInstance].accessToken) {
        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
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
    if ([CTAppContext sharedInstance].accessToken) {
        [request setValue:[CTAppContext sharedInstance].accessToken forHTTPHeaderField:@"xxxxxxxx"];
    }
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generateDeleteRequestWithServiceClass:(Class)serviceClass requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    CTService *service = [serviceClass new];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, service.apiVersion, methodName];
    
    NSDictionary *totalRequestParams = [self totalRequestParamsByService:service requestParams:requestParams];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:method URLString:urlString parameters:totalRequestParams error:NULL];
    
    if (![method isEqualToString:@"GET"] && [CTNetworkingConfigurationManager sharedInstance].shouldSetParamsInHTTPBodyButGET) {
        request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    }
    
    if ([service.child respondsToSelector:@selector(extraHttpHeadParmasWithMethodName:)]) {
        NSDictionary *dict = [service.child extraHttpHeadParmasWithMethodName:methodName];
        if (dict) {
            [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                [request setValue:obj forHTTPHeaderField:key];
            }];
        }
    }
    
    request.requestParams = totalRequestParams;
    return request;
}

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = [CTNetworkingConfiguration sharedNetworkConfiguration].timeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return [totalRequestParams copy];
}

#pragma mark test

- (void)rest {
    
    //self.httpRequestSerializer = nil;
}

#pragma mark - getters and setters
//- (AFHTTPRequestSerializer *)httpRequestSerializer {
//
//    if (_httpRequestSerializer == nil) {
//        
//        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
//        _httpRequestSerializer.timeoutInterval = [CTNetworkingConfigurationManager sharedInstance].apiNetworkingTimeoutSeconds;
//        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
//    }
// 
//    return _httpRequestSerializer;
//}
@end
