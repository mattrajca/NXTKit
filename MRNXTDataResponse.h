//
//  MRNXTDataResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTResponse.h"

@interface MRNXTDataResponse : MRNXTResponse {
  @private
	uint8_t _handle;
	uint16_t _bytesRead;
	NSData *_data;
}

@property (readonly) uint8_t handle;
@property (readonly) uint16_t bytesRead;
@property (readonly) NSData *data;

@end
