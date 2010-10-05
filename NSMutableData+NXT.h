//
//  NSMutableData+NXT.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

@interface NSMutableData (NXT)

+ (id)dataWithNXTFilename:(NSString *)filename;

- (void)mr_appendNXTFilename:(NSString *)filename;

@end
