//
//  AXNetworkingConfiguration.h
//  RTNetworking
//
//  Created by casa on 14-5-13.
//  Copyright (c) 2014年 casatwy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CTAppType) {
    CTAppTypexxx
};

typedef NS_ENUM(NSUInteger, CTURLResponseStatus)
{
    CTURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的CTAPIBaseManager来决定。
    CTURLResponseStatusErrorTimeout,
    CTURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

extern const BOOL kCTShouldCache;
extern const BOOL kCTServiceIsOnline;

//static NSString *CTKeychainServiceName = @"xxxxx";
//static NSString *CTUDIDName = @"xxxx";
//static NSString *CTPasteboardType = @"xxxx";

@interface CTNetworkingConfiguration : NSObject

+ (instancetype)sharedNetworkConfiguration;

@property (nonatomic) NSTimeInterval timeoutSeconds; // Default is 20s
@property (nonatomic) NSTimeInterval cacheOutDateTimeSeconds; // Default is 300s
@property (nonatomic) NSUInteger cacheCountLimit; // Default is 1000

/* NOTE: Configure field for CTUDIDGenerator, must initial before use.
                --->keychainServiceName(Persistent by keychain service)
    UDIDName --|
                --->pasteboardType(Persistent by pasteboard)
 */
@property (nonatomic, copy) NSString *keychainServiceName;
@property (nonatomic, copy) NSString *UDIDName;
@property (nonatomic, copy) NSString *pasteboardType;// A string identifying the representation type of the pasteboard item. This is typically a UTI. eg.public.uft8-plain-text

@end
