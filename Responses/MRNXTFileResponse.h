//
//  MRNXTFileResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTResponse.h"

@interface MRNXTFileResponse : MRNXTResponse {
  @private
	uint8_t _handle;
	NSString *_filename;
	uint32_t _size;
}

@property (readonly) uint8_t handle;
@property (readonly) NSString *filename;
@property (readonly) uint32_t size;

@end
