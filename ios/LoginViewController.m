#import "LoginViewController.h"
#import "AppDelegate.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <AFNetworking.h>
#import <Availability.h>
#import <AFHTTPSessionManager.h>
#import "HttpServiceHealper.h"
#import "Portal.h"
#import "IOHelper.h"

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
-(void)saveFile{
  if (self.btnDownloadbundel.isSelected) {
    NSString *strPortal = [Portal getPortalbundle] ;
    NSMutableString *strToWritePortal = [[NSMutableString alloc] initWithString:strPortal];
    [IOHelper WriteToStringFile:[strToWritePortal mutableCopy] withName:@"ios.bundle"];
  }
  
  NSString *strModule = [Portal getModuleBundle] ;
  NSMutableString *strToWriteModule = [[NSMutableString alloc] initWithString:strModule];
  [IOHelper WriteToStringFile:[strToWriteModule mutableCopy] withName:@"module.bundle"];
  
  NSString *strPortal = [IOHelper readFromFile:@"ios.bundle"];
  NSMutableString *strStich = [[NSMutableString alloc] initWithString:strPortal];
  [strStich appendString:strModule];
  
  [IOHelper WriteToStringFile:[strStich mutableCopy] withName:@"index.ios.bundle"];
}
- (IBAction)ActionLClick:(id)sender {
  
}

-(void)finalStep{
  NSString *string;
  NSMutableString *strBundle;
  if(self.btnenabledevMode.isSelected){
    strBundle = [[NSMutableString alloc] initWithString:[IOHelper readFromFile:(@"index")]];
  }else{
    strBundle = [[NSMutableString alloc] initWithString:[IOHelper readFromFile:(@"index.ios.bundle")]];
  }
  NSString *path = [[self applicationDocumentsDirectory].path
                    stringByAppendingPathComponent:@"index.js"];
  [string writeToFile:path atomically:YES
             encoding:NSUTF8StringEncoding error:nil];
  
  
  NSURL *fileURL = [[NSURL alloc] initWithString:path];
  
  AppDelegate *appDelegate = (AppDelegate*)(UIApplication.sharedApplication.delegate);
  [appDelegate gotoReactNativePage:fileURL];
}

- (IBAction)ActionLogin:(id)sender {
  
  NSString *strUsername = self.txtloginname.text ;
  NSString *strPassword = self.txtpassword.text;
  NSString *strServrIp = self.txtserverIP.text;
 
  NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
  [defaults setObject:strServrIp forKey:@"baseURL"];
  [defaults synchronize];
  
//  NSString *mPortalBase = [NSString stringWithFormat:@"%@%@",@"http://",strServrIp];
//  NSString *loginEndpoint = @"/UI/api/Authentication/Login";
//
//  NSString *urlString = [NSString stringWithFormat:@"%@%@",mPortalBase,loginEndpoint];
  
  NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
  [parameters setValue:strUsername forKey:@"loginname"];
  [parameters setValue:strPassword forKey:@"password"];
  
  [HttpServiceHealper portalLogin:parameters usingBlock:^(NSString *error, NSDictionary *response) {
    if (self.btnenabledevMode.isSelected){
      [self finalStep];
    }else{
      [Portal doExecute];
      [self saveFile];
      [self finalStep];
    }
    
    
  }];
  
  
  
//  [HttpServiceHealper dologin:parameters withApiURL:urlString usingBlock:^(NSString *error, NSDictionary *response){
//
//    if ([response count] > 0) {
//
//      [[NSUserDefaults standardUserDefaults] setObject:[response valueForKey:@"antiForgeryToken"] forKey:@"loginToken"];
//      [[NSUserDefaults standardUserDefaults] synchronize];
//      [HttpServiceHealper accountSummerywithToken:[response valueForKey:@"antiForgeryToken"] usingBlock:^(NSString *error, NSString *responsstr) {
//
//        if ([responsstr length] > 0) {
//
//          NSString *string = responsstr;
//          NSLog(@"str: %@", string);
//          NSString *path = [[self applicationDocumentsDirectory].path
//                            stringByAppendingPathComponent:@"index.js"];
//          [string writeToFile:path atomically:YES
//                     encoding:NSUTF8StringEncoding error:nil];
//
//
//          NSURL *fileURL = [[NSURL alloc] initWithString:path];
//
//          AppDelegate *appDelegate = (AppDelegate*)(UIApplication.sharedApplication.delegate);
//          [appDelegate gotoReactNativePage:fileURL];
//        }
//
//      }];
//    }
//  }];
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

@end
