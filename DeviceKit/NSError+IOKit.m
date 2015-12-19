//
//  NSError+IOKit.m
//  DeviceKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "NSError+IOKit.h"

NSString *const IOKitErrorDomain = @"com.MattRajca.DeviceKit.IOKit";

@implementation NSError (IOKit)

+ (id)IOKitErrorWithReturnCode:(IOReturn)code {
	return [[[self class] alloc] initWithDomain:IOKitErrorDomain
											code:code
										userInfo:nil];
}

@end
