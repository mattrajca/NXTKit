//
//  NSMutableData+NXT.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

@interface NSMutableData (NXT)

+ (instancetype)dataWithNXTFilename:(NSString *)filename;

- (void)mr_appendNXTFilename:(NSString *)filename;

@end
