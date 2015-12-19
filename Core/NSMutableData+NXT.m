//
//  NSMutableData+NXT.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "NSMutableData+NXT.h"

@implementation NSMutableData (NXT)

+ (instancetype)dataWithNXTFilename:(NSString *)filename {
	NSMutableData *data = [[self alloc] init];
	[data mr_appendNXTFilename:filename];
	
	return data;
}

- (void)mr_appendNXTFilename:(NSString *)filename {
	NSString *fn = filename.length > 19 ? [filename substringToIndex:20] : filename;
	
	[self appendBytes:fn.UTF8String length:20];
}

@end
