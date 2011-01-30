//
//  MRNXTResetMotorPositionCommand.h
//  NXTKit
//
//  Copyright Matt Rajca 2010. All rights reserved.
//

#import "MRNXTCommand.h"
#import "MRNXTConstants.h"

@interface MRNXTResetMotorPositionCommand : MRNXTCommand {
  @private
	NXTOutputPort _port;
	BOOL _relative;
}

@property (assign) NXTOutputPort port;
@property (assign) BOOL relative;

@end
