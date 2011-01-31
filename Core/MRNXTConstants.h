//
//  MRNXTConstants.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

enum _NXTOutputPort {
	NXTOutputPortA = 0,
	NXTOutputPortB,
	NXTOutputPortC,
	NXTOutputPortAll = 0xFF
};
typedef uint8_t NXTOutputPort;

enum _NXTOutputMode {
	NXTOutputModeMotorOn = 0x01,
	NXTOutputModeBrake = 0x02,
	NXTOutputModeRegulated = 0x04
};
typedef uint8_t NXTOutputMode;

enum _NXTRegulationMode {
	NXTRegulationModeIdle = 0x0,
	NXTRegulationModeMotorSpeed = 0x01,
	NXTRegulationModeMotorSync = 0x02
};
typedef uint8_t NXTRegulationMode;

enum _NXTRunState {
	NXTRunStateIdle = 0x0,
	NXTRunStateRampUp = 0x10,
	NXTRunStateRunning = 0x20,
	NXTRunStateRampDown = 0x40
};
typedef uint8_t NXTRunState;

enum _NXTCommandType {
	NXTCommandTypeDirect = 0x0,
	NXTCommandTypeSystem
};
typedef uint8_t NXTCommandType;

enum _NXTStatus {
	NXTStatusSuccess = 0x0,
	NXTNoMoreHandles = 0x81,
	NXTNoSpace = 0x82,
	NXTNoMoreFiles = 0x83,
	NXTEndOfFileExpected = 0x84,
	NXTEndOfFile = 0x85,
	NXTNotALinearFile = 0x86,
	NXTFileNotFound = 0x87,
	NXTHandleAllReadyClosed = 0x88,
	NXTNoLinearSpace = 0x89,
	NXTUndefinedError = 0x8A,
	NXTFileIsBusy = 0x8B,
	NXTNoWriteBuffers = 0x8C,
	NXTAppendNotPossible = 0x8D,
	NXTFileIsFull = 0x8E,
	NXTFileExists = 0x8F,
	NXTModuleNotFound = 0x90,
	NXTOutOfBoundary = 0x91,
	NXTIllegalFileName = 0x92,
	NXTIllegalHandle = 0x93
};
typedef uint8_t NXTStatus;
