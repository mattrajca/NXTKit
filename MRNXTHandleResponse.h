//
//  MRNXTHandleResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

@interface MRNXTHandleResponse : NSObject {
  @private
	uint8_t _handle;
}

@property (readonly) uint8_t handle;

@end
