#import <UIKit/UIKit.h>
#import <React/RCTBridgeDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController<RCTBridgeDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtloginname;
@property (weak, nonatomic) IBOutlet UITextField *txtpassword;
@property (weak, nonatomic) IBOutlet UITextField *txtserverIP;

@property (weak, nonatomic) IBOutlet UIButton *btnenabledevMode;
@property (weak, nonatomic) IBOutlet UIButton *btnDownloadbundel;
@end

NS_ASSUME_NONNULL_END
