//
//  NSError+IOKit.h
//  DeviceKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

extern NSString *const IOKitErrorDomain;

@interface NSError (IOKit)

+ (id)IOKitErrorWithReturnCode:(IOReturn)code;

@end
