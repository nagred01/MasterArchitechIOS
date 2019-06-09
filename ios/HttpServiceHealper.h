//
//  HttpServiceHealper.h
//  ArchitectReactNative
//
//  Created by Hiren Vaghela on 08/06/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpServiceHealper : NSObject

+(void) dologin:(NSDictionary *)dictParameter withApiURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSDictionary *response))block;

+(void)accountSummerywithToken:(NSString *)strToken usingBlock:(void(^)(NSString *error,NSString *response))block;


+(void)get:(NSString *)strToken withURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSString *response))block;
+(void)post:(NSString *)strToken withURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSDictionary *response))block;


@end
