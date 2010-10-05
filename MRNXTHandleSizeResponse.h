//
//  MRNXTHandleSizeResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTResponse.h"

@interface MRNXTHandleSizeResponse : MRNXTResponse {
  @private
	uint8_t _handle;
	uint32_t _size;
}

@property (readonly) uint8_t handle;
@property (readonly) uint32_t size;

@end
