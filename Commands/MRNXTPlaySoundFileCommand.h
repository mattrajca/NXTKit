//
//  MRNXTPlaySoundFileCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTPlaySoundFileCommand : MRNXTCommand {
@private
    BOOL loop;
    NSString *filename;
}

@property (assign) BOOL loop;
@property (copy) NSString *filename;

@end
