//
//  MRNXTDeviceInfoResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTResponse.h"

@interface MRNXTDeviceInfoResponse : MRNXTResponse {
  @private
	NSString *_brickName;
	uint32_t _freeSpace;
}

@property (readonly) NSString *brickName;
@property (readonly) uint32_t freeSpace; // in bytes

@end
