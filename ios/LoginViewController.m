#import "LoginViewController.h"
#import "AppDelegate.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <AFNetworking.h>
#import <Availability.h>
#import <AFHTTPSessionManager.h>
#import "HttpServiceHealper.h"

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

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
 
  NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
  [defaults setObject:strServrIp forKey:@"baseURL"];
  [defaults synchronize];
  
  NSString *mPortalBase = [NSString stringWithFormat:@"%@%@",@"http://",strServrIp];
  NSString *loginEndpoint = @"/UI/api/Authentication/Login";
  
  NSString *urlString = [NSString stringWithFormat:@"%@%@",mPortalBase,loginEndpoint];
  
  NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
  [parameters setValue:strUsername forKey:@"loginname"];
  [parameters setValue:strPassword forKey:@"password"];
  
  [HttpServiceHealper dologin:parameters withApiURL:urlString usingBlock:^(NSString *error, NSDictionary *response) {
    
    if ([response count] > 0) {
    
      [[NSUserDefaults standardUserDefaults] setObject:[response valueForKey:@"antiForgeryToken"] forKey:@"loginToken"];
      
      [HttpServiceHealper accountSummerywithToken:[response valueForKey:@"antiForgeryToken"] usingBlock:^(NSString *error, NSString *responsstr) {
        
        if ([responsstr length] > 0) {
          
          NSString *string = responsstr;
          NSLog(@"str: %@", string);
          NSString *path = [[self applicationDocumentsDirectory].path
                            stringByAppendingPathComponent:@"index.js"];
          [string writeToFile:path atomically:YES
                     encoding:NSUTF8StringEncoding error:nil];
          
          
          NSURL *fileURL = [[NSURL alloc] initWithString:path];
          
          AppDelegate *appDelegate = (AppDelegate*)(UIApplication.sharedApplication.delegate);
          [appDelegate gotoReactNativePage:fileURL];
        }
        
      }];
    }
  }];
 
  
  
  
  
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
  self.txtloginname.delegate = self;
  self.txtpassword.delegate = self;
  self.txtserverIP.delegate = self;
  NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
  [defaults setObject:@"no" forKey:@"devMode"];
  [defaults setObject:@"no" forKey:@"bundle"];
  [defaults synchronize];
  
 

    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  [textField resignFirstResponder];
  return YES;
}
- (IBAction)devMode:(UIButton *)sender {
  self.btnenabledevMode.selected = !self.btnenabledevMode.selected;
  NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
  
  if(sender.isSelected) {
    [sender setImage:[UIImage imageNamed:@"check-mark"] forState:UIControlStateNormal];
  
    [defaults setObject:@"yes" forKey:@"devMode"];
  }else {
    [sender setImage:[UIImage imageNamed:@"uncheck-mark"] forState:UIControlStateNormal];
    
    [defaults setObject:@"no" forKey:@"devMode"];
  }
  [defaults synchronize];

}

- (IBAction)downloadBundle:(UIButton *)sender {
  self.btnDownloadbundel.selected = !self.btnDownloadbundel.selected;
  NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
  if(sender.isSelected) {
    [sender setImage:[UIImage imageNamed:@"check-mark"] forState:UIControlStateNormal];
 
    [defaults setObject:@"yes" forKey:@"bundle"];
  }else {
    [sender setImage:[UIImage imageNamed:@"uncheck-mark"] forState:UIControlStateNormal];
  
        [defaults setObject:@"no" forKey:@"bundle"];
  }
  [defaults synchronize];
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
