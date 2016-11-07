//
//  CTNetworkingConfiguration.m
//  CTNetworking
//
//  Created by DongMeiliang on 04/11/2016.
//  Copyright © 2016 Long Fan. All rights reserved.
//

#import "CTNetworkingConfiguration.h"

const BOOL kCTShouldCache = YES;
const BOOL kCTServiceIsOnline = NO;

@implementation CTNetworkingConfiguration

+ (instancetype)sharedNetworkConfiguration
{
    static CTNetworkingConfiguration *sSharedNetworkingConfiguration;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sSharedNetworkingConfiguration = [[self alloc] initWithSingleton];
    });
    return sSharedNetworkingConfiguration;
}

- (instancetype)initWithSingleton
{
    self = [super init];
    if (self) {
        _timeoutSeconds = 20.0;
        _cacheOutDateTimeSeconds = 300.0;
        _cacheCountLimit = 1000;
    }
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must instance via sharedNetworkConfiguration" userInfo:nil];
}

@end
