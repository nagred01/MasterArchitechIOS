#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>

@interface HttpServiceHealper : NSObject

+(void) dologin:(NSDictionary *)dictParameter withApiURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSDictionary *response))block;
+(void) portalLogin:(NSDictionary *)dictParameter usingBlock:(void(^)(NSString *error,NSDictionary *response))block;

+(void)accountSummerywithToken:(NSString *)strToken usingBlock:(void(^)(NSString *error,NSString *response))block;


+(void)get:(NSString *)strToken withURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSString *response))block;
+(void)getPoratal:(NSString *)strToken withURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSString *response))block;
+(AFHTTPRequestOperationManager *)getHttpConnection:(NSString *)strToken withURL:(NSString *)strURL;
+(void)post:(NSString *)strToken withURL:(NSString *)strURL usingBlock:(void(^)(NSString *error,NSDictionary *response))block;

+(NSString *)readResponce:(id)responceObj;
@end
