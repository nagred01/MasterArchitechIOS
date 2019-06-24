#import "HttpServiceHealper.h"



//NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"baseURL"];
//bool isdav = [[NSUserDefaults standardUserDefaults] valueForKey:@"davMode"];
//bool isbundel = [[NSUserDefaults standardUserDefaults] valueForKey:@"bundel"];

NSString *strUserAgent = @"Mobile IOS 18.1;Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebLit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1";

@implementation HttpServiceHealper

+(void)dologin:(NSDictionary *)dictParameter withApiURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSDictionary *response))block {
//  NSString *loginEndpoint = @"/UI/api/Authentication/Login";
  
  
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

+(void) portalLogin:(NSDictionary *)dictParameter usingBlock:(void(^)(NSString *error,NSDictionary *response))block{
  NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
  NSString *mPortalBase = [NSString stringWithFormat:@"%@%@",@"http://",[defaults objectForKey:@"baseURL"]];
  
  NSString *loginEndpoint = @"/UI/api/Authentication/Login";
  NSString *urlString = [NSString stringWithFormat:@"%@%@",mPortalBase,loginEndpoint];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
  manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  
  [manager POST:urlString parameters:dictParameter success:^(AFHTTPRequestOperation   *operation, id  responseObject) {
    if ([responseObject count] > 0) {
      
      [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"antiForgeryToken"] forKey:@"loginToken"];
      [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
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

+(NSString *)readResponce:(id)responceObj{
  NSString *strResponce = [[NSString alloc] initWithData:responceObj encoding:NSUTF8StringEncoding];
  return strResponce;
}
+(void)getPoratal:(NSString *)strToken withURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSString *response))block{
  AFHTTPRequestOperationManager *manager = [self getHttpConnection:strToken withURL:strURL];
  NSString *strBaseURL = [NSString stringWithFormat:@"http://%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"baseURL"]];
  strBaseURL = [strBaseURL stringByAppendingString:strURL];
  [manager GET:strBaseURL
    parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      
      NSString *string = [self readResponce:responseObject];
      block(@"",string);
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      NSLog(@"Error: %@", error);
    }];
  
}
+(AFHTTPRequestOperationManager *)getHttpConnection:(NSString *)strToken withURL:(NSString *)strURL {
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
  
  return manager;
  
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
