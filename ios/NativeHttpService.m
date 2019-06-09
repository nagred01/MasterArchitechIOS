//
//  NativeHttpService.m
//  NativeComponent
//
//  Created by Hiren Vaghela on 08/06/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "NativeHttpService.h"
#import "HttpServiceHealper.h"



@implementation NativeHttpService
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(get: (NSString*)requestURL: (NSString*)requestToken  : (RCTResponseSenderBlock) callback)
{
  [HttpServiceHealper get:requestToken withURL:requestURL usingBlock:^(NSString *error, NSString *response) {
    callback(@[response]);
  }];
  
//  callback(@[requestURL]);
  //  callback(@[requestToken]);
}

RCT_EXPORT_METHOD(isdebug: (RCTResponseSenderBlock) callback)
{ 
  callback(@[@false]);
}

RCT_EXPORT_METHOD(getName:(RCTResponseSenderBlock) callback)
{
  callback(@[@"NativeHttpService"]);
}




@end
