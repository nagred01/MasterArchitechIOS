//
//  Portal.h
//  ArchitectReactNative
//
//  Created by Hiren on 6/21/19.
//  Copyright © 2019 Facebook. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Portal : NSObject{
//  NSString *strModuleBundle;
//  NSString *strPortalBundle;
}
//@property(nonatomic,retain) NSString *strModuleBundle;
//@property(nonatomic,retain) NSString *strPortalBundle;

+(NSString *) getModuleBundle;
+(NSString *) getPortalbundle;
+(void)setModuleBundle;
+(void)setPortalbundle;

+(void)doExecute;




@end


