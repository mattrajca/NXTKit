//
//  MRNXTSetOutputStateCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "MRNXTCommand.h"
#import "MRNXTConstants.h"

@interface MRNXTSetOutputStateCommand : MRNXTCommand

@property (assign) NXTOutputPort port;
@property (assign) int8_t power;
@property (assign) NXTOutputMode outputMode;
@property (assign) NXTRegulationMode regulationMode;
@property (assign) int8_t turnRatio;
@property (assign) NXTRunState runState;
@property (assign) uint32_t tachoLimit;

@end
