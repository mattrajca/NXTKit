//
//  MRNXTIOMapResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MRNXTResponse.h"

@interface MRNXTIOMapResponse : MRNXTResponse

@property (readonly) uint32_t moduleID;
@property (readonly) uint16_t bytesRead;
@property (readonly) NSData *contents;

@end
