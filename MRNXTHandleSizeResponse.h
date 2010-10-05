//
//  MRNXTHandleSizeResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTHandleResponse.h"

@interface MRNXTHandleSizeResponse : MRNXTHandleResponse {
  @private
	uint16_t _size;
}

@property (readonly) uint16_t size;

@end
