
#import "LoginVC.h"
#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <AFNetworking.h>
#import <Availability.h>
#import <AFHTTPSessionManager.h>
#import "HttpServiceHealper.h"


@interface LoginVC ()
{
 
}
@end

@implementation LoginVC

#define _AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_ 1



- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}
- (IBAction)ActionLClick:(id)sender {
  
}

- (IBAction)ActionLogin:(id)sender {
  
  
  // /UI/api/Authentication/Login
  
  NSString *strUsername = self.txtloginname.text ;
  NSString *strPassword = self.txtpassword.text;
  NSString *strServrIp = self.txtserverIP.text;
  
  NSString *mPortalBase = [NSString stringWithFormat:@"%@%@",@"http://",strServrIp];
  NSString *loginEndpoint = @"/UI/api/Authentication/Login";

  NSString *urlString = [NSString stringWithFormat:@"%@%@",mPortalBase,loginEndpoint];

  NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
  [parameters setValue:strUsername forKey:@"loginname"];
  [parameters setValue:strPassword forKey:@"password"];


  HttpServiceHealper *service = [HttpServiceHealper new];
  //NSDictionary *dictResponse = [service dologin:parameters withApiURL:urlString];


 // NSDictionary *dictResponseToekn = [service accountSummerywithToken:[dictResponse valueForKey:@"antiForgeryToken"]];

//NSString *string = [[NSString alloc] initWithData:dictResponseToekn encoding:NSUTF8StringEncoding];
//NSLog(@"str: %@", string);
//NSString *path = [[self applicationDocumentsDirectory].path
//stringByAppendingPathComponent:@"index.js"];
//[string writeToFile:path atomically:YES
//encoding:NSUTF8StringEncoding error:nil];


//NSURL *fileURL = [[NSURL alloc] initWithString:path];

//AppDelegate *appDelegate = (AppDelegate*)(UIApplication.sharedApplication.delegate);
//[appDelegate gotoReactNativePage:fileURL];








  
  /*AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
  manager.requestSerializer = [AFHTTPRequestSerializer serializer];
  // [manager POST:uriString parameters:parameters success:^(AFHTTPRequestOperation
  [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
   // printf("%s", responseObject);
  
    [self accountSummerywithToken:[responseObject valueForKey:@"antiForgeryToken"] ];
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //  responseAndErr(Nil, error);u
    NSLog(@"Error: %@", [error description]);
    
  }];*/
  
  
  
  

  
  
  /* RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
   RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
   moduleName:@"ArchitectReactNative"
   initialProperties:nil];
   
   rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
   
   AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
   
   appDelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   UIViewController *rootViewController = [UIViewController new];
   rootViewController.view = rootView;
   appDelegate.window.rootViewController = rootViewController;
   [appDelegate.window makeKeyAndVisible];*/
}

- (void)viewDidLoad {
  [super viewDidLoad];




  // Do any additional setup after loading the view.
}
- (IBAction)devMode:(id)sender {
  self.btnenabledevMode.selected = !self.btnenabledevMode.selected;
}

- (IBAction)downloadBundle:(id)sender {
  self.btnDownloadbundel.selected = !self.btnDownloadbundel.selected;
}
-(void)accountSummerywithToken:(NSString *)strToken {
  
  
      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];

      [manager.requestSerializer setValue:strToken forHTTPHeaderField:@"X-CSRF-TOKEN"];
      [manager.requestSerializer setValue:@"Mobile IOS 18.1;Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebLit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1" forHTTPHeaderField:@"User-Agent"];
  
  
      [manager GET:@"http://192.168.1.48/UI/api/Native/Config?pageName=Accounts%2FAccountSummary"
        parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
          NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
          NSLog(@"str: %@", string);
          NSString *path = [[self applicationDocumentsDirectory].path
                            stringByAppendingPathComponent:@"index.js"];
          [string writeToFile:path atomically:YES
                         encoding:NSUTF8StringEncoding error:nil];
          

          NSURL *fileURL = [[NSURL alloc] initWithString:path];
          
          AppDelegate *appDelegate = (AppDelegate*)(UIApplication.sharedApplication.delegate);
          [appDelegate gotoReactNativePage:fileURL];
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
      }];
  
  
  //NSURL *url2 = @"http://192.168.1.48/UI/api/Native/Config?pageName=Accounts%2FAccountSummary";
//  NSURLSession *session = [NSURLSession sharedSession];
//
//  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url2];
//
//  [request setHTTPMethod:@"GET"];
//
//  [request setValue:strToken forHTTPHeaderField:@"X-CSRF-TOKEN"];
//  [request setValue:@"Mobile IOS 18.1; Mozilla5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1" forHTTPHeaderField:@"User-Agent"];
//
//  ///[request GET:@"http://192.168.1.48/UI/api/Native/Config?pageName=Accounts%2FAccountSummary" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//     NSLog(@"Error: %@", error);
//    }];
//
  
  
}

- (NSURL *)applicationDocumentsDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                 inDomains:NSUserDomainMask] lastObject];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
