//
//  MRNXTFindNextCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTFindNextCommand : MRNXTCommand {
@private
    uint8_t handle;
}

@property (assign) uint8_t handle;

@end
