//
//  MRNXTDataResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTHandleSizeResponse.h"

@interface MRNXTDataResponse : MRNXTHandleSizeResponse {
@private
    NSData *_data;
}

@property (readonly) NSData *data;

@end
