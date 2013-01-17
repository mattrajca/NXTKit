//
//  MRNXTDeviceInfoResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTResponse.h"

@interface MRNXTDeviceInfoResponse : MRNXTResponse {
@private
    NSString *brickName;
    uint32_t freeSpace; // in bytes
}

@property (readonly) NSString *brickName;
@property (readonly) uint32_t freeSpace; // in bytes

@end
