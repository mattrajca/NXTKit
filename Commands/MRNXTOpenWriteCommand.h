//
//  MRNXTOpenWriteCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTOpenWriteCommand : MRNXTCommand {
@private
    NSString *filename;
    uint32_t size;
}

@property (copy) NSString *filename;
@property (assign) uint32_t size;

@end
