//
//  GDMapService.h
//  CTNetworking
//
//  Created by casa on 16/4/12.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "CTService.h"

extern NSString * const kBSUserTokenInvalidNotification;
extern NSString * const kBSUserTokenIllegalNotification;

extern NSString * const kBSUserTokenNotificationUserInfoKeyRequestToContinue;
extern NSString * const kBSUserTokenNotificationUserInfoKeyManagerToContinue;

@interface GDMapService : CTService <CTServiceProtocol>

@end
