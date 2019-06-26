
#import <Foundation/Foundation.h>

@interface Portal : NSObject{
//  NSString *strModuleBundle;
//  NSString *strPortalBundle;
}
//@property(nonatomic,retain) NSString *strModuleBundle;
//@property(nonatomic,retain) NSString *strPortalBundle;

+(NSString *) getModuleBundle;
+(NSString *) getPortalbundle;
+(void)setModuleBundle:(void(^)(NSString *error))block;
+(void)setPortalbundle:(void(^)(NSString *error))block;

+(void)doExecute:(void(^)(NSString *error))block;




@end


