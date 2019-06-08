//
//  HttpServiceHealper.m
//  ArchitectReactNative
//
//  Created by Hiren Vaghela on 08/06/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "HttpServiceHealper.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>


@implementation HttpServiceHealper

+(void)dologin:(NSDictionary *)dictParameter withApiURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSDictionary *response))block {
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
  manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  
  [manager POST:strURL parameters:dictParameter success:^(AFHTTPRequestOperation   *operation, id  responseObject) {
    NSLog(@"%@",responseObject);
    block(@"",responseObject);
    
  } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    NSLog(@"Error: %@", [error description]);
    //return nil;
  }];
  
}
+(void)accountSummerywithToken:(NSString *)strToken usingBlock:(void(^)(NSString *error,NSString *response))block {
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
  [manager.requestSerializer setValue:strToken forHTTPHeaderField:@"X-CSRF-TOKEN"];
  [manager.requestSerializer setValue:@"Mobile IOS 18.1;Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebLit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1" forHTTPHeaderField:@"User-Agent"];
  
  
  [manager GET:@"http://192.168.1.48/UI/api/Native/Config?pageName=Accounts%2FAccountSummary"
    parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //NSLog(@"JSON: %@", responseObject);
      
      NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
      
     // NSLog(@"%@",responseObject);
      block(@"",string);
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      NSLog(@"Error: %@", error);
    }];
  
  
}


@end
