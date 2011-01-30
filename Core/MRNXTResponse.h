//
//  MRNXTResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTConstants.h"

@interface MRNXTResponse : NSObject {
  @private
	NXTStatus _status;
}

@property (readonly) NXTStatus status;

- (id)initWithData:(NSData *)data; // designated initializer

- (void)parseBodyData:(NSData *)data;

@end
