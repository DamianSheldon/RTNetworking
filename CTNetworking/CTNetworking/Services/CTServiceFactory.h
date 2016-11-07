//
//  AXServiceFactory.h
//  RTNetworking
//
//  Created by casa on 14-5-12.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTService.h"

@interface CTServiceFactory : NSObject

+ (instancetype)sharedInstance;

- (void)registerService:(Class)service withIdentifier:(NSString *)identifier;

- (CTService<CTServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
