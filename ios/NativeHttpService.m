#import "NativeHttpService.h"
#import "HttpServiceHealper.h"



@implementation NativeHttpService
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(get: (NSString*)requestURL: (NSString*)requestToken resolver:(RCTPromiseResolveBlock)resolve
              rejecter:(RCTPromiseRejectBlock)reject )
{
  [HttpServiceHealper get:requestToken withURL:requestURL usingBlock:^(NSString *error, NSString *response) {
   
    
    if ([response length] > 0) {
      resolve(response);
    } else {
      //reject(@"error", @"error description",@[@"Error"]);
    }
    //callback(@[response]);
  }];
}


/*RCT_EXPORT_METHOD(isdebug: resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
  BOOL isDebug = [[NSUserDefaults standardUserDefaults] boolForKey:@"davMode"];
  if (isDebug) {
    resolve([NSNumber numberWithBool:isDebug]);
  } else {
    reject(@"error", @"error description",@[@"Error"]);
  }
  }*/
RCT_REMAP_METHOD(isdebug, findEventsWithResolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
  NSString *isDebug = [[NSUserDefaults standardUserDefaults] valueForKey:@"devMode"];
  if ([isDebug length] > 0) {
    if ([isDebug isEqualToString:@"yes"]) {
          resolve([NSNumber numberWithBool:true]);
    }else{
          resolve([NSNumber numberWithBool:false]);
    }

  } else {
    reject(@"error", @"error description",@[@"Error"]);
  }
}
//[self dismissViewControllerAnimated:YES completion:nil];



RCT_EXPORT_METHOD(getName:(RCTResponseSenderBlock) callback)
{
  callback(@[@"NativeHttpService"]);
}




@end
