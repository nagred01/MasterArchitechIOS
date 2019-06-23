//
//  IOHelper.m
//  ArchitectReactNative
//
//  Created by Hiren on 6/21/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "IOHelper.h"

@interface IOHelper ()

@end

@implementation IOHelper
NSFileManager *fileMgr;
NSString *homeDir;
NSString *filename;
NSString *filepath;

+(NSString *) setFilename{
  filename = @"mytextfile.txt";
  
  return filename;
}

/*
 Get a handle on the directory where to write and read our files. If
 it doesn't exist, it will be created.
 */

+(NSString *)GetDocumentDirectory{
  fileMgr = [NSFileManager defaultManager];
  homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
  
  return homeDir;
}

/*Create a new file*/
+(void)WriteToStringFile:(NSMutableString *)textToWrite withName:(NSString *)fileName{
  filepath = [[NSString alloc] init];
  NSError *err;
  
  filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:fileName];
  
  BOOL ok = [textToWrite writeToFile:filepath atomically:YES encoding:NSUnicodeStringEncoding error:&err];
  
  if (!ok) {
    NSLog(@"Error writing file at %@\n%@",
          filepath, [err localizedFailureReason]);
  }
  
}

/*
 Read the contents from file
 */
+(NSString *) readFromFile:(NSString *)fileName
{
  filepath = [[NSString alloc] init];
  NSError *error;
  filepath = [self.GetDocumentDirectory stringByAppendingPathComponent:fileName];
  NSString *txtInFile = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUnicodeStringEncoding error:&error];
  
  if(!txtInFile)
  {
    NSLog(@"Unable to get text from file. Please try again!!");
  }
  return txtInFile;
}

@end
