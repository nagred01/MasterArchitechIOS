//
//  Portal.m
//  ArchitectReactNative
//
//  Created by Hiren on 6/21/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "Portal.h"
#import "HttpServiceHealper.h"
@interface Portal (){
  
}

@end
NSString *strModuleBundle;
NSString *strPortalBundle;
@implementation Portal


+(NSString *) getModuleBundle{
  return strModuleBundle;
}
+(NSString *) getPortalbundle{
  return strPortalBundle;
}
+(void)setModuleBundle{
  NSString *strUrl = @"/UI/api/Native/Config?pageName=Accounts%2FAccountSummary";
  [HttpServiceHealper getPoratal:NULL withURL:strUrl usingBlock:^(NSString *error, NSString *response) {
    if (!error) {
      strModuleBundle = response;
    }
  }];
}
+(void)setPortalbundle{
  NSString *strUrl = @"/UI/api/Native/Bundle?platform=ios";
  [HttpServiceHealper getPoratal:NULL withURL:strUrl usingBlock:^(NSString *error, NSString *response) {
    if (!error) {
      strPortalBundle = response;
    }
  }];
}
+(void)doExecute{
  
  dispatch_group_t group = dispatch_group_create();
  dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
    [self setPortalbundle];
  });
  
  dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
    [self setModuleBundle];
  });
}


@end
