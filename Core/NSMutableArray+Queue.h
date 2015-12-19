//
//  NSMutableArray+Queue.h
//  NXTKit
//
//  Copyright Matt Rajca 2010-2011. All rights reserved.
//

@interface NSMutableArray<ObjectType> (Queue)

- (void)mr_push:(ObjectType)anObject;
- (ObjectType)mr_pop;

@end
