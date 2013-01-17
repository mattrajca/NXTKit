//
//  MRNXTIOMapResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTResponse.h"

@interface MRNXTIOMapResponse : MRNXTResponse {
@private
    uint32_t moduleID;
    uint16_t bytesRead;
    NSData *contents;
}

@property (readonly) uint32_t moduleID;
@property (readonly) uint16_t bytesRead;
@property (readonly) NSData *contents;

@end
