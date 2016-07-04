// NSString+Additions.h
#import <Foundation/Foundation.h>

@interface NSString (Additions)
-(BOOL) isIn: (NSString *) strings, ... NS_REQUIRES_NIL_TERMINATION;
-(NSString *)camelcaseString;
-(NSString *)capitalizeFirstLetterString;
-(NSString*) md5;
-(NSString*) sha1;
-(NSString*) sha2WithDigestLength:(int) length;
-(NSString*) encrypt;
-(NSString*) encryptWithSalt:(NSString*) salt;
-(NSDate*) dateValue;
-(NSString*) urlEncode;
-(NSString*) urlDecode;
-(NSString*) sqlString;//replace single quote with two singe quotes as sinle quote is a escape character in SQL
@end

@interface NSNumber (X)

-(NSString*) sqlString;
@end