//
//  MRNXTOpenWriteCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTOpenWriteCommand : MRNXTCommand {
  @private
	NSString *_filename;
	uint32_t _size;
}

@property (copy) NSString *filename;
@property (assign) uint32_t size;

@end
