//
//  MRNXTSetOutputStateCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTCommand.h"
#import "MRNXTConstants.h"

@interface MRNXTSetOutputStateCommand : MRNXTCommand {
  @private
	NXTOutputPort port;
	int8_t power;
	NXTOutputMode outputMode;
	NXTRegulationMode regulationMode;
	int8_t turnRatio;
	NXTRunState runState;
	uint32_t tachoLimit;
}

@property (assign) NXTOutputPort port;
@property (assign) int8_t power;
@property (assign) NXTOutputMode outputMode;
@property (assign) NXTRegulationMode regulationMode;
@property (assign) int8_t turnRatio;
@property (assign) NXTRunState runState;
@property (assign) uint32_t tachoLimit;

@end
