//
//  NSMutableArray+Queue.m
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

#import "NSMutableArray+Queue.h"

@implementation NSMutableArray (Queue)

- (void)mr_push:(id)anObject {
	[self addObject:anObject];
}

- (id)mr_pop {
	if (!self.count) {
		return nil;
	}
	
	id obj = [self objectAtIndex:0];
	[self removeObjectAtIndex:0];
	
	return obj;
}

@end
