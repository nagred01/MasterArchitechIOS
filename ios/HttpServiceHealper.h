//
//  HttpServiceHealper.h
//  ArchitectReactNative
//
//  Created by TCGFiserv2 on 6/7/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <Availability.h>
#import <AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpServiceHealper : NSObject
+(void)dologin:(NSMutableDictionary*)params withAPiURL:(NSString *)apiURL;
 @end

NS_ASSUME_NONNULL_END
