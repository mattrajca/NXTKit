//
//  MRNXTHandleResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTResponse.h"

@interface MRNXTHandleResponse : MRNXTResponse {
@private
    uint8_t handle;
}

@property (readonly) uint8_t handle;

@end
