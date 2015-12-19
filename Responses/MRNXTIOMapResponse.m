//
//  MRNXTIOMapResponse.m
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTIOMapResponse.h"

@implementation MRNXTIOMapResponse

@synthesize moduleID, bytesRead, contents;

- (void)parseBodyData:(NSData *)data {
	[data getBytes:&moduleID range:NSMakeRange(0, 4)];
	moduleID = OSSwapLittleToHostInt32(moduleID);
	
	[data getBytes:&bytesRead range:NSMakeRange(4, 2)];
	bytesRead = OSSwapLittleToHostInt16(bytesRead);
	
	contents = [data subdataWithRange:NSMakeRange(6, bytesRead)];
}

@end
