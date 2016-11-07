//
//  AXServiceFactory.m
//  RTNetworking
//
//  Created by casa on 14-5-12.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import "CTServiceFactory.h"
#import "CTService.h"

//#import "GDMapService.h"

/*************************************************************************/

// service name list
//NSString * const kCTServiceGDMapV3 = @"kCTServiceGDMapV3";


@interface CTServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;
@property (nonatomic, strong) NSMutableDictionary *serviceClassStorage;

@end

@implementation CTServiceFactory

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

- (NSMutableDictionary *)serviceClassStorage
{
    if (!_serviceClassStorage) {
        _serviceClassStorage = [[NSMutableDictionary alloc] init];

    }
    return _serviceClassStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static CTServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CTServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (void)registerService:(Class)service withIdentifier:(NSString *)identifier
{
    [self.serviceClassStorage setObject:service forKey:identifier];
}

- (CTService<CTServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier
{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (CTService<CTServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier
{
    Class class = self.serviceClassStorage[identifier];
    
    return [class new];
}

@end
