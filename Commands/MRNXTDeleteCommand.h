//
//  MRNXTDeleteCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"

@interface MRNXTDeleteCommand : MRNXTCommand {
@private
    NSString *filename;
}

@property (copy) NSString *filename;

@end
