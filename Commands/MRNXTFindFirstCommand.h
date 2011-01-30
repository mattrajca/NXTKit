//
//  MRNXTFindFirstCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTFindFirstCommand : MRNXTCommand {
  @private
	NSString *_filename;
}

@property (copy) NSString *filename;

@end
