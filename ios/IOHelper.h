//
//  IOHelper.h
//  ArchitectReactNative
//
//  Created by Hiren on 6/21/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface IOHelper : NSObject{

}


+(NSString *) GetDocumentDirectory;
+(void)WriteToStringFile:(NSMutableString *)textToWrite withName:(NSString *)fileName;
+(NSString *) readFromFile:(NSString *)fileName;
+(NSString *) setFilename;

@end

