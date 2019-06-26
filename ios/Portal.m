
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
+(void)setModuleBundle:(void(^)(NSString *error))block{
  NSString *strUrl = @"/UI/api/Native/Config?pageName=Accounts%2FAccountSummary";
  [HttpServiceHealper getPoratal:NULL withURL:strUrl usingBlock:^(NSString *error, NSString *response) {
    //if (![response isEqualToString:@""]) {
      strModuleBundle = response;
      block(@"No");
       // }
  }];
}
+(void)setPortalbundle:(void(^)(NSString *error))block{
  NSString *strUrl = @"/UI/api/Native/Bundle?platform=ios";
  [HttpServiceHealper getPoratal:NULL withURL:strUrl usingBlock:^(NSString *error, NSString *response) {
   // if (![response isEqualToString:@""]) {
      strPortalBundle = response;
      block(@"No");
    //}
  }];
}
+(void)doExecute:(void(^)(NSString *error))block{
  
  dispatch_group_t group = dispatch_group_create();
  dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
    [self setPortalbundle:^(NSString *error) {
      [self setModuleBundle:^(NSString *error) {
        block(@"");
      }];
    }];
  });
  
 // dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
 //   [self setModuleBundle];
 // });
}


@end
