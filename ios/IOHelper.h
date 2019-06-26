
#import <Foundation/Foundation.h>



@interface IOHelper : NSObject{

}


+(NSString *) GetDocumentDirectory;
+(void)WriteToStringFile:(NSMutableString *)textToWrite withName:(NSString *)fileName;
+(NSString *) readFromFile:(NSString *)fileName;
+(NSString *) setFilename;

@end

