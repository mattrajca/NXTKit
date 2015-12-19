//
//  MRNXTResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTConstants.h"

@interface MRNXTResponse : NSObject

@property (readonly) NXTStatus status;

- (instancetype)initWithData:(NSData *)data; // designated initializer

- (void)parseBodyData:(NSData *)data;

@end
