//
//  MRNXTOpenReadCommand.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTOpenReadCommand.h"

#import "MRNXTHandleSizeResponse.h"

@implementation MRNXTOpenReadCommand

@synthesize filename;

- (Class)responseClass {
	return [MRNXTHandleSizeResponse class];
}

- (NXTCommandType)type {
	return NXTCommandTypeSystem;
}

- (uint8_t)identifier {
	return 0x80;
}

- (NSData *)data {
	return [NSMutableData dataWithNXTFilename:filename];
}

- (void)dealloc {
	[filename release];
	
	[super dealloc];
}

@end
