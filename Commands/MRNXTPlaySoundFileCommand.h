//
//  MRNXTPlaySoundFileCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTPlaySoundFileCommand : MRNXTCommand {
  @private
	BOOL _loop;
	NSString *_filename;
}

@property (assign) BOOL loop;
@property (copy) NSString *filename;

@end
