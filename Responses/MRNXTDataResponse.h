//
//  MRNXTDataResponse.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTHandleSizeResponse.h"

@interface MRNXTDataResponse : MRNXTHandleSizeResponse {
  @private
	NSData *_data;
}

@property (readonly) NSData *data;

@end
