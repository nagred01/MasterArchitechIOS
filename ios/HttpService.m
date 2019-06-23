#import "HttpService.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>


//NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"baseURL"];
//bool isdav = [[NSUserDefaults standardUserDefaults] valueForKey:@"davMode"];
//bool isbundel = [[NSUserDefaults standardUserDefaults] valueForKey:@"bundel"];

NSString *strUserAgent = @"Mobile IOS 18.1;Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebLit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1";

@implementation HttpService

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
  
  
  NSString *strBaseURL = [NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"baseURL"]];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
  [manager.requestSerializer setValue:strToken forHTTPHeaderField:@"X-CSRF-TOKEN"];
  [manager.requestSerializer setValue:strUserAgent forHTTPHeaderField:@"User-Agent"];
  
  
  [manager GET:[NSString stringWithFormat:@"%@%@",strBaseURL,@"/UI/api/Native/Config?pageName=Accounts%2FAccountSummary"]
    parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //NSLog(@"JSON: %@", responseObject);
      
      NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
      
      // NSLog(@"%@",responseObject);
      block(@"",string);
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      NSLog(@"Error: %@", error);
    }];
  
  
}

+(void)get:(NSString *)strToken withURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSString *response))block {
  
  
  NSString *strBaseURL = [NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"baseURL"]];
  strBaseURL = [strBaseURL stringByAppendingString:strURL];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
  
  [manager.requestSerializer setValue:strUserAgent forHTTPHeaderField:@"User-Agent"];
  NSString *strLoginToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginToken"];
  [manager.requestSerializer setValue:strLoginToken forHTTPHeaderField:@"X-CSRF-TOKEN"];
  if ([strToken length]>0) {
    [manager.requestSerializer setValue:strToken forHTTPHeaderField:@"X-Request-Token"];
  }
  
  
  
  [manager GET:strBaseURL
    parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //NSLog(@"JSON: %@", responseObject);
      
      NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
      
      // NSLog(@"%@",responseObject);
      block(@"",string);
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      NSLog(@"Error: %@", error);
    }];
  
}


+(void)post:(NSString *)strToken withURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSDictionary *response))block {
  
  
  NSString *strBaseURL = [NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"baseURL"]];
  strBaseURL = [strBaseURL stringByAppendingString:strURL];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
  [manager.requestSerializer setValue:strToken forHTTPHeaderField:@"X-CSRF-TOKEN"];
  [manager.requestSerializer setValue:strUserAgent forHTTPHeaderField:@"User-Agent"];
  NSString *strLoginToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginToken"];
  if ([strLoginToken length]>0) {
    [manager.requestSerializer setValue:strLoginToken forHTTPHeaderField:@"X-Request-Token"];
  }
  
  [manager POST:strBaseURL
     parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       //NSLog(@"JSON: %@", responseObject);
       
       // NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
       
       // NSLog(@"%@",responseObject);
       block(@"",responseObject);
       
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"Error: %@", error);
     }];
  
}

@end
